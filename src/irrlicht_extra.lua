
local target_name = "irrlicht_extra"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  --~ set_policy("build.sanitizer.address", true)
  do
    local k1 = {}
    k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
  do
    local k1 = {}
    if is_mode("debug") then
      --~ k1[#k1 + 1] = "build.sanitizer.address"
      --~ k1[#k1 + 1] = "build.sanitizer.undefined"
    end
    for i = 1, #k1 do
      set_policy(k1[i], true)
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "freetype"
    k1[#k1 + 1] = "irrlicht"
    --~ k1[#k1 + 1] = "irrlicht_1"
    --~ k1[#k1 + 1] = "fast_io"
    --~ k1[#k1 + 1] = "libpng"
    --~ k1[#k1 + 1] = "bzip2"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = "opengl32"
    --~ k1[#k1 + 1] = "gdi32"
    --~ k1[#k1 + 1] = "winmm"
    --~ k1[#k1 + 1] = "imm32"
    --~ for i = 1, #k1 do
      --~ add_links(k1[i], { public = true })
    --~ end
  --~ end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/include"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = dir_path .. "source/Irrlicht/jpeglib"
    --~ for i = 1, #k1 do
      --~ add_includedirs(k1[i])
    --~ end
  --~ end
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = "_IRR_WCHAR_FILESYSTEM"
    --~ k1[#k1 + 1] = "UNICODE"
    --~ k1[#k1 + 1] = "_UNICODE"
    --~ for i = 1, #k1 do
      --~ add_defines(k1[i], { public = true })
    --~ end
  --~ end
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = "_IRR_STATIC_LIB_"
    --~ for i = 1, #k1 do
      --~ add_defines(k1[i])
    --~ end
  --~ end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "*.cpp"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/*.cpp"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/aesGladman/*.cpp"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jaricom.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcapimin.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcapistd.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcarith.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jccoefct.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jccolor.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcdctmgr.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jchuff.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcinit.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcmainct.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcmarker.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcmaster.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcomapi.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcparam.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcprepct.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jcsample.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jctrans.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdapimin.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdapistd.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdarith.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdatadst.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdatasrc.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdcoefct.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdcolor.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jddctmgr.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdhuff.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdinput.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdmainct.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdmarker.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdmaster.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdmerge.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdpostct.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdsample.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jdtrans.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jerror.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jfdctflt.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jfdctfst.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jfdctint.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jidctflt.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jidctfst.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jidctint.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jmemmgr.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jmemnobs.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jquant1.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jquant2.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/jpeglib/jutils.c"
    --~ k1[#k1 + 1] = dir_path .. "irrlicht/source/Irrlicht/lzma/*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  --~ before_build(function(target)
    --~ os.rm(dir_path .. "irrlicht/source/Irrlicht/CIrrDeviceWin32.h")
    --~ os.rm(dir_path .. "irrlicht/source/Irrlicht/CIrrDeviceWin32.cpp")
  --~ end)
end
