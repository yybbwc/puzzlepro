
local target_name = "lzma"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("static")
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "LITTLE_ENDIAN"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "ws2_32"
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
    --~ k1[#k1 + 1] = "LITTLE_ENDIAN"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
