
#pragma once

#include "CFileList.h"

namespace irr {
  namespace io {
    class file_list : public CFileList {
    public:
      file_list(const io::path& path, bool ignoreCase, bool ignorePaths) : CFileList(path, ignoreCase, ignorePaths) {}
      
      //~ void set_reverse_sort(bool o1 = false);
      void reverse_sort();
      
      //~ bool reverse_sort_should = false;
    };

  } // namespace io
} // namespace irr
