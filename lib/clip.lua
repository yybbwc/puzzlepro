local target_name = "clip"
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
    k1[#k1 + 1] = dir_path .. "clip_win.cpp"
    k1[#k1 + 1] = dir_path .. "clip.cpp"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
