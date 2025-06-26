local target_name = "stb"
local k1 = target_name
target(k1)
do
  set_kind("static")
  do
    local k1 = target_name .. "/"
    add_includedirs(k1, { public = true })
    add_files(k1 .. "stb_vorbis.c")
  end
end
