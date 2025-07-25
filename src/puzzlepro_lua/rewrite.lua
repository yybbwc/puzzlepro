local d = {}

local charset_convert_path = "charset/convert"
local callee_path_table_path = "require/callee_path"
local caller_path_table_path = "require/caller_path"
local path_map_table_path = "require/path_map"

local charset_convert, charset_convert_return_value = require(charset_convert_path)
local callee_path_table, callee_path_table_return_value = require(callee_path_table_path)
local caller_path_table, caller_path_table_return_value = require(caller_path_table_path)
local path_map_table, path_map_table_return_value = require(path_map_table_path)

-- Populate path mapping table
path_map_table[charset_convert_path] = charset_convert_return_value
path_map_table[callee_path_table_path] = callee_path_table_return_value
path_map_table[caller_path_table_path] = caller_path_table_return_value
path_map_table[path_map_table_path] = path_map_table_return_value

-- Store original require function
d["require"] = _G.require

-- Override global require function
function _G.require(module_path)
    --~ print(module_path)
    local required_module, return_value = d["require"](charset_convert.utf8_to_gb18030(module_path))
    
    if return_value then
        path_map_table[module_path] = return_value
    end
    
    -- Track caller and callee paths
    caller_path_table[#caller_path_table + 1] = debug.getinfo(2, "S").source
    --~ print(debug.getinfo(2, "S").source)
    callee_path_table[#callee_path_table + 1] = path_map_table[module_path]
    
    return required_module, return_value
end

-- Store original io.open function
d["io.open"] = _G.io.open

-- Override global io.open function
function _G.io.open(filename, mode)
    local converted_filename = charset_convert.utf8_to_gb18030(filename)
    return d["io.open"](converted_filename, mode)
end

return d
