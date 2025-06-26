
local target_name = "penlight"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("headeronly")
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
end
