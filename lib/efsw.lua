local target_name = "efsw"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include"
    k1[#k1 + 1] = dir_path .. "src"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/efsw/*.cpp"
    k1[#k1 + 1] = dir_path .. "src/efsw/platform/win/*.cpp"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  --~ do
    --~ local k1 = {}
    --~ k1[#k1 + 1] = "在构建后复制文件"
    --~ for i = 1, #k1 do
      --~ add_rules(k1[i])
    --~ end
  --~ end
end
