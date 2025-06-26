target("puzzlepro")
  set_kind("binary")
  
  local k1 = "puzzlepro/"

  add_deps("lzma", "spmemvfs", "libevent", "irrlicht_extra", "miniaudio", "puzzlepro_core", "clip", "LuaBridge3", "lua_charset_convert")
  do
    local k1 = {}
    if is_mode("debug") then
      k1[#k1 + 1] = "slowstacktrace"
    end
    k1[#k1 + 1] = "boost_thread"
    k1[#k1 + 1] = "pegtl"
    for i = 1, #k1 do
      add_deps(k1[i], {public = true})
    end
  end

  add_defines("YGOPRO_USE_MINIAUDIO")
  
  do
    local k1 = {}
    if is_mode("debug") then
      --~ k1[#k1 + 1] = "build.sanitizer.address"
    end
    for i = 1, #k1 do
      set_policy(k1[i], true)
    end
  end

  add_files(
    k1 .. "*.cpp",
    k1 .. "*.rc",
    {}
  )

  --~ add_links("opengl32", "gdi32", "kernel32", "iphlpapi", "bcrypt", "ws2_32", "winmm", "user32", "imm32", "stdc++", "ntdll", "libomp")
  add_links("opengl32", "gdi32", "kernel32", "iphlpapi", "bcrypt", "ws2_32", "winmm", "user32", "imm32", "stdc++", "ntdll")
  --~ add_links("opengl32", "gdi32", "kernel32", "iphlpapi", "bcrypt", "ws2_32", "winmm", "user32", "imm32", "stdc++", "ntdll", {})
  
  --~ add_ldflags("-Wl,-e,wmainCRTStartup", {force = true})
  
  do
    local k1 = {}
    k1[#k1 + 1] = "在构建后复制文件"
    k1[#k1 + 1] = "openmp"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
  --~ do
    --~ local k1 = {}
    --~ if is_mode("debug") then
      --~ k1[#k1 + 1] = "-g"
    --~ end
    --~ for i = 1, #k1 do
      --~ add_cxflags(k1[i])
    --~ end
  --~ end

  --~ add_cxflags("-fopenmp")
