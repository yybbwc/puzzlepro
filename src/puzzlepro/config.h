#pragma once
//~ #ifndef YGOPRO_CONFIG_H
//~ #define YGOPRO_CONFIG_H

#define _IRR_STATIC_LIB_
//~ #define IRR_COMPILE_WITH_DX9_DEV_PACK

#if defined(_MSC_VER) or defined(__MINGW64__)
#define mywcsncasecmp _wcsnicmp
#define mystrncasecmp _strnicmp
#else
#define mywcsncasecmp wcsncasecmp
#define mystrncasecmp strncasecmp
#endif

#define socklen_t int

template <size_t N, typename... TR> inline int myswprintf(wchar_t (&buf)[N], const wchar_t *fmt, TR... args) {
  return std::swprintf(buf, N, fmt, args...);
}

inline FILE *mywfopen(const wchar_t *filename, const char *mode) {
  FILE *fp{};
  wchar_t wmode[20]{};
  BufferIO::CopyCharArray(mode, wmode);
  fp = _wfopen(filename, wmode);
  return fp;
}

constexpr uint16_t PRO_VERSION = 0x1361;
extern unsigned int enable_log;
extern bool exit_on_return;
extern bool open_file;
extern wchar_t open_file_name[512];
extern bool bot_mode;

//~ #endif
