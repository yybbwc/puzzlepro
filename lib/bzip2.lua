local target_name = "bzip2"
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
    k1[#k1 + 1] = "_FILE_OFFSET_BITS=64"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "blocksort.c"
    k1[#k1 + 1] = dir_path .. "huffman.c"
    k1[#k1 + 1] = dir_path .. "crctable.c"
    k1[#k1 + 1] = dir_path .. "randtable.c"
    k1[#k1 + 1] = dir_path .. "compress.c"
    k1[#k1 + 1] = dir_path .. "decompress.c"
    k1[#k1 + 1] = dir_path .. "bzlib.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
