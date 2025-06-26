local d = {}
local calleePathTable = require("require/callee_path")
local callerPathTable = require("require/caller_path")
local charset_convert = require("charset/convert")
local file = require("file")
local inspect = require("inspect")

function d.prettifyPaths(pathTable)
  for i = 1, #pathTable do
    pathTable[i] = charset_convert.gb18030_to_utf8(pathTable[i])
    pathTable[i] = string.gsub(pathTable[i], "\0", "")
    pathTable[i] = string.gsub(pathTable[i], "^@", "")
    pathTable[i] = string.gsub(pathTable[i], "\\+", "/")
  end
end

function d.buildDependencyTable(callers, callees)
  local dependencyGraph = {}
  for i = 1, #callers do
    if not dependencyGraph[callers[i]] then
      dependencyGraph[callers[i]] = {}
    end
    dependencyGraph[callers[i]][callees[i]] = true
  end
  return dependencyGraph
end

function d.getChildNodes(dependencyGraph)
  local childNodes = {}
  for caller, callees in pairs(dependencyGraph) do
    for callee, _ in pairs(callees) do
      childNodes[callee] = true
    end
  end
  return childNodes
end

function d.calculateDependencyLevels(dependencyGraph)
  local levelTable = {}
  local childNodes = d.getChildNodes(dependencyGraph)
  
  local function calculateLevel(node)
    if levelTable[node] then
      return levelTable[node]
    end
    
    local dependencies = dependencyGraph[node]
    if type(dependencies) ~= "table" or not next(dependencies) then
      levelTable[node] = 1
      return levelTable[node]
    end
    
    local maxLevel = 0
    for dependency, _ in pairs(dependencies) do
      local dependencyLevel = calculateLevel(dependency)
      maxLevel = math.max(maxLevel, dependencyLevel)
    end
    
    levelTable[node] = maxLevel + 1
    return levelTable[node]
  end
  
  for node, _ in pairs(dependencyGraph) do
    if not childNodes[node] then
      calculateLevel(node)
    end
  end
  
  return levelTable
end

d.transformLevelTable = function(levelTable)
  local levelGroupedTable = {}
  for node, level in pairs(levelTable) do
    if not levelGroupedTable[level] then
      levelGroupedTable[level] = {}
    end
    table.insert(levelGroupedTable[level], node)
  end
  return levelGroupedTable
end

d.start = function()
  d.prettifyPaths(callerPathTable)
  d.prettifyPaths(calleePathTable)
  local dependencyGraph = d.buildDependencyTable(callerPathTable, calleePathTable)
  local levelTable = d.calculateDependencyLevels(dependencyGraph)
  local groupedLevelTable = d.transformLevelTable(levelTable)
  --~ print(inspect.inspect(callerPathTable))
  --~ print(inspect.inspect(calleePathTable))
  --~ print(inspect.inspect(dependencyGraph))
  --~ print(inspect.inspect(levelTable))
  --~ print(inspect.inspect(groupedLevelTable))
  file.write(groupedLevelTable, "依赖层级表.txt", nil, "\n\n")
end

return d
