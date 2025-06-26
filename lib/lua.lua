local target_name = "lua"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("binary")
  do
    local k1 = {}
    k1[#k1 + 1] = "lua_dll"
    for i = 1, #k1 do
      add_deps(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/lua.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
local target_name = "lua_dll"
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
    k1[#k1 + 1] = "LUA_UCID"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/*.c|luac.c|lua.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
