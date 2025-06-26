local target_name = "libpng"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "zlib"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "PNG_INTEL_SSE_OPT=0"
    k1[#k1 + 1] = "PNG_BUILD_DLL"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "png.c"
    k1[#k1 + 1] = dir_path .. "pngerror.c"
    k1[#k1 + 1] = dir_path .. "pngget.c"
    k1[#k1 + 1] = dir_path .. "pngmem.c"
    k1[#k1 + 1] = dir_path .. "pngpread.c"
    k1[#k1 + 1] = dir_path .. "pngread.c"
    k1[#k1 + 1] = dir_path .. "pngrio.c"
    k1[#k1 + 1] = dir_path .. "pngrtran.c"
    k1[#k1 + 1] = dir_path .. "pngrutil.c"
    k1[#k1 + 1] = dir_path .. "pngset.c"
    k1[#k1 + 1] = dir_path .. "pngtrans.c"
    k1[#k1 + 1] = dir_path .. "pngwio.c"
    k1[#k1 + 1] = dir_path .. "pngwrite.c"
    k1[#k1 + 1] = dir_path .. "pngwtran.c"
    k1[#k1 + 1] = dir_path .. "pngwutil.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  before_build(function(target)
    os.cd(dir_path)
    if os.exists("pnglibconf.h") then
    else
      do
        local k1 = {}
        k1[#k1 + 1] = "cmake ."
        k1[#k1 + 1] = "cmake -DOUTPUT=pnglibconf.c -P scripts/cmake/gensrc.cmake"
        k1[#k1 + 1] = "cmake -DINPUT=pnglibconf.c -DOUTPUT=pnglibconf.out -P scripts/cmake/genout.cmake"
        k1[#k1 + 1] = "cmake -DOUTPUT=pnglibconf.h -P scripts/cmake/gensrc.cmake"
        for i = 1, #k1 do
          os.exec(k1[i])
        end
      end
      io.gsub("pnglibconf.h", "PNG_ZLIB_VERNUM 0x1310", "PNG_ZLIB_VERNUM 0x1311")
    end
  end)
end
