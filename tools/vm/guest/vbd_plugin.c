/*
 * VB Decompiler Pro v9.8 Plugin — Full Data Extractor
 *
 * Triggered by writing to C:\plugin_cmd.txt. Dumps all decompiled data
 * via the callback API to C:\output\<exename>\ directory tree.
 *
 * Build: i686-w64-mingw32-gcc -shared -O2 -Wl,--kill-at -o vbd_extract.dll vbd_plugin.c -luser32
 * Deploy: copy to C:\Tools\VBDecompiler\Plugins\
 *
 * Plugin API reference: https://www.vb-decompiler.org/plugins_sdk.htm
 * Exports are stdcall with signature:
 *   void __stdcall Func(HWND mainWnd, HWND richEditWnd, char* buffer, int/void* reserved_or_engine);
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <direct.h>

#define CMD_FILE  "C:\\plugin_cmd.txt"
#define DONE_FILE "C:\\plugin_done.txt"
#define ERR_FILE  "C:\\plugin_err.txt"
#define BASE_DIR  "C:\\output"
#define LOG_FILE  "C:\\plugin_debug.log"

static void dbglog(const char *fmt, ...) {
    FILE *f = fopen(LOG_FILE, "a");
    if (f) {
        va_list ap; va_start(ap, fmt);
        vfprintf(f, fmt, ap);
        fprintf(f, "\n");
        fflush(f);
        va_end(ap);
        fclose(f);
    }
}

/* Plugin API call IDs (vlType) */
#define API_GET_PROJECT          1
#define API_GET_FILENAME         3
#define API_IS_NATIVE            4
#define API_GET_COMPILER         6
#define API_IS_PACKED            7
#define API_SET_STACK_CB         8
#define API_SET_ANALYZER_CB      9
#define API_GET_FORM_NAME       10
#define API_GET_FORM            12
#define API_GET_FORM_COUNT      14
#define API_GET_SUB_MAIN        20
#define API_GET_MOD_NAME        30
#define API_GET_MODULE          32
#define API_GET_MOD_STRINGS     34
#define API_GET_MOD_COUNT       36
#define API_GET_FUNC_NAME       40
#define API_GET_FUNC_ADDR       42
#define API_GET_FUNC            44
#define API_GET_FUNC_STRREF     46
#define API_GET_FUNC_COUNT      48
#define API_GET_ACTIVE_TEXT     50
#define API_GET_ACTIVE_DISASM   52
#define API_GET_FRX_ICON_COUNT  60
#define API_GET_FRX_ICON_OFF    61
#define API_GET_FRX_ICON_SIZE   62
#define API_GET_FUNC_DISASM     70
#define API_UPDATE_ALL         100

/* Callback engine pointer — set by VBDecompilerPluginLoad (4th param) */
typedef wchar_t* (__stdcall *TVBDPluginEngine)(int vlType, int vlNumber,
                                                int vlFnNumber, char *vlNewValue);
static TVBDPluginEngine g_engine = NULL;
static HANDLE g_thread = NULL;

/* Helper: call engine, return UTF-8 string (caller must free) */
static char *cb_call(int type, int num, int fn) {
    if (!g_engine) return _strdup("");
    wchar_t *w = g_engine(type, num, fn, NULL);
    if (!w || !w[0]) return _strdup("");
    int len = WideCharToMultiByte(CP_UTF8, 0, w, -1, NULL, 0, NULL, NULL);
    char *u = (char *)malloc(len + 1);
    WideCharToMultiByte(CP_UTF8, 0, w, -1, u, len + 1, NULL, NULL);
    return u;
}

static int cb_int(int type, int num, int fn) {
    char *s = cb_call(type, num, fn);
    int v = atoi(s);
    free(s);
    return v;
}

static void cb_set(int type, int value) {
    char val[2] = { value ? '1' : '0', 0 };
    if (g_engine) g_engine(type, 0, 0, val);
}

/* Helper: mkdir -p */
static void mkdirp(const char *path) {
    char tmp[MAX_PATH];
    strncpy(tmp, path, MAX_PATH - 1); tmp[MAX_PATH - 1] = 0;
    for (char *p = tmp + 1; *p; p++) {
        if (*p == '\\' || *p == '/') { *p = 0; _mkdir(tmp); *p = '\\'; }
    }
    _mkdir(tmp);
}

static void write_file(const char *path, const char *data) {
    FILE *f = fopen(path, "wb");
    if (f) { fwrite("\xEF\xBB\xBF", 1, 3, f); fputs(data, f); fclose(f); }
}

static void sanitize(char *name) {
    for (char *p = name; *p; p++)
        if (*p=='\\' || *p=='/' || *p==':' || *p=='*' ||
            *p=='?' || *p=='"' || *p=='<' || *p=='>' || *p=='|') *p = '_';
}

static void get_basename(const char *path, char *out, int maxlen) {
    const char *slash = strrchr(path, '\\');
    if (!slash) slash = strrchr(path, '/');
    const char *base = slash ? slash + 1 : path;
    strncpy(out, base, maxlen - 1); out[maxlen - 1] = 0;
    char *dot = strrchr(out, '.'); if (dot) *dot = 0;
    sanitize(out);
}

/* Main extraction routine */
static void do_extract(void) {
    if (!g_engine) {
        dbglog("do_extract: engine is NULL");
        write_file(ERR_FILE, "Plugin engine not initialized — activate plugin from Plugins menu first");
        return;
    }
    dbglog("do_extract: starting");

    char *filename = cb_call(API_GET_FILENAME, 0, 0);
    if (!filename[0]) {
        free(filename);
        write_file(ERR_FILE, "No file loaded in VB Decompiler");
        return;
    }

    char exename[256];
    get_basename(filename, exename, sizeof(exename));
    char outdir[MAX_PATH];
    snprintf(outdir, MAX_PATH, "%s\\%s", BASE_DIR, exename);
    mkdirp(outdir);

    char path[MAX_PATH];
    char *data;
    FILE *log;

    snprintf(path, MAX_PATH, "%s\\extract.log", outdir);
    log = fopen(path, "w");
    if (log) fprintf(log, "Extracting: %s\n", filename);

    /* --- Global info --- */
    snprintf(path, MAX_PATH, "%s\\info.txt", outdir);
    {
        char *is_native = cb_call(API_IS_NATIVE, 0, 0);
        char *compiler  = cb_call(API_GET_COMPILER, 0, 0);
        char *is_packed = cb_call(API_IS_PACKED, 0, 0);
        FILE *f = fopen(path, "w");
        if (f) {
            fprintf(f, "filename=%s\nnative=%s\ncompiler=%s\npacked=%s\n",
                    filename, is_native, compiler, is_packed);
            fclose(f);
        }
        free(is_native); free(compiler); free(is_packed);
    }

    /* --- VB Project text --- */
    data = cb_call(API_GET_PROJECT, 0, 0);
    snprintf(path, MAX_PATH, "%s\\project.vbp", outdir);
    write_file(path, data);
    free(data);
    if (log) fprintf(log, "  project.vbp\n");

    /* --- Sub Main --- */
    data = cb_call(API_GET_SUB_MAIN, 0, 0);
    if (data[0]) {
        snprintf(path, MAX_PATH, "%s\\sub_main.txt", outdir);
        write_file(path, data);
        if (log) fprintf(log, "  sub_main.txt\n");
    }
    free(data);

    /* --- Forms --- */
    int nforms = cb_int(API_GET_FORM_COUNT, 0, 0);
    if (log) fprintf(log, "  forms: %d\n", nforms);
    if (nforms > 0) {
        char formdir[MAX_PATH];
        snprintf(formdir, MAX_PATH, "%s\\forms", outdir);
        mkdirp(formdir);
        for (int i = 0; i < nforms; i++) {
            char *fname = cb_call(API_GET_FORM_NAME, i, 0);
            char safe[256];
            strncpy(safe, fname[0] ? fname : "form", sizeof(safe) - 1);
            safe[sizeof(safe) - 1] = 0; sanitize(safe);
            data = cb_call(API_GET_FORM, i, 0);
            snprintf(path, MAX_PATH, "%s\\%s.frm", formdir, safe);
            write_file(path, data);
            free(data);
            if (log) fprintf(log, "    form[%d] %s\n", i, fname);
            free(fname);
        }
    }

    /* --- Modules --- */
    int nmods = cb_int(API_GET_MOD_COUNT, 0, 0);
    if (log) fprintf(log, "  modules: %d\n", nmods);
    if (nmods > 0) {
        char moddir[MAX_PATH];
        snprintf(moddir, MAX_PATH, "%s\\modules", outdir);
        mkdirp(moddir);
        for (int m = 0; m < nmods; m++) {
            char *mname = cb_call(API_GET_MOD_NAME, m, 0);
            char msafe[256];
            strncpy(msafe, mname[0] ? mname : "module", sizeof(msafe) - 1);
            msafe[sizeof(msafe) - 1] = 0; sanitize(msafe);

            data = cb_call(API_GET_MODULE, m, 0);
            if (data[0]) {
                snprintf(path, MAX_PATH, "%s\\%s.declarations", moddir, msafe);
                write_file(path, data);
            }
            free(data);

            data = cb_call(API_GET_MOD_STRINGS, m, 0);
            if (data[0]) {
                snprintf(path, MAX_PATH, "%s\\%s.strings", moddir, msafe);
                write_file(path, data);
            }
            free(data);

            int nfuncs = cb_int(API_GET_FUNC_COUNT, m, 0);
            if (log) fprintf(log, "    mod[%d] %s — %d funcs\n", m, mname, nfuncs);
            if (nfuncs > 0) {
                char funcdir[MAX_PATH];
                snprintf(funcdir, MAX_PATH, "%s\\%s_funcs", moddir, msafe);
                mkdirp(funcdir);
                for (int f = 0; f < nfuncs; f++) {
                    char *fn_name = cb_call(API_GET_FUNC_NAME, m, f);
                    char *fn_addr = cb_call(API_GET_FUNC_ADDR, m, f);
                    char fsafe[256];
                    if (fn_addr[0] && fn_name[0])
                        snprintf(fsafe, sizeof(fsafe), "%s_%s", fn_addr, fn_name);
                    else if (fn_name[0])
                        strncpy(fsafe, fn_name, sizeof(fsafe) - 1);
                    else
                        snprintf(fsafe, sizeof(fsafe), "func_%d", f);
                    fsafe[sizeof(fsafe) - 1] = 0; sanitize(fsafe);

                    data = cb_call(API_GET_FUNC, m, f);
                    if (data[0]) {
                        snprintf(path, MAX_PATH, "%s\\%s.vb", funcdir, fsafe);
                        write_file(path, data);
                    }
                    free(data);

                    data = cb_call(API_GET_FUNC_DISASM, m, f);
                    if (data[0]) {
                        snprintf(path, MAX_PATH, "%s\\%s.asm", funcdir, fsafe);
                        write_file(path, data);
                    }
                    free(data);

                    data = cb_call(API_GET_FUNC_STRREF, m, f);
                    if (data[0]) {
                        snprintf(path, MAX_PATH, "%s\\%s.strings", funcdir, fsafe);
                        write_file(path, data);
                    }
                    free(data);

                    free(fn_name); free(fn_addr);
                }
            }
            free(mname);
        }
    }

    /* --- FRX resource info --- */
    int nicons = cb_int(API_GET_FRX_ICON_COUNT, 0, 0);
    if (nicons > 0) {
        snprintf(path, MAX_PATH, "%s\\frx_info.txt", outdir);
        FILE *f = fopen(path, "w");
        if (f) {
            fprintf(f, "frx_icon_count=%d\n", nicons);
            for (int i = 0; i < nicons; i++) {
                char *off = cb_call(API_GET_FRX_ICON_OFF, i, 0);
                char *sz  = cb_call(API_GET_FRX_ICON_SIZE, i, 0);
                fprintf(f, "icon[%d] offset=%s size=%s\n", i, off, sz);
                free(off); free(sz);
            }
            fclose(f);
        }
        if (log) fprintf(log, "  frx icons: %d\n", nicons);
    }

    if (log) { fprintf(log, "DONE\n"); fclose(log); }
    free(filename);
    write_file(DONE_FILE, exename);
    dbglog("do_extract: done -> %s", exename);
}

/* Poll thread */
static DWORD WINAPI poll_thread(LPVOID param) {
    (void)param;
    dbglog("poll_thread started, engine=%p", (void*)g_engine);
    for (;;) {
        Sleep(200);
        FILE *f = fopen(CMD_FILE, "r");
        if (!f) continue;
        char cmd[16] = {0};
        fgets(cmd, sizeof(cmd), f);
        fclose(f);
        DeleteFileA(CMD_FILE);
        DeleteFileA(DONE_FILE);
        DeleteFileA(ERR_FILE);
        dbglog("cmd: %s", cmd);
        if (cmd[0] == 'E' || cmd[0] == 'e') break;
        do_extract();
    }
    return 0;
}

/* === Exports — correct VBD plugin API signatures === */

__declspec(dllexport) void __stdcall VBDecompilerPluginName(
    HWND hMain, HWND hRich, char *buf, int reserved)
{
    (void)hMain; (void)hRich; (void)reserved;
    strcpy(buf, "Full Data Extractor");
}

__declspec(dllexport) void __stdcall VBDecompilerPluginAuthor(
    HWND hMain, HWND hRich, char *buf, int reserved)
{
    (void)hMain; (void)hRich; (void)reserved;
    strcpy(buf, "AOL Underground");
}

__declspec(dllexport) void __stdcall VBDecompilerPluginLoad(
    HWND hMain, HWND hRich, char *buf, void *engine)
{
    (void)hMain; (void)hRich; (void)buf;
    g_engine = (TVBDPluginEngine)engine;
    dbglog("PluginLoad: main=%p rich=%p engine=%p", (void*)hMain, (void*)hRich, engine);

    /* Enable quality options */
    cb_set(API_SET_STACK_CB, 1);
    cb_set(API_SET_ANALYZER_CB, 1);
    dbglog("checkboxes set");

    /* Quick test */
    char *fn = cb_call(API_GET_FILENAME, 0, 0);
    dbglog("filename='%s'", fn);
    free(fn);
}

BOOL APIENTRY DllMain(HINSTANCE hInst, DWORD reason, LPVOID reserved) {
    (void)hInst; (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) {
        dbglog("DllMain ATTACH");
        g_thread = CreateThread(NULL, 0, poll_thread, NULL, 0, NULL);
        dbglog("thread=%p err=%lu", (void*)g_thread, GetLastError());
    }
    return TRUE;
}
