local skin = require("gui/skin/main")
local code = require("gui/skin/code")
local d = {}

d.left_up = skin[code.EGDC_3D_FACE]
d.right_up = skin[code.EGDC_3D_FACE]
d.left_down = skin[code.EGDC_3D_SHADOW]
d.right_down = skin[code.EGDC_3D_SHADOW]

return d
