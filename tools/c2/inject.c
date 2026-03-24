#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <tlhelp32.h>

/*
 * Injector: finds VB Decompiler, injects c2dll.dll via CreateRemoteThread+LoadLibrary
 */

static DWORD find_pid(const char *name) {
    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    PROCESSENTRY32 pe = { .dwSize = sizeof(pe) };
    DWORD pid = 0;
    if (Process32First(snap, &pe)) {
        do {
            if (strstr(pe.szExeFile, name)) { pid = pe.th32ProcessID; break; }
        } while (Process32Next(snap, &pe));
    }
    CloseHandle(snap);
    return pid;
}

int main(void) {
    const char *dllPath = "C:\\c2dll.dll";

    DWORD pid = find_pid("VB Decompiler");
    if (!pid) { printf("ERR: VB Decompiler not found\n"); return 1; }
    printf("Found VB Decompiler pid=%lu\n", pid);

    HANDLE hProc = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pid);
    if (!hProc) { printf("ERR: OpenProcess failed %lu\n", GetLastError()); return 1; }

    SIZE_T sz = strlen(dllPath) + 1;
    LPVOID remote = VirtualAllocEx(hProc, NULL, sz, MEM_COMMIT, PAGE_READWRITE);
    if (!remote) { printf("ERR: VirtualAllocEx failed\n"); return 1; }

    WriteProcessMemory(hProc, remote, dllPath, sz, NULL);

    HMODULE hK32 = GetModuleHandleA("kernel32.dll");
    FARPROC pLoadLib = GetProcAddress(hK32, "LoadLibraryA");

    HANDLE hThread = CreateRemoteThread(hProc, NULL, 0,
        (LPTHREAD_START_ROUTINE)pLoadLib, remote, 0, NULL);
    if (!hThread) { printf("ERR: CreateRemoteThread failed %lu\n", GetLastError()); return 1; }

    WaitForSingleObject(hThread, 10000);
    DWORD exitCode = 0;
    GetExitCodeThread(hThread, &exitCode);
    printf("Injected! LoadLibrary returned %lu\n", exitCode);

    CloseHandle(hThread);
    VirtualFreeEx(hProc, remote, 0, MEM_RELEASE);
    CloseHandle(hProc);
    return 0;
}
