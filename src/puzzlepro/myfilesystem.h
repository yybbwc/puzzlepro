#pragma once

namespace FileSystem {
  //~ public:
  static void SafeFileName(wchar_t *wfile) {
    while ((wfile = std::wcspbrk(wfile, L"<>:\"/\\|?*")) != nullptr) {
      *wfile++ = '_';
    }
  }

  static bool IsFileExists(const wchar_t *wfile) {
    DWORD attr = GetFileAttributesW(wfile);
    return attr != INVALID_FILE_ATTRIBUTES && !(attr & FILE_ATTRIBUTE_DIRECTORY);
  }

  static bool IsFileExists(const char *file) {
    wchar_t wfile[1024];
    BufferIO::DecodeUTF8(file, wfile);
    return IsFileExists(wfile);
  }

  static bool IsDirExists(const wchar_t *wdir) {
    DWORD attr = GetFileAttributesW(wdir);
    return attr != INVALID_FILE_ATTRIBUTES && (attr & FILE_ATTRIBUTE_DIRECTORY);
  }

  static bool IsDirExists(const char *dir) {
    wchar_t wdir[1024];
    BufferIO::DecodeUTF8(dir, wdir);
    return IsDirExists(wdir);
  }

  static bool MakeDir(const wchar_t *wdir) {
    return CreateDirectoryW(wdir, nullptr);
  }

  static bool MakeDir(const char *dir) {
    wchar_t wdir[1024];
    BufferIO::DecodeUTF8(dir, wdir);
    return MakeDir(wdir);
  }

  static bool Rename(const wchar_t *woldname, const wchar_t *wnewname) {
    return MoveFileW(woldname, wnewname);
  }

  static bool Rename(const char *oldname, const char *newname) {
    wchar_t woldname[1024];
    wchar_t wnewname[1024];
    BufferIO::DecodeUTF8(oldname, woldname);
    BufferIO::DecodeUTF8(newname, wnewname);
    return Rename(woldname, wnewname);
  }

  static bool DeleteDir(const wchar_t *wdir) {
    wchar_t pdir[256];
    BufferIO::CopyWideString(wdir, pdir);
    SHFILEOPSTRUCTW lpFileOp{};
    lpFileOp.hwnd = nullptr;
    lpFileOp.wFunc = FO_DELETE;
    lpFileOp.pFrom = pdir;
    lpFileOp.pTo = nullptr;
    lpFileOp.fFlags = FOF_ALLOWUNDO | FOF_NOCONFIRMATION | FOF_NOERRORUI | FOF_SILENT;
    return SHFileOperationW(&lpFileOp) == 0;
  }

  static bool DeleteDir(const char *dir) {
    wchar_t wdir[1024];
    BufferIO::DecodeUTF8(dir, wdir);
    return DeleteDir(wdir);
  }

  static bool RemoveFile(const wchar_t *wfile) {
    return DeleteFileW(wfile);
  }

  static bool RemoveFile(const char *file) {
    return DeleteFileA(file);
  }

  static void TraversalDir(const wchar_t *wpath, const std::function<void(const wchar_t *, bool)> &cb) {
    wchar_t findstr[1024];
    std::swprintf(findstr, sizeof(findstr) / sizeof(wchar_t), L"%ls/*", wpath);
    WIN32_FIND_DATAW fdataw;
    HANDLE fh = FindFirstFileW(findstr, &fdataw);
    if (fh == INVALID_HANDLE_VALUE) {
      return;
    }
    do {
      if (std::wcscmp(fdataw.cFileName, L".") != 0 && std::wcscmp(fdataw.cFileName, L"..") != 0) {
        cb(fdataw.cFileName, (fdataw.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY));
      }
    } while (FindNextFileW(fh, &fdataw));
    FindClose(fh);
  }
} // namespace FileSystem

//~ #endif // FILESYSTEM_H
