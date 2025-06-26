local target_name = "luafilesystem"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  set_basename("lfs")
  do
    local k1 = {}
    k1[#k1 + 1] = "lua_dll"
    for i = 1, #k1 do
      add_deps(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/lfs.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
