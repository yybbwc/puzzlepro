
local target_name = "ygopro_1"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("binary")
  do
    local k1 = {}
    k1[#k1 + 1] = "irrlicht_1"
    k1[#k1 + 1] = "freetype"
    k1[#k1 + 1] = "ocgcore"
    k1[#k1 + 1] = "libevent"
    k1[#k1 + 1] = "sqlite3"
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
    k1[#k1 + 1] = dir_path .. "gframe/*.cpp"
    k1[#k1 + 1] = dir_path .. "gframe/lzma/*.c"
    k1[#k1 + 1] = dir_path .. "gframe/spmemvfs/*.c"
    k1[#k1 + 1] = dir_path .. "resource/gframe/*.rc"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
