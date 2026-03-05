#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define CMD_FILE "C:\\c2_cmd.txt"
#define RES_FILE "C:\\c2_res.txt"

static char result[65536];
static int rlen;

static void res_clear(void) { rlen = 0; result[0] = 0; }
static void res_printf(const char *fmt, ...) {
    va_list ap; va_start(ap, fmt);
    rlen += vsprintf(result + rlen, fmt, ap);
    va_end(ap);
}
static void write_result(void) {
    FILE *f = fopen(RES_FILE, "w");
    if (f) { fputs(result, f); fclose(f); }
}
static void chomp(char *s) {
    int n = strlen(s);
    while (n > 0 && (s[n-1]=='\r'||s[n-1]=='\n'||s[n-1]==' ')) s[--n]=0;
}
static char *split1(char *s, char **rest) {
    char *p = strchr(s, ' ');
    if (p) { *p=0; *rest=p+1; } else { *rest=""; }
    return s;
}

static BOOL CALLBACK enum_cb(HWND hw, LPARAM lp) {
    (void)lp;
    WCHAR wcls[256]={0}, wtxt[512]={0};
    char ucls[512]={0}, utxt[1024]={0};
    GetClassNameW(hw, wcls, 255);
    GetWindowTextW(hw, wtxt, 511);
    WideCharToMultiByte(CP_UTF8,0,wcls,-1,ucls,sizeof(ucls),NULL,NULL);
    WideCharToMultiByte(CP_UTF8,0,wtxt,-1,utxt,sizeof(utxt),NULL,NULL);
    res_printf("%u|%s|%d|%s\n", (unsigned)hw, ucls, GetDlgCtrlID(hw), utxt);
    return TRUE;
}

static void handle_cmd(char *line) {
    char *rest, *verb = split1(line, &rest);
    res_clear();

    if (!stricmp(verb,"PING")) {
        res_printf("PONG pid=%lu INJECTED\n", GetCurrentProcessId());
    } else if (!stricmp(verb,"EXIT")) {
        res_printf("BYE\n"); write_result(); ExitThread(0);
    } else if (!stricmp(verb,"FINDWINDOW")) {
        char *c,*t; c=split1(rest,&t);
        res_printf("%u\n",(unsigned)FindWindowA(strcmp(c,"*")?c:NULL,strcmp(t,"*")?t:NULL));
    } else if (!stricmp(verb,"FINDWINDOWEX")) {
        char *a1,*a2,*a3,*a4,*t1,*t2;
        a1=split1(rest,&t1);a2=split1(t1,&t2);a3=split1(t2,&a4);
        res_printf("%u\n",(unsigned)FindWindowExA(
            (HWND)(UINT_PTR)strtoul(a1,NULL,0),(HWND)(UINT_PTR)strtoul(a2,NULL,0),
            strcmp(a3,"*")?a3:NULL,strcmp(a4,"*")?a4:NULL));
    } else if (!stricmp(verb,"GETTEXT")) {
        HWND hw=(HWND)(UINT_PTR)strtoul(rest,NULL,0);
        WCHAR b[512]={0}; char u[1024]={0};
        GetWindowTextW(hw,b,511);
        WideCharToMultiByte(CP_UTF8,0,b,-1,u,sizeof(u),NULL,NULL);
        res_printf("%s\n",u);
    } else if (!stricmp(verb,"GETCLASS")) {
        HWND hw=(HWND)(UINT_PTR)strtoul(rest,NULL,0);
        WCHAR b[256]={0}; char u[512]={0};
        GetClassNameW(hw,b,255);
        WideCharToMultiByte(CP_UTF8,0,b,-1,u,sizeof(u),NULL,NULL);
        res_printf("%s\n",u);
    } else if (!stricmp(verb,"SETTEXT")) {
        char *shw,*txt; shw=split1(rest,&txt);
        HWND hw=(HWND)(UINT_PTR)strtoul(shw,NULL,0);
        WCHAR w[2048]={0};
        MultiByteToWideChar(CP_UTF8,0,txt,-1,w,2048);
        SendMessageW(hw, WM_SETTEXT, 0, (LPARAM)w);
        res_printf("OK\n");
    } else if (!stricmp(verb,"SENDMSG")) {
        char *a1,*a2,*a3,*a4,*t1,*t2;
        a1=split1(rest,&t1);a2=split1(t1,&t2);a3=split1(t2,&a4);
        res_printf("%d\n",(int)SendMessageA(
            (HWND)(UINT_PTR)strtoul(a1,NULL,0),strtoul(a2,NULL,0),
            strtoul(a3,NULL,0),strtoul(a4,NULL,0)));
    } else if (!stricmp(verb,"POSTMSG")) {
        char *a1,*a2,*a3,*a4,*t1,*t2;
        a1=split1(rest,&t1);a2=split1(t1,&t2);a3=split1(t2,&a4);
        PostMessageA((HWND)(UINT_PTR)strtoul(a1,NULL,0),strtoul(a2,NULL,0),
            strtoul(a3,NULL,0),strtoul(a4,NULL,0));
        res_printf("OK\n");
    } else if (!stricmp(verb,"GETDLGITEM")) {
        char *shw,*sid; shw=split1(rest,&sid);
        res_printf("%u\n",(unsigned)GetDlgItem(
            (HWND)(UINT_PTR)strtoul(shw,NULL,0),atoi(sid)));
    } else if (!stricmp(verb,"CLICK")) {
        PostMessageA((HWND)(UINT_PTR)strtoul(rest,NULL,0),BM_CLICK,0,0);
        res_printf("OK\n");
    } else if (!stricmp(verb,"LCLICK")) {
        HWND hw=(HWND)(UINT_PTR)strtoul(rest,NULL,0);
        PostMessageA(hw,WM_LBUTTONDOWN,MK_LBUTTON,0);
        PostMessageA(hw,WM_LBUTTONUP,0,0);
        res_printf("OK\n");
    } else if (!stricmp(verb,"ENUMCHILDREN")) {
        EnumChildWindows((HWND)(UINT_PTR)strtoul(rest,NULL,0),enum_cb,0);
        if(rlen==0) res_printf("(none)\n");
    } else if (!stricmp(verb,"WMCOMMAND")) {
        char *shw,*sid; shw=split1(rest,&sid);
        PostMessageA((HWND)(UINT_PTR)strtoul(shw,NULL,0),WM_COMMAND,atoi(sid),0);
        res_printf("OK\n");
    } else if (!stricmp(verb,"SCREENSHOT")) {
        /* SCREENSHOT <hwnd> <filepath>
         * Captures full window (including title bar/border) to BMP via BitBlt.
         * If hwnd is 0, captures entire desktop. */
        char *shw, *path; shw = split1(rest, &path);
        HWND hw = (HWND)(UINT_PTR)strtoul(shw, NULL, 0);
        HDC hdcSrc = GetDC(NULL); /* always desktop DC for screen coords */
        RECT rc;
        int w, h, sx = 0, sy = 0;
        if (hw) {
            GetWindowRect(hw, &rc); /* full window with chrome */
            sx = rc.left; sy = rc.top;
            w = rc.right - rc.left; h = rc.bottom - rc.top;
        } else {
            w = GetSystemMetrics(SM_CXSCREEN);
            h = GetSystemMetrics(SM_CYSCREEN);
        }
        if (w <= 0 || h <= 0 || !hdcSrc) {
            if (hdcSrc) ReleaseDC(hw, hdcSrc);
            res_printf("ERR: bad window or size %dx%d\n", w, h);
        } else {
            HDC hdcMem = CreateCompatibleDC(hdcSrc);
            HBITMAP hbm = CreateCompatibleBitmap(hdcSrc, w, h);
            SelectObject(hdcMem, hbm);
            BitBlt(hdcMem, 0, 0, w, h, hdcSrc, sx, sy, SRCCOPY);
            ReleaseDC(NULL, hdcSrc);
            /* Write BMP file */
            BITMAPINFOHEADER bi = {0};
            bi.biSize = sizeof(bi);
            bi.biWidth = w;
            bi.biHeight = h; /* bottom-up */
            bi.biPlanes = 1;
            bi.biBitCount = 24;
            bi.biCompression = BI_RGB;
            int stride = ((w * 3 + 3) & ~3);
            int imgsize = stride * h;
            bi.biSizeImage = imgsize;
            char *bits = (char*)malloc(imgsize);
            GetDIBits(hdcMem, hbm, 0, h, bits, (BITMAPINFO*)&bi, DIB_RGB_COLORS);
            BITMAPFILEHEADER bf = {0};
            bf.bfType = 0x4D42; /* 'BM' */
            bf.bfOffBits = sizeof(bf) + sizeof(bi);
            bf.bfSize = bf.bfOffBits + imgsize;
            FILE *fp = fopen(path, "wb");
            if (fp) {
                fwrite(&bf, sizeof(bf), 1, fp);
                fwrite(&bi, sizeof(bi), 1, fp);
                fwrite(bits, imgsize, 1, fp);
                fclose(fp);
                res_printf("OK %dx%d %d bytes\n", w, h, (int)bf.bfSize);
            } else {
                res_printf("ERR: cannot write %s\n", path);
            }
            free(bits);
            DeleteObject(hbm);
            DeleteDC(hdcMem);
        }
    } else if (!stricmp(verb,"SLEEP")) {
        Sleep(atoi(rest)); res_printf("OK\n");
    } else {
        res_printf("ERR: unknown: %s\n",verb);
    }
    write_result();
}

static DWORD WINAPI c2_thread(LPVOID param) {
    (void)param;
    DeleteFileA(CMD_FILE);
    res_clear();
    res_printf("C2 INJECTED pid=%lu\n", GetCurrentProcessId());
    write_result();

    for (;;) {
        Sleep(100);
        FILE *f = fopen(CMD_FILE, "r");
        if (!f) continue;
        char line[4096]={0};
        fgets(line, sizeof(line), f);
        fclose(f);
        DeleteFileA(CMD_FILE);
        chomp(line);
        if (line[0]) handle_cmd(line);
    }
    return 0;
}

BOOL APIENTRY DllMain(HINSTANCE hInst, DWORD reason, LPVOID reserved) {
    (void)hInst; (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) {
        CreateThread(NULL, 0, c2_thread, NULL, 0, NULL);
    }
    return TRUE;
}
