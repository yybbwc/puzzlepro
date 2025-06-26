rule("在构建后复制文件")
do
  after_build(function(target)
    if target:name() == "penlight" then
      local k1 = target:scriptdir() .. "/" .. target:name() .. "/"
      os.cp(k1 .. "lua/*", "$(projectdir)/../test/ygopro/lua/")
    elseif target:name() == "inspect.lua" then
      local k1 = target:scriptdir() .. "/" .. target:name() .. "/"
      os.cp(k1 .. "inspect.lua", "$(projectdir)/../test/ygopro/lua/")
    else
      if target:kind() == "headeronly" then
        return
      end
      os.cp(target:targetfile(), "$(projectdir)/../test/ygopro")
    end
  end)
end

rule("lib_name")
do
  on_load(function(target)
    local k1 = target:name()
    local k2 = "2025-04-06" .. "_" .. k1
    target:set("basename", k2)
  end)
end

do
  rule("openmp")
  do
    on_load(function(target)
      target:add("links", "libomp")
      target:add("cxxflags", "-fopenmp")
    end)
  end
end
