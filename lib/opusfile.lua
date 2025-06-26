local target_name = "opusfile"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "opus"
    k1[#k1 + 1] = "ogg"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "OP_HAVE_LRINTF"
    for i = 1, #k1 do
      add_defines(k1[i])
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
    k1[#k1 + 1] = dir_path .. "src/info.c"
    k1[#k1 + 1] = dir_path .. "src/internal.c"
    k1[#k1 + 1] = dir_path .. "src/opusfile.c"
    k1[#k1 + 1] = dir_path .. "src/stream.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
