local d = {}

local charset_convert = require("lua_charset_convert")
local code = require("charset/code")

d.utf8_to_gb18030 = function(o1)
  local k1 = charset_convert.mb_to_wide(o1, code.utf8)
  return charset_convert.wide_to_mb(k1, code.gb18030)
end

d.gb18030_to_utf8 = function(o1)
  local k1 = charset_convert.mb_to_wide(o1, code.gb18030)
  return charset_convert.wide_to_mb(k1, code.utf8)
end

return d
