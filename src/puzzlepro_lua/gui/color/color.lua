local skin = require("gui/skin/main")
local code = require("gui/skin/code")
local d = {}

d.gradient_left_up = 0x400000ff
d.gradient_right_up = 0x400000ff
d.gradient_left_down = 0x40000000
d.gradient_right_down = 0x40000000

d.gradient_left_up = 0xFFB0BEC5
d.gradient_right_up = 0xFFB0BEC5
d.gradient_left_down = 0xFF2D5BB8
d.gradient_right_down = 0xFF2D5BB8

d.gradient_left_up = skin[code.EGDC_3D_FACE]
d.gradient_right_up = skin[code.EGDC_3D_FACE]
d.gradient_left_down = skin[code.EGDC_3D_SHADOW]
d.gradient_right_down = skin[code.EGDC_3D_SHADOW]

return d
