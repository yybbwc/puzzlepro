local target_name = "LuaBridge3"
local k1 = target_name
target(k1)
  set_kind("headeronly")
  
  k1 = k1 .. "/"
  add_includedirs(k1 .. "Source", {public = true})
  do
    local k1 = {}
    k1[#k1 + 1] = "slowstacktrace"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
