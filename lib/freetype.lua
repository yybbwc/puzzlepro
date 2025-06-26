
local target_name = "freetype"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "bzip2"
    k1[#k1 + 1] = "zlib"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "build/include"
    k1[#k1 + 1] = dir_path .. "include"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "FT2_BUILD_LIBRARY"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/autofit/autofit.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftbase.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftbbox.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftbdf.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftbitmap.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftcid.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftfstype.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftgasp.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftglyph.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftgxval.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftinit.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftmm.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftotval.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftpatent.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftpfr.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftstroke.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftsynth.c"
    k1[#k1 + 1] = dir_path .. "src/base/fttype1.c"
    k1[#k1 + 1] = dir_path .. "src/base/ftwinfnt.c"
    k1[#k1 + 1] = dir_path .. "src/bdf/bdf.c"
    k1[#k1 + 1] = dir_path .. "src/cache/ftcache.c"
    k1[#k1 + 1] = dir_path .. "src/cff/cff.c"
    k1[#k1 + 1] = dir_path .. "src/cid/type1cid.c"
    k1[#k1 + 1] = dir_path .. "src/gzip/ftgzip.c"
    k1[#k1 + 1] = dir_path .. "src/bzip2/ftbzip2.c"
    k1[#k1 + 1] = dir_path .. "src/lzw/ftlzw.c"
    k1[#k1 + 1] = dir_path .. "src/pcf/pcf.c"
    k1[#k1 + 1] = dir_path .. "src/pfr/pfr.c"
    k1[#k1 + 1] = dir_path .. "src/psaux/psaux.c"
    k1[#k1 + 1] = dir_path .. "src/pshinter/pshinter.c"
    k1[#k1 + 1] = dir_path .. "src/psnames/psnames.c"
    k1[#k1 + 1] = dir_path .. "src/raster/raster.c"
    k1[#k1 + 1] = dir_path .. "src/sfnt/sfnt.c"
    k1[#k1 + 1] = dir_path .. "src/sdf/sdf.c"
    k1[#k1 + 1] = dir_path .. "src/smooth/smooth.c"
    k1[#k1 + 1] = dir_path .. "src/truetype/truetype.c"
    k1[#k1 + 1] = dir_path .. "src/type1/type1.c"
    k1[#k1 + 1] = dir_path .. "src/type42/type42.c"
    k1[#k1 + 1] = dir_path .. "src/winfonts/winfnt.c"
    k1[#k1 + 1] = dir_path .. "src/svg/ftsvg.c"
    if is_plat("windows") then
      k1[#k1 + 1] = dir_path .. "builds/windows/ftsystem.c"
      k1[#k1 + 1] = dir_path .. "builds/windows/ftdebug.c"
    end
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  before_build(function(target)
    os.cd(dir_path)
    if os.exists("build") then
    else
      os.mkdir("build")
      os.cd("build")
      os.exec("cmake ..")
      io.gsub("include/freetype/config/ftoption.h", "#define FT_CONFIG_OPTION_USE_BROTLI", "//#define FT_CONFIG_OPTION_USE_BROTLI", {plain = true})
    end
  end)
end
