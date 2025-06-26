--~ do
  --~ local k1 = {}
  --~ k1.__index = function(_, key)
    --~ error(("Attempt to read nil global '%s'\n%s"):format(key, debug.traceback()))
  --~ end
  --~ setmetatable(_G, k1)
--~ end
--~ kkkkk = {}
--~ kkkkk["sdfds"]()
--~ error(debug.traceback())
require("rewrite")

_G.sound = require("sound/path")
_G.skin = require("gui/skin/main")
_G.color = require("gui/color/main")
_G.config = require("gui/config")
_G.message = require("gui/message/main")
_G.xy = require("gui/xy")
_G.replay = require("gui/replay")

local require_analyze = require("require/analyze")
require_analyze.start()
--~ local inspect = require("inspect")
--~ print(inspect.inspect({4}))
