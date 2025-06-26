
local target_name = "irrlicht1-8-4"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "libpng"
    k1[#k1 + 1] = "bzip2"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "opengl32"
    k1[#k1 + 1] = "gdi32"
    k1[#k1 + 1] = "winmm"
    k1[#k1 + 1] = "ole32"
    k1[#k1 + 1] = "oleaut32"
    k1[#k1 + 1] = "imm32"
    k1[#k1 + 1] = "wbemuuid"
    for i = 1, #k1 do
      add_links(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib"
    for i = 1, #k1 do
      add_includedirs(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "_IRR_STATIC_LIB_"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "_IRR_WCHAR_FILESYSTEM"
    k1[#k1 + 1] = "UNICODE"
    k1[#k1 + 1] = "_UNICODE"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/*.cpp"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/aesGladman/*.cpp"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jaricom.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcapimin.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcapistd.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcarith.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jccoefct.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jccolor.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcdctmgr.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jchuff.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcinit.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcmainct.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcmarker.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcmaster.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcomapi.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcparam.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcprepct.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jcsample.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jctrans.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdapimin.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdapistd.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdarith.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdatadst.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdatasrc.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdcoefct.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdcolor.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jddctmgr.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdhuff.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdinput.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdmainct.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdmarker.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdmaster.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdmerge.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdpostct.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdsample.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jdtrans.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jerror.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jfdctflt.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jfdctfst.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jfdctint.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jidctflt.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jidctfst.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jidctint.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jmemmgr.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jmemnobs.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jquant1.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jquant2.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib/jutils.c"
    k1[#k1 + 1] = dir_path .. "source/Irrlicht/lzma/*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  --~ before_build(function(target)
    --~ os.rm(dir_path .. "irrlicht/source/Irrlicht/CFileSystem.cpp")
    --~ os.rm(dir_path .. "irrlicht/source/Irrlicht/CFileSystem.h")
  --~ end)
end
--~ local target_name = "irrlicht_GUIEditor"
--~ target(target_name)
--~ do
  --~ set_kind("binary")
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = "irrlicht"
    --~ k1[#k1 + 1] = "bzip2"
    --~ for i = 1, #k1 do
      --~ add_deps(k1[i])
    --~ end
  --~ end
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = dir_path .. "tools/GUIEditor/*.cpp"
    --~ for i = 1, #k1 do
      --~ add_files(k1[i])
    --~ end
  --~ end
--~ end
