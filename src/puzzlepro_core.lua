local target_name = "puzzlepro_core"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    if is_mode("debug") then
      --~ k1[#k1 + 1] = "build.sanitizer.address"
    end
    for i = 1, #k1 do
      set_policy(k1[i], true)
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "lua_dll"
    k1[#k1 + 1] = "fast_io"
    k1[#k1 + 1] = "LuaBridge3"
    k1[#k1 + 1] = "boost"
    for i = 1, #k1 do
      add_deps(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "ntdll"
    for i = 1, #k1 do
      add_links(k1[i], { public = true })
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
    k1[#k1 + 1] = dir_path .. "*.cpp"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
