
local target_name = "boost"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("headeronly")
  
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
end

local target_name = "boost_thread"
target(target_name)
do
  set_kind("shared")
  do
    local k1 = {}
    k1[#k1 + 1] = "boost"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "lib_name"
    --~ k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "BOOST_THREAD_DYN_LINK"
    k1[#k1 + 1] = "BOOST_THREAD_USE_DLL"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "BOOST_THREAD_BUILD_DLL"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "libs/thread/src/future.cpp"
    k1[#k1 + 1] = dir_path .. "libs/thread/src/win32/*.cpp"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end

local target_name = "boost_filesystem"
target(target_name)
do
  set_kind("shared")
  do
    local k1 = {}
    k1[#k1 + 1] = "boost"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "lib_name"
    --~ k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "BOOST_THREAD_DYN_LINK"
    --~ k1[#k1 + 1] = "BOOST_THREAD_USE_DLL"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "BOOST_THREAD_BUILD_DLL"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "libs/filesystem/src/*.cpp"
    --~ k1[#k1 + 1] = dir_path .. "libs/thread/src/win32/*.cpp"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end

local target_name = "boost_serialization"
target(target_name)
do
  set_kind("shared")
  do
    local k1 = {}
    k1[#k1 + 1] = "boost"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "lib_name"
    --~ k1[#k1 + 1] = "在构建后复制文件"
    for i = 1, #k1 do
      add_rules(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "BOOST_SERIALIZATION_DYN_LINK"
    --~ k1[#k1 + 1] = "BOOST_THREAD_USE_DLL"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "BOOST_THREAD_BUILD_DLL"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "libs/serialization/src/*.cpp"
    --~ k1[#k1 + 1] = dir_path .. "libs/thread/src/win32/*.cpp"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
