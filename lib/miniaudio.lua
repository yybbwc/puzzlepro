
local target_name = "miniaudio"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "vorbisfile"
    k1[#k1 + 1] = "opusfile"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    k1[#k1 + 1] = dir_path .. "extras/decoders/libvorbis"
    k1[#k1 + 1] = dir_path .. "extras/decoders/libopus"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "*.c"
    k1[#k1 + 1] = dir_path .. "extras/decoders/libvorbis/*.c"
    k1[#k1 + 1] = dir_path .. "extras/decoders/libopus/*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
