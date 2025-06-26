--xmake
local d = {}

local download_github = function(repo, o1, o2, o3)
  local k1 = string.match(o1, "[^/]+$")
  k1 = k1 .. "-" .. o2
  k1 = repo .. "/" .. k1 .. ".zip"
  if os.exists(k1) then
  else
    os.exec("wget " .. o1 .. "/archive/" .. o2 .. ".zip" .. " -O " .. k1)
  end
  if os.exists(o3) then
  else
    os.exec("7z x " .. k1 .. " -o.")
    for _, i in ipairs(os.dirs("*" .. o2)) do
      os.mv(i, o3)
    end
  end
end

local download_zip = function(repo, o1, o2)
  local k1 = string.match(o1, "[^/]+$")
  local k2 = string.gsub(k1, "[^%.]+$", "")
  k1 = repo .. "/" .. k1
  if os.exists(k1) then
  else
    os.exec("wget " .. o1 .. " -O " .. k1)
  end
  if os.exists(o2) then
  else
    os.exec("7z x " .. k1 .. " -o.")
    for _, i in ipairs(os.dirs(k2)) do
      os.mv(i, o2)
    end
  end
end

local change_file_extension = function(o1, o2)
  for _, i in ipairs(os.files(o1)) do
    local k1 = string.gsub(i, "[^%.]+$", o2)
    os.mv(i, k1)
  end
end

local scm_pull = function(o1, o2, o3)
  os.cd(o1 .. "/" .. o2 .. "/" .. o3)
  if o2 == "git" then
    os.exec("git pull")
  end
end

do
  local d1 = {}
  d1.git = function(o1, o2, o3, o4, o5)
    local k1 = o1 .. "/" .. o2 .. "/" .. o3
    local k2 = [[git archive --format=zip --output="../../]] .. o3 .. "-" .. o4 .. [[.zip" ]] .. o4
    os.cd(k1)
    print(k2)
    os.exec(k2)
  end
  d1["git-svn"] = d1.git
  d1.fossil = function(o1, o2, o3, o4, o5)
    local k1 = o1 .. "/" .. o2 .. "/" .. o3
    local k2 = [[fossil zip ]] .. o4 .. [[ "../../]] .. o3 .. "-" .. o4 .. [[.zip" --name ]] .. k1
    os.cd(k1)
    print(k2)
    os.exec(k2)
  end
  d1.hg = function(o1, o2, o3, o4, o5)
    local k1 = o1 .. "/" .. o2 .. "/" .. o3
    local k2 = [[D:\_i\5_english\msys2/usr/bin/python /usr/bin/hg archive -t zip -r ]] .. o4 .. [[ "../../]] .. o3 .. "-" .. o4 .. [[.zip"]]
    os.cd(k1)
    print(k2)
    os.exec(k2)
  end
  d1.zip = function(o1, o2, o3, o4, o5)
    local k1 = o1 .. "/" .. o2
    local k2 = [[robocopy . .. ]] .. o3 .. "." .. o2
    os.cd(k1)
    print(k2)
    os.exec(k2)
  end
  d1["7z"] = d1.zip
  d1.rar = d1.zip
  d.scm_archive = function(o1, o2, o3, o4, o5)
    local k1 = o1 .. "/" .. o3 .. "-" .. o4 .. ".zip"
    local k2 = o1 .. "/" .. o3 .. ".zip"
    local k3 = o1 .. "/" .. o3 .. ".7z"
    local k4 = o1 .. "/" .. o3 .. ".rar"
    if os.exists(k1) or os.exists(k2) or os.exists(k3) or os.exists(k4) then
    else
      d1[o2](o1, o2, o3, o4, o5)
    end
  end
end

do
  local d1 = {}
  d1.git = function(o1, o2, o3, o4, o5)
    local k1 = "7z x " .. o1 .. "/" .. o3 .. "-" .. o4 .. ".zip" .. " -o" .. o5
    print(k1)
    os.exec(k1)
  end
  d1["git-svn"] = d1.git
  d1.fossil = function(o1, o2, o3, o4, o5)
    d1.git(o1, o2, o3, o4, o5)
    local k1 = "*" .. o4
    for i1, i2 in ipairs(os.dirs(k1)) do
      local k2 = "[^%.]+$"
      local k3 = string.gsub(i2, k2, o5)
      print(i2, k3)
      os.mv(i2, k3)
    end
  end
  d1.zip = function(o1, o2, o3, o4, o5)
    local k1 = "7z x " .. o1 .. "/" .. o3 .. "." .. o2 .. " -o."
    print(k1)
    os.exec(k1)
    if o3 == o5 then
    else
      os.mv(o3, o5)
    end
  end
  d1.hg = function(o1, o2, o3, o4, o5)
    local k1 = "7z x " .. o1 .. "/" .. o3 .. "-" .. o4 .. ".zip" .. " -o."
    print(k1)
    os.exec(k1)
    os.mv(o3 .. "-" .. o4, o5)
  end
  d1["7z"] = d1.zip
  d1.rar = d1.zip
  d.scm_archive_to_dir = function(o1, o2, o3, o4, o5)
    os.cd(d.path_lib)
    if os.exists(o5) then
    else
      d1[o2](o1, o2, o3, o4, o5)
    end
  end
end

local from_scm_to_dir = function(o1, o2, o3, o4, o5)
  d.scm_archive(o1, o2, o3, o4, o5)
  d.scm_archive_to_dir(o1, o2, o3, o4, o5)
end

d.from_scm_to_dirs = function(o1)
  for i = 1, #o1 do
    from_scm_to_dir(table.unpack(o1[i]))
  end
end

d.path_lib = os.projectdir() .. "/lib"

os.mkdir(d.path_lib)

import("lib_hash")
d.from_scm_to_dirs(lib_hash.get_d())
