local target_name = "vorbis"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "ogg"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "lib"
    for i = 1, #k1 do
      add_includedirs(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "lib/mdct.c"
    k1[#k1 + 1] = dir_path .. "lib/smallft.c"
    k1[#k1 + 1] = dir_path .. "lib/block.c"
    k1[#k1 + 1] = dir_path .. "lib/envelope.c"
    k1[#k1 + 1] = dir_path .. "lib/window.c"
    k1[#k1 + 1] = dir_path .. "lib/lsp.c"
    k1[#k1 + 1] = dir_path .. "lib/lpc.c"
    k1[#k1 + 1] = dir_path .. "lib/analysis.c"
    k1[#k1 + 1] = dir_path .. "lib/synthesis.c"
    k1[#k1 + 1] = dir_path .. "lib/psy.c"
    k1[#k1 + 1] = dir_path .. "lib/info.c"
    k1[#k1 + 1] = dir_path .. "lib/floor1.c"
    k1[#k1 + 1] = dir_path .. "lib/floor0.c"
    k1[#k1 + 1] = dir_path .. "lib/res0.c"
    k1[#k1 + 1] = dir_path .. "lib/mapping0.c"
    k1[#k1 + 1] = dir_path .. "lib/registry.c"
    k1[#k1 + 1] = dir_path .. "lib/codebook.c"
    k1[#k1 + 1] = dir_path .. "lib/sharedbook.c"
    k1[#k1 + 1] = dir_path .. "lib/lookup.c"
    k1[#k1 + 1] = dir_path .. "lib/bitrate.c"
    k1[#k1 + 1] = dir_path .. "lib/vorbisenc.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
local target_name = "vorbisfile"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "vorbis"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "lib"
    for i = 1, #k1 do
      add_includedirs(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "lib/vorbisfile.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
