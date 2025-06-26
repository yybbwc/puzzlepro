
local target_name = "pegtl"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("headeronly")
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
end
