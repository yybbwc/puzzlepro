local target_name = "zlib"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "HAVE_HIDDEN"
    k1[#k1 + 1] = "ZLIB_BUILD"
    k1[#k1 + 1] = "ZLIB_DLL"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  before_build(function(target)
    os.cd(dir_path)
    if os.exists("zconf.h") then
    else
      do
        local k1 = {}
        k1[#k1 + 1] = "cmake ."
        for i = 1, #k1 do
          os.exec(k1[i])
        end
      end
    end
  end)
end
