local target_name = "zstd"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "lib/"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "ZSTD_DISABLE_ASM"
    k1[#k1 + 1] = "ZSTD_MULTITHREAD"
    k1[#k1 + 1] = "libzstd_shared_EXPORTS"
    k1[#k1 + 1] = "ZSTD_LEGACY_SUPPORT=5"
    k1[#k1 + 1] = "XXH_NAMESPACE=ZSTD"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "lib/**.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
end
