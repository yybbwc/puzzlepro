#pragma once

#include "file_list.h"
#include <algorithm>

namespace irr {
  namespace io {

    void file_list::reverse_sort() {
      std::sort(&Files[0], &Files[0] + Files.size(), [](const SFileListEntry &a, const SFileListEntry &b) {
        if (a.IsDirectory != b.IsDirectory) {
          return a.IsDirectory;
        }
        else if (a.Name == L"..") {
          return true;
        }
        else if (b.Name == L"..") {
          return false;
        }
        else {
          return !(a.FullName.lower_ignore_case(b.FullName) > 0);
        }
      });
    }

  } // namespace io
} // namespace irr
