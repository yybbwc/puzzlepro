local target_name = "ogg"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/"
    for i = 1, #k1 do
      add_includedirs(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include/"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  before_build(function(target)
    os.cd(dir_path)
    if os.exists("include/ogg/config_types.h") then
    else
      do
        local k1 = {}
        k1[#k1 + 1] = "cmake . -DCMAKE_POLICY_VERSION_MINIMUM=3.5"
        for i = 1, #k1 do
          os.exec(k1[i])
        end
      end
    end
  end)
end
