local d = {}

do
  local writerFunctions = {}
  
  -- Basic string writer
  writerFunctions["string"] = function(content, filePath, fileMode)
    local file = io.open(filePath, fileMode or "w")
    file:write(content)
    file:close()
  end

  do
    local tableHandlers = {}
    
    -- String table handler
    tableHandlers["string"] = function(stringTable, filePath, fileMode, separator)
      local content = table.concat(stringTable, separator or "\n")
      writerFunctions["string"](content, filePath, fileMode)
    end

    -- Nested table handler
    tableHandlers["table"] = function(nestedTable, filePath, fileMode, separator)
      -- Flatten each subtable
      for i = 1, #nestedTable do
        nestedTable[i] = table.concat(nestedTable[i], "\n")
      end
      -- Delegate to string table handler
      tableHandlers[type(nestedTable[1])](nestedTable, filePath, fileMode, separator)
    end

    -- Main table writer
    writerFunctions["table"] = function(contentTable, filePath, fileMode, separator)
      tableHandlers[type(contentTable[1])](contentTable, filePath, fileMode, separator)
    end
  end

  -- Public write function
  d.write = function(content, filePath, fileMode, separator)
    writerFunctions[type(content)](content, filePath, fileMode, separator)
  end
end

return d
