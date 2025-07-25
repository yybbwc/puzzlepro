local code = require("gui/skin/code")
local d = {}

d.type_1 = {}
d.type_1[code.EGDC_3D_DARK_SHADOW] = 0x65323232
d.type_1[code.EGDC_3D_SHADOW] = 0x65828282
d.type_1[code.EGDC_3D_FACE] = 0x65D2D2D2
d.type_1[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFFFF
d.type_1[code.EGDC_3D_LIGHT] = 0x65D2D2D2
d.type_1[code.EGDC_ACTIVE_BORDER] = 0x65100E73
d.type_1[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF
d.type_1[code.EGDC_APP_WORKSPACE] = 0x65646464
d.type_1[code.EGDC_BUTTON_TEXT] = 0xF00A0A0A
d.type_1[code.EGDC_GRAY_TEXT] = 0xF0828282
d.type_1[code.EGDC_HIGH_LIGHT] = 0x6508246B
d.type_1[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF
d.type_1[code.EGDC_INACTIVE_BORDER] = 0x65A5A5A5
d.type_1[code.EGDC_INACTIVE_CAPTION] = 0xFF1E1E1E
d.type_1[code.EGDC_TOOLTIP] = 0xC8000000
d.type_1[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8FFFFE1
d.type_1[code.EGDC_SCROLLBAR] = 0x65E6E6E6
d.type_1[code.EGDC_WINDOW] = 0x65FFFFFF
d.type_1[code.EGDC_WINDOW_SYMBOL] = 0xC80A0A0A
d.type_1[code.EGDC_ICON] = 0xC8FFFFFF
d.type_1[code.EGDC_ICON_HIGH_LIGHT] = 0xC808246B
d.type_1[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464
d.type_1[code.EGDC_EDITABLE] = 0xFFFFFFFF
d.type_1[code.EGDC_GRAY_EDITABLE] = 0xFF787878
d.type_1[code.EGDC_FOCUSED_EDITABLE] = 0xFFF0F0FF

d.type_2 = {}
d.type_2[code.EGDC_3D_DARK_SHADOW] = 0xFF93A1A1 -- base1 (阴影最深边)
d.type_2[code.EGDC_3D_SHADOW] = 0xDC93A1A1 -- base1 + 透明度
d.type_2[code.EGDC_3D_FACE] = 0xFFEEE8D5 -- base2 (按钮背景)
d.type_2[code.EGDC_3D_HIGH_LIGHT] = 0xFFFDF6E3 -- base3 (高亮边)
d.type_2[code.EGDC_3D_LIGHT] = 0xFFFDF6E3 -- base3 (亮边)
d.type_2[code.EGDC_ACTIVE_BORDER] = 0xFF93A1A1 -- base1
d.type_2[code.EGDC_ACTIVE_CAPTION] = 0xFF2AA198 -- cyan (活动标题栏)
d.type_2[code.EGDC_INACTIVE_BORDER] = 0xC893A1A1 -- base1 + 透明
d.type_2[code.EGDC_INACTIVE_CAPTION] = 0xC8586E75 -- base01 + 透明
d.type_2[code.EGDC_BUTTON_TEXT] = 0xFF586E75 -- base01 (按钮文字)
d.type_2[code.EGDC_GRAY_TEXT] = 0xB493A1A1 -- base1 + 透明 (禁用文字)
d.type_2[code.EGDC_HIGH_LIGHT] = 0xFF2AA198 -- cyan (选中项背景)
d.type_2[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFDF6E3 -- base3 (选中文字)
d.type_2[code.EGDC_WINDOW] = 0xFFFDF6E3 -- base3 (窗口背景)
d.type_2[code.EGDC_APP_WORKSPACE] = 0xFFEEE8D5 -- base2 (MDI背景)
d.type_2[code.EGDC_SCROLLBAR] = 0xB493A1A1 -- base1 + 透明 (滚动条)
d.type_2[code.EGDC_WINDOW_SYMBOL] = 0xFF657B83 -- base00 (关闭按钮X)
d.type_2[code.EGDC_ICON] = 0xFF657B83 -- base00 (默认图标)
d.type_2[code.EGDC_ICON_HIGH_LIGHT] = 0xFF2AA198 -- cyan (选中图标)
d.type_2[code.EGDC_EDITABLE] = 0xFFFDF6E3 -- base3 (编辑框背景)
d.type_2[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF -- 纯白 (聚焦时)
d.type_2[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5 -- base2 + 透明 (禁用编辑框)
d.type_2[code.EGDC_TOOLTIP] = 0xFFEEE8D5 -- base2 (工具提示背景)
d.type_2[code.EGDC_TOOLTIP_BACKGROUND] = 0xE693A1A1 -- base1 + 透明 (边框)
d.type_2[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_3 = {}
d.type_3[code.EGDC_3D_DARK_SHADOW] = 0x6512121E
d.type_3[code.EGDC_3D_SHADOW] = 0x65222A3D
d.type_3[code.EGDC_3D_FACE] = 0x65303A54
d.type_3[code.EGDC_3D_HIGH_LIGHT] = 0x654D5B7F
d.type_3[code.EGDC_3D_LIGHT] = 0x653A4663
d.type_3[code.EGDC_ACTIVE_BORDER] = 0x65003CFF
d.type_3[code.EGDC_ACTIVE_CAPTION] = 0xFF00A2FF
d.type_3[code.EGDC_APP_WORKSPACE] = 0x651A1A2E
d.type_3[code.EGDC_BUTTON_TEXT] = 0xF0E0E0FF
d.type_3[code.EGDC_GRAY_TEXT] = 0xF06E7A9D
d.type_3[code.EGDC_HIGH_LIGHT] = 0x65007BFF
d.type_3[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF
d.type_3[code.EGDC_INACTIVE_BORDER] = 0x654A4A6A
d.type_3[code.EGDC_INACTIVE_CAPTION] = 0xFF4A4A6A
d.type_3[code.EGDC_TOOLTIP] = 0xC8FFFFFF
d.type_3[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E3D
d.type_3[code.EGDC_SCROLLBAR] = 0x653A4663
d.type_3[code.EGDC_WINDOW] = 0x65222A3D
d.type_3[code.EGDC_WINDOW_SYMBOL] = 0xC8B4C6FF
d.type_3[code.EGDC_ICON] = 0xC800A2FF
d.type_3[code.EGDC_ICON_HIGH_LIGHT] = 0xC8007BFF
d.type_3[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_3[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_3[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_3[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_4 = {}
d.type_4[code.EGDC_3D_DARK_SHADOW] = 0x65201035
d.type_4[code.EGDC_3D_SHADOW] = 0x65302060
d.type_4[code.EGDC_3D_FACE] = 0x65403090
d.type_4[code.EGDC_3D_HIGH_LIGHT] = 0x65FF00FF
d.type_4[code.EGDC_3D_LIGHT] = 0x656040C0
d.type_4[code.EGDC_ACTIVE_BORDER] = 0x65FF00FF
d.type_4[code.EGDC_ACTIVE_CAPTION] = 0xFFFF00FF
d.type_4[code.EGDC_APP_WORKSPACE] = 0x65100030
d.type_4[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF
d.type_4[code.EGDC_GRAY_TEXT] = 0xF09060FF
d.type_4[code.EGDC_HIGH_LIGHT] = 0x65FF00FF
d.type_4[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF
d.type_4[code.EGDC_INACTIVE_BORDER] = 0x65403090
d.type_4[code.EGDC_INACTIVE_CAPTION] = 0xFF6020A0
d.type_4[code.EGDC_TOOLTIP] = 0xC8FFFFFF
d.type_4[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8201040
d.type_4[code.EGDC_SCROLLBAR] = 0x656040C0
d.type_4[code.EGDC_WINDOW] = 0x65302060
d.type_4[code.EGDC_WINDOW_SYMBOL] = 0xC8FF00FF
d.type_4[code.EGDC_ICON] = 0xC8FF00FF
d.type_4[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF00FF
d.type_4[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_4[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_4[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_4[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_5 = {}
d.type_5[code.EGDC_3D_DARK_SHADOW] = 0x651A2E1A
d.type_5[code.EGDC_3D_SHADOW] = 0x652D4D2D
d.type_5[code.EGDC_3D_FACE] = 0x653E6E3E
d.type_5[code.EGDC_3D_HIGH_LIGHT] = 0x655E9E5E
d.type_5[code.EGDC_3D_LIGHT] = 0x654A7A4A
d.type_5[code.EGDC_ACTIVE_BORDER] = 0x652D4D2D
d.type_5[code.EGDC_ACTIVE_CAPTION] = 0xFF5E9E5E
d.type_5[code.EGDC_APP_WORKSPACE] = 0x651A2E1A
d.type_5[code.EGDC_BUTTON_TEXT] = 0xF0E8F4E8
d.type_5[code.EGDC_GRAY_TEXT] = 0xF05E7E5E
d.type_5[code.EGDC_HIGH_LIGHT] = 0x653E6E3E
d.type_5[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF
d.type_5[code.EGDC_INACTIVE_BORDER] = 0x653E6E3E
d.type_5[code.EGDC_INACTIVE_CAPTION] = 0xFF3E6E3E
d.type_5[code.EGDC_TOOLTIP] = 0xC8E8F4E8
d.type_5[code.EGDC_TOOLTIP_BACKGROUND] = 0xC82D4D2D
d.type_5[code.EGDC_SCROLLBAR] = 0x654A7A4A
d.type_5[code.EGDC_WINDOW] = 0x652D4D2D
d.type_5[code.EGDC_WINDOW_SYMBOL] = 0xC85E9E5E
d.type_5[code.EGDC_ICON] = 0xC85E9E5E
d.type_5[code.EGDC_ICON_HIGH_LIGHT] = 0xC85E9E5E
d.type_5[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_5[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_5[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_5[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_6 = {}
d.type_6[code.EGDC_3D_DARK_SHADOW] = 0x65402C18
d.type_6[code.EGDC_3D_SHADOW] = 0x65604020
d.type_6[code.EGDC_3D_FACE] = 0x65805030
d.type_6[code.EGDC_3D_HIGH_LIGHT] = 0x65C08040
d.type_6[code.EGDC_3D_LIGHT] = 0x65A06838
d.type_6[code.EGDC_ACTIVE_BORDER] = 0x65C08040
d.type_6[code.EGDC_ACTIVE_CAPTION] = 0xFFC08040
d.type_6[code.EGDC_APP_WORKSPACE] = 0x65402C18
d.type_6[code.EGDC_BUTTON_TEXT] = 0xF0F8E8D8
d.type_6[code.EGDC_GRAY_TEXT] = 0xF0A07850
d.type_6[code.EGDC_HIGH_LIGHT] = 0x65805030
d.type_6[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF
d.type_6[code.EGDC_INACTIVE_BORDER] = 0x65805030
d.type_6[code.EGDC_INACTIVE_CAPTION] = 0xFF805030
d.type_6[code.EGDC_TOOLTIP] = 0xC8F8E8D8
d.type_6[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8604020
d.type_6[code.EGDC_SCROLLBAR] = 0x65A06838
d.type_6[code.EGDC_WINDOW] = 0x65604020
d.type_6[code.EGDC_WINDOW_SYMBOL] = 0xC8C08040
d.type_6[code.EGDC_ICON] = 0xC8C08040
d.type_6[code.EGDC_ICON_HIGH_LIGHT] = 0xC8C08040
d.type_6[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_6[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_6[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_6[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_7 = {}
d.type_7[code.EGDC_3D_DARK_SHADOW] = 0x650A0A0A
d.type_7[code.EGDC_3D_SHADOW] = 0x651E1E1E
d.type_7[code.EGDC_3D_FACE] = 0x652D2D2D
d.type_7[code.EGDC_3D_HIGH_LIGHT] = 0x654A4A4A
d.type_7[code.EGDC_3D_LIGHT] = 0x653A3A3A
d.type_7[code.EGDC_ACTIVE_BORDER] = 0x65A00000
d.type_7[code.EGDC_ACTIVE_CAPTION] = 0xFFA00000
d.type_7[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_7[code.EGDC_BUTTON_TEXT] = 0xF0D0D0D0
d.type_7[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_7[code.EGDC_HIGH_LIGHT] = 0x65A00000
d.type_7[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF
d.type_7[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_7[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_7[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_7[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_7[code.EGDC_SCROLLBAR] = 0x653A3A3A
d.type_7[code.EGDC_WINDOW] = 0x651E1E1E
d.type_7[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_7[code.EGDC_ICON] = 0xC8A00000
d.type_7[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_7[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_7[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_7[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_7[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_darkfantasy = {}
d.type_darkfantasy[code.EGDC_3D_DARK_SHADOW] = 0x80101010
d.type_darkfantasy[code.EGDC_3D_SHADOW] = 0x802E2E2E
d.type_darkfantasy[code.EGDC_3D_FACE] = 0x804A3C28
d.type_darkfantasy[code.EGDC_3D_HIGH_LIGHT] = 0x806B5D49
d.type_darkfantasy[code.EGDC_3D_LIGHT] = 0x805A4C38
d.type_darkfantasy[code.EGDC_ACTIVE_BORDER] = 0xB0C0A060
d.type_darkfantasy[code.EGDC_ACTIVE_CAPTION] = 0xFFD4B376
d.type_darkfantasy[code.EGDC_BUTTON_TEXT] = 0xF0E8D8A0
d.type_darkfantasy[code.EGDC_HIGH_LIGHT] = 0x90605030
d.type_darkfantasy[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFE0A0
d.type_darkfantasy[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_darkfantasy[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_darkfantasy[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_darkfantasy[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_darkfantasy[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_darkfantasy[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_darkfantasy[code.EGDC_SCROLLBAR] = 0x653A3A3A
d.type_darkfantasy[code.EGDC_WINDOW] = 0x651E1E1E
d.type_darkfantasy[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_darkfantasy[code.EGDC_ICON] = 0xC8A00000
d.type_darkfantasy[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_darkfantasy[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_darkfantasy[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_darkfantasy[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_darkfantasy[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_scifi_blue = {}
d.type_scifi_blue[code.EGDC_3D_DARK_SHADOW] = 0x80001020
d.type_scifi_blue[code.EGDC_3D_SHADOW] = 0x80102540
d.type_scifi_blue[code.EGDC_3D_FACE] = 0x80204070
d.type_scifi_blue[code.EGDC_3D_HIGH_LIGHT] = 0x806090C0
d.type_scifi_blue[code.EGDC_3D_LIGHT] = 0x80305090
d.type_scifi_blue[code.EGDC_ACTIVE_BORDER] = 0xB000A0FF
d.type_scifi_blue[code.EGDC_ACTIVE_CAPTION] = 0xFF00C0FF
d.type_scifi_blue[code.EGDC_BUTTON_TEXT] = 0xF0E0F0FF
d.type_scifi_blue[code.EGDC_HIGH_LIGHT] = 0x900060A0
d.type_scifi_blue[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0A0FFFF
d.type_scifi_blue[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_scifi_blue[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_scifi_blue[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_scifi_blue[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_scifi_blue[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_scifi_blue[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_scifi_blue[code.EGDC_SCROLLBAR] = 0x653A3A3A
d.type_scifi_blue[code.EGDC_WINDOW] = 0x651E1E1E
d.type_scifi_blue[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_scifi_blue[code.EGDC_ICON] = 0xC8A00000
d.type_scifi_blue[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_scifi_blue[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_scifi_blue[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_scifi_blue[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_scifi_blue[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_cyberpunk = {}
d.type_cyberpunk[code.EGDC_3D_DARK_SHADOW] = 0x80201030
d.type_cyberpunk[code.EGDC_3D_SHADOW] = 0x80302060
d.type_cyberpunk[code.EGDC_3D_FACE] = 0x80403090
d.type_cyberpunk[code.EGDC_3D_HIGH_LIGHT] = 0x80F030F0
d.type_cyberpunk[code.EGDC_3D_LIGHT] = 0x806040C0
d.type_cyberpunk[code.EGDC_ACTIVE_BORDER] = 0xB0FF00FF
d.type_cyberpunk[code.EGDC_ACTIVE_CAPTION] = 0xFFFF60FF
d.type_cyberpunk[code.EGDC_BUTTON_TEXT] = 0xF0FFC0FF
d.type_cyberpunk[code.EGDC_HIGH_LIGHT] = 0x90FF00A0
d.type_cyberpunk[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFA0FF
d.type_cyberpunk[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_cyberpunk[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_cyberpunk[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_cyberpunk[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_cyberpunk[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_cyberpunk[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_cyberpunk[code.EGDC_SCROLLBAR] = 0x653A3A3A
d.type_cyberpunk[code.EGDC_WINDOW] = 0x651E1E1E
d.type_cyberpunk[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_cyberpunk[code.EGDC_ICON] = 0xC8A00000
d.type_cyberpunk[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_cyberpunk[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_cyberpunk[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_cyberpunk[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_cyberpunk[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_nature_green = {}
d.type_nature_green[code.EGDC_3D_DARK_SHADOW] = 0x80102010
d.type_nature_green[code.EGDC_3D_SHADOW] = 0x80204020
d.type_nature_green[code.EGDC_3D_FACE] = 0x80307030
d.type_nature_green[code.EGDC_3D_HIGH_LIGHT] = 0x8050A050
d.type_nature_green[code.EGDC_3D_LIGHT] = 0x80408040
d.type_nature_green[code.EGDC_ACTIVE_BORDER] = 0xB040C040
d.type_nature_green[code.EGDC_ACTIVE_CAPTION] = 0xFF60E060
d.type_nature_green[code.EGDC_BUTTON_TEXT] = 0xF0D0F0D0
d.type_nature_green[code.EGDC_HIGH_LIGHT] = 0x90208020
d.type_nature_green[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0A0FFA0
d.type_nature_green[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_nature_green[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_nature_green[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_nature_green[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_nature_green[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_nature_green[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_nature_green[code.EGDC_SCROLLBAR] = 0x653A3A3A
d.type_nature_green[code.EGDC_WINDOW] = 0x651E1E1E
d.type_nature_green[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_nature_green[code.EGDC_ICON] = 0xC8A00000
d.type_nature_green[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_nature_green[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_nature_green[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_nature_green[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_nature_green[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_retro_pixel = {}
d.type_retro_pixel[code.EGDC_3D_DARK_SHADOW] = 0xFF3E3E3E
d.type_retro_pixel[code.EGDC_3D_SHADOW] = 0xFF5E5E5E
d.type_retro_pixel[code.EGDC_3D_FACE] = 0xFF8E8E8E
d.type_retro_pixel[code.EGDC_3D_HIGH_LIGHT] = 0xFFBEBEBE
d.type_retro_pixel[code.EGDC_3D_LIGHT] = 0xFFA0A0A0
d.type_retro_pixel[code.EGDC_ACTIVE_BORDER] = 0xFF6B8C23
d.type_retro_pixel[code.EGDC_ACTIVE_CAPTION] = 0xFFA5C14D
d.type_retro_pixel[code.EGDC_BUTTON_TEXT] = 0xFF2C2C2C
d.type_retro_pixel[code.EGDC_HIGH_LIGHT] = 0xFF4A6B1F
d.type_retro_pixel[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFE0E0E0
d.type_retro_pixel[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_retro_pixel[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_retro_pixel[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_retro_pixel[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_retro_pixel[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_retro_pixel[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_retro_pixel[code.EGDC_SCROLLBAR] = 0x653A3A3A
d.type_retro_pixel[code.EGDC_WINDOW] = 0x651E1E1E
d.type_retro_pixel[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_retro_pixel[code.EGDC_ICON] = 0xC8A00000
d.type_retro_pixel[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_retro_pixel[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_retro_pixel[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_retro_pixel[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_retro_pixel[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_8 = {}
d.type_8[code.EGDC_3D_DARK_SHADOW] = 0x65342C22 -- 深棕阴影
d.type_8[code.EGDC_3D_SHADOW] = 0x657A6B5F -- 中棕
d.type_8[code.EGDC_3D_FACE] = 0x65C4B5A3 -- 浅米色
d.type_8[code.EGDC_3D_HIGH_LIGHT] = 0x65E8DECD -- 米白高光
d.type_8[code.EGDC_ACTIVE_BORDER] = 0x655D8B42 -- 橄榄绿边框
d.type_8[code.EGDC_ACTIVE_CAPTION] = 0xFF8B7355 -- 深棕标题
d.type_8[code.EGDC_BUTTON_TEXT] = 0xF0221C15 -- 近乎黑的深棕
d.type_8[code.EGDC_HIGH_LIGHT] = 0x656D8B54 -- 浅橄榄绿
d.type_8[code.EGDC_WINDOW] = 0x65F5F0E8 -- 亚麻白窗口
d.type_8[code.EGDC_SCROLLBAR] = 0x65A38B6F -- 调整为木质色
d.type_8[code.EGDC_3D_LIGHT] = 0xFFA0A0A0
d.type_8[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFE0E0E0
d.type_8[code.EGDC_APP_WORKSPACE] = 0x650A0A0A
d.type_8[code.EGDC_GRAY_TEXT] = 0xF0606060
d.type_8[code.EGDC_INACTIVE_BORDER] = 0x652D2D2D
d.type_8[code.EGDC_INACTIVE_CAPTION] = 0xFF2D2D2D
d.type_8[code.EGDC_TOOLTIP] = 0xC8D0D0D0
d.type_8[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81E1E1E
d.type_8[code.EGDC_WINDOW_SYMBOL] = 0xC8A00000
d.type_8[code.EGDC_ICON] = 0xC8A00000
d.type_8[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A00000
d.type_8[code.EGDC_EDITABLE] = 0xFFFDF6E3
d.type_8[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF
d.type_8[code.EGDC_GRAY_EDITABLE] = 0xDCEEE8D5
d.type_8[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0646464

d.type_9 = {}
-- 3D 控件组 (按明暗层次递进)
d.type_9[code.EGDC_3D_DARK_SHADOW] = 0x65342C22 -- 最深阴影: 咖啡黑
d.type_9[code.EGDC_3D_SHADOW] = 0x657A6B5F -- 次级阴影: 灰棕
d.type_9[code.EGDC_3D_FACE] = 0x65C4B5A3 -- 控件主色: 沙米色
d.type_9[code.EGDC_3D_HIGH_LIGHT] = 0x65E8DECD -- 高光: 亚麻白
d.type_9[code.EGDC_3D_LIGHT] = 0x65D2C4B1 -- 辅助光: 浅米灰

-- 活动元素组 (用橄榄绿强化焦点)
d.type_9[code.EGDC_ACTIVE_BORDER] = 0x655D8B42 -- 活动边框: 森林绿
d.type_9[code.EGDC_ACTIVE_CAPTION] = 0xFF8B7355 -- 标题栏: 深胡桃木
d.type_9[code.EGDC_HIGH_LIGHT] = 0x656D8B54 -- 选中项: 嫩橄榄绿
d.type_9[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0F5F0E8 -- 高亮文字: 米白

-- 静态背景组 (暖灰过渡)
d.type_9[code.EGDC_APP_WORKSPACE] = 0x6593897A -- 工作区: 岩石灰
d.type_9[code.EGDC_WINDOW] = 0x65F5F0E8 -- 窗口: 亚麻布白
d.type_9[code.EGDC_EDITABLE] = 0xFFF8F4E8 -- 输入框: 象牙白
d.type_9[code.EGDC_GRAY_EDITABLE] = 0xFFB8AA94 -- 禁用输入框: 陶土灰

-- 文字组 (棕黑层级)
d.type_9[code.EGDC_BUTTON_TEXT] = 0xF0221C15 -- 主文字: 浓缩咖啡
d.type_9[code.EGDC_GRAY_TEXT] = 0xF07A6B5F -- 禁用文字: 可可粉
d.type_9[code.EGDC_WINDOW_SYMBOL] = 0xC8221C15 -- 图标文字: 深咖啡
d.type_9[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF07A6B5F -- 灰图标文字

-- 辅助功能组 (保留必要对比)
d.type_9[code.EGDC_TOOLTIP] = 0xC8221C15 -- 工具提示文字: 深咖啡
d.type_9[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8F5EBDC -- 工具提示背景: 羊皮纸
d.type_9[code.EGDC_SCROLLBAR] = 0x65A38B6F -- 滚动条: 柚木色
d.type_9[code.EGDC_ICON] = 0xC8D2C4B1 -- 图标: 浅米灰
d.type_9[code.EGDC_ICON_HIGH_LIGHT] = 0xC85D8B42 -- 高亮图标: 橄榄绿

-- 非活动状态组 (降低饱和度的暖色)
d.type_9[code.EGDC_INACTIVE_BORDER] = 0x65A38B6F -- 非活动边框: 柚木色(淡)
d.type_9[code.EGDC_INACTIVE_CAPTION] = 0xFF6B5D4F -- 非活动标题: 灰褐

-- 特殊状态组
d.type_9[code.EGDC_FOCUSED_EDITABLE] = 0xFFE8E0C4 -- 聚焦输入框: 蜂蜜黄

d.type_10 = {}
-- 蓝天白云组
d.type_10[code.EGDC_3D_DARK_SHADOW] = 0x652D8FD6 -- 深蓝天: 风铃阴影
d.type_10[code.EGDC_3D_SHADOW] = 0x6575C9FF -- 浅蓝天: 云朵间隙
d.type_10[code.EGDC_3D_FACE] = 0x65E6F7FF -- 主色调: 晴空水色
d.type_10[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFFFF -- 高光: 棉花云
d.type_10[code.EGDC_3D_LIGHT] = 0x65B4E8FF -- 辅助光: 阳光折射

-- 脸红少女组（重点区域！）
d.type_10[code.EGDC_ACTIVE_BORDER] = 0x65FFB6C1 -- 活动边框: 樱花粉
d.type_10[code.EGDC_ACTIVE_CAPTION] = 0xFFFF69B4 -- 标题栏: 草莓冰
d.type_10[code.EGDC_HIGH_LIGHT] = 0x65FFD700 -- 选中项: 阳光金
d.type_10[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FF1493 -- 高亮文字: 唇膏粉

-- 透明风铃组
d.type_10[code.EGDC_APP_WORKSPACE] = 0x65C8F7FF -- 工作区: 薄荷汽水
d.type_10[code.EGDC_WINDOW] = 0x65FAFFFC -- 窗口: 冰晶反光
d.type_10[code.EGDC_EDITABLE] = 0xFFFEFFFA -- 输入框: 雪顶气泡
d.type_10[code.EGDC_GRAY_EDITABLE] = 0xFFD6F1FF -- 禁用输入框: 冻蓝

-- 文字组（像夏日明信片）
d.type_10[code.EGDC_BUTTON_TEXT] = 0xF0FF4E94 -- 主文字: 西瓜红
d.type_10[code.EGDC_GRAY_TEXT] = 0xF0FFB6C1 -- 禁用文字: 樱花粉
d.type_10[code.EGDC_WINDOW_SYMBOL] = 0xC8FF4E94 -- 图标文字: 心动红
d.type_10[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0FFB6C1

-- 害羞特效组
d.type_10[code.EGDC_TOOLTIP] = 0xC8FF1493 -- 工具提示: 告白粉
d.type_10[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8FFF2FD -- 背景: 新娘头纱
d.type_10[code.EGDC_SCROLLBAR] = 0x65FFD1DC -- 滚动条: 奶油草莓
d.type_10[code.EGDC_ICON] = 0xC8FFEEF7 -- 图标: 珍珠光泽
d.type_10[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF4E94 -- 高亮图标: 心跳色

-- 被动状态（像被风吹淡）
d.type_10[code.EGDC_INACTIVE_BORDER] = 0x65B4E8FF -- 非活动边框: 褪色蓝天
d.type_10[code.EGDC_INACTIVE_CAPTION] = 0xFFB4E8FF -- 非活动标题: 记忆浅蓝

-- 接吻瞬间特效
d.type_10[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFD1F9 -- 聚焦输入框: 霓虹粉光

d.type_11 = {}
-- 蓝天白云组（提高亮度）
d.type_11[code.EGDC_3D_DARK_SHADOW] = 0x652D8FD6 -- 深蓝天 (保持)
d.type_11[code.EGDC_3D_SHADOW] = 0x6575C9FF -- 浅蓝天 (保持)
d.type_11[code.EGDC_3D_FACE] = 0x65E6F7FF -- 主色调: 晴空水色 (保持)
d.type_11[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFFFF -- 高光: 纯白云 (保持)
d.type_11[code.EGDC_3D_LIGHT] = 0x65B4E8FF -- 辅助光: 阳光折射 (保持)

-- 脸红少女组（提高对比度）
d.type_11[code.EGDC_ACTIVE_BORDER] = 0x65FF69B4 -- 活动边框: 草莓粉 (更鲜艳)
d.type_11[code.EGDC_ACTIVE_CAPTION] = 0xFFFF1493 -- 标题栏: 心动唇色 (饱和加强)
d.type_11[code.EGDC_HIGH_LIGHT] = 0x65FFD700 -- 选中项: 阳光金 (保持)
d.type_11[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF -- 高亮文字: 纯白 (提高可读性)

-- 背景组（提亮+增强对比）
d.type_11[code.EGDC_APP_WORKSPACE] = 0x65E6F7FF -- 工作区: 更亮蓝天
d.type_11[code.EGDC_WINDOW] = 0x65FFFFFF -- 窗口: 纯白 (最高对比)
d.type_11[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 输入框: 纯白背景
d.type_11[code.EGDC_GRAY_EDITABLE] = 0xFFD6F1FF -- 禁用输入框: 浅蓝灰

-- 文字组（深色但保留风格）
d.type_11[code.EGDC_BUTTON_TEXT] = 0xF0D6006B -- 主文字: 深莓红 (高对比)
d.type_11[code.EGDC_GRAY_TEXT] = 0xF0FF75B1 -- 禁用文字: 浅粉 (仍可读)
d.type_11[code.EGDC_WINDOW_SYMBOL] = 0xC8004E8B -- 图标文字: 深海军蓝
d.type_11[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF075C9FF

-- 工具提示组（清晰可读）
d.type_11[code.EGDC_TOOLTIP] = 0xC8004E8B -- 工具提示文字: 深蓝
d.type_11[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8FFFFFF -- 背景: 纯白半透明
d.type_11[code.EGDC_SCROLLBAR] = 0x65FF69B4 -- 滚动条: 草莓粉
d.type_11[code.EGDC_ICON] = 0xC8FFB6C1 -- 图标: 浅樱花粉
d.type_11[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF1493 -- 高亮图标: 唇色

-- 非活动状态（降低干扰）
d.type_11[code.EGDC_INACTIVE_BORDER] = 0x6575C9FF -- 非活动边框: 浅蓝天
d.type_11[code.EGDC_INACTIVE_CAPTION] = 0xFFB4E8FF -- 非活动标题: 褪色蓝

-- 聚焦特效（保持浪漫但清晰）
d.type_11[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFF0F5 -- 聚焦输入框: 浅粉光晕

d.type_12 = {}
-- 暗黑基底组 (模拟决斗场阴影)
d.type_12[code.EGDC_3D_DARK_SHADOW] = 0x651A0A2A -- 深紫黑: 黑暗游戏结界
d.type_12[code.EGDC_3D_SHADOW] = 0x653D1A5A -- 中紫: 魔法阵暗部
d.type_12[code.EGDC_3D_FACE] = 0x655A2D8C -- 主色: 暗游戏披风紫
d.type_12[code.EGDC_3D_HIGH_LIGHT] = 0x65FFD700 -- 高光: 千年积木金
d.type_12[code.EGDC_3D_LIGHT] = 0x658C6AFF -- 辅助光: 魔法卡辉光

-- 焦点元素组 (高对比色)
d.type_12[code.EGDC_ACTIVE_BORDER] = 0x65FF0000 -- 活动边框: 红眼黑龙红
d.type_12[code.EGDC_ACTIVE_CAPTION] = 0xFFFFD700 -- 标题栏: 千年神器金
d.type_12[code.EGDC_HIGH_LIGHT] = 0x65FF4500 -- 选中项: 橙红(黑魔导爆裂)
d.type_12[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF -- 高亮文字: 纯白

-- 背景组 (卡牌质感)
d.type_12[code.EGDC_APP_WORKSPACE] = 0x65220044 -- 工作区: 暗紫卡背
d.type_12[code.EGDC_WINDOW] = 0x65330077 -- 窗口: 魔法阵基底
d.type_12[code.EGDC_EDITABLE] = 0xFF110022 -- 输入框: 深紫黑
d.type_12[code.EGDC_GRAY_EDITABLE] = 0xFF3D1A5A -- 禁用输入框: 灰紫

-- 文字组 (绝对可读)
d.type_12[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 主文字: 纯白(如卡牌描述)
d.type_12[code.EGDC_GRAY_TEXT] = 0xF0FFD700 -- 禁用文字: 金色(仍醒目)
d.type_12[code.EGDC_WINDOW_SYMBOL] = 0xC8FFFFFF -- 图标文字: 纯白
d.type_12[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF08C6AFF -- 灰图标文字: 紫光

-- 功能组 (保留动画特效)
d.type_12[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 工具提示: 白字(如效果说明)
d.type_12[code.EGDC_TOOLTIP_BACKGROUND] = 0xC81A0A2A -- 背景: 半透暗紫
d.type_12[code.EGDC_SCROLLBAR] = 0x65FF4500 -- 滚动条: 橙红(魔力指示物)
d.type_12[code.EGDC_ICON] = 0xC8FFD700 -- 图标: 金色(星阶)
d.type_12[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF0000 -- 高亮图标: 红(攻击表示)

-- 非活动状态 (降低存在感)
d.type_12[code.EGDC_INACTIVE_BORDER] = 0x653D1A5A -- 非活动边框: 灰紫
d.type_12[code.EGDC_INACTIVE_CAPTION] = 0xFF5A2D8C -- 非活动标题: 褪色紫

-- 战斗特效 (如生命值变动)
d.type_12[code.EGDC_FOCUSED_EDITABLE] = 0xFF7700CC -- 聚焦输入框: 紫红光晕

d.type_13 = {}
-- 暗黑基底组 (模拟决斗场+千年积木)
d.type_13[code.EGDC_3D_DARK_SHADOW] = 0x65100030 -- 深紫黑: 黑暗游戏结界
d.type_13[code.EGDC_3D_SHADOW] = 0x65402080 -- 中紫: 魔法阵暗部
d.type_13[code.EGDC_3D_FACE] = 0x657030CF -- 主色: 暗游戏披风紫
d.type_13[code.EGDC_3D_HIGH_LIGHT] = 0x65FFD700 -- 高光: 千年积木金
d.type_13[code.EGDC_3D_LIGHT] = 0x65A060FF -- 辅助光: 魔法卡辉光

-- 焦点元素组 (高饱和对比)
d.type_13[code.EGDC_ACTIVE_BORDER] = 0x65FF3000 -- 活动边框: 真红眼黑龙红
d.type_13[code.EGDC_ACTIVE_CAPTION] = 0xFFFFD700 -- 标题栏: 千年神器金
d.type_13[code.EGDC_HIGH_LIGHT] = 0x65FF6000 -- 选中项: 黑魔导爆裂橙
d.type_13[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0000000 -- 高亮文字: 纯黑(确保金色背景可读)

-- 背景组 (卡背质感)
d.type_13[code.EGDC_APP_WORKSPACE] = 0x65180040 -- 工作区: 魔法阵基底
d.type_13[code.EGDC_WINDOW] = 0x65300090 -- 窗口: 暗游戏领域
d.type_13[code.EGDC_EDITABLE] = 0xFF200050 -- 输入框: 深紫黑
d.type_13[code.EGDC_GRAY_EDITABLE] = 0xFF402080 -- 禁用输入框: 灰紫

-- ==== 关键优化区域 ==== --
-- 文字组 (严格区分层级)
d.type_13[code.EGDC_BUTTON_TEXT] = 0xF0D0A020 -- 按钮文字: 暗金色(如卡牌文字)
d.type_13[code.EGDC_GRAY_TEXT] = 0xF0A060FF -- 禁用文字: 紫光(仍可见)
d.type_13[code.EGDC_WINDOW_SYMBOL] = 0xC8FFFFFF -- 图标文字: 纯白
d.type_13[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF07030CF -- 灰图标文字: 褪色紫

-- 工具提示组 (独立视觉层级)
d.type_13[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 工具提示文字: 纯白
d.type_13[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8200050 -- 背景: 半透深紫(比窗口更深)
d.type_13[code.EGDC_SCROLLBAR] = 0x65FF6000 -- 滚动条: 魔力计数橙
d.type_13[code.EGDC_ICON] = 0xC8FFD700 -- 图标: 金色(星阶)
d.type_13[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF3000 -- 高亮图标: 红(攻击表示)

-- 非活动状态 (降低干扰)
d.type_13[code.EGDC_INACTIVE_BORDER] = 0x65402080 -- 非活动边框: 灰紫
d.type_13[code.EGDC_INACTIVE_CAPTION] = 0xFF7030CF -- 非活动标题: 褪色紫

-- 特效组 (动画还原)
d.type_13[code.EGDC_FOCUSED_EDITABLE] = 0xFF9000FF -- 聚焦输入框: 紫红光晕

d.type_14 = {}
-- 圣光与暗影基底
d.type_14[code.EGDC_3D_DARK_SHADOW] = 0x65001F3D -- 深蓝黑: 教导龙背景
d.type_14[code.EGDC_3D_SHADOW] = 0x65003C7D -- 中暗蓝: 魔法阵暗部
d.type_14[code.EGDC_3D_FACE] = 0x65E0F0FF -- 主色: 圣女圣光
d.type_14[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFFFF -- 高光: 纯白圣痕
d.type_14[code.EGDC_3D_LIGHT] = 0x6580C0FF -- 辅助光: 教导符文蓝

-- 核心交互元素 (高对比)
d.type_14[code.EGDC_ACTIVE_BORDER] = 0x65FFD700 -- 活动边框: 黄金律法
d.type_14[code.EGDC_ACTIVE_CAPTION] = 0xFFFFF0A0 -- 标题栏: 圣典文字金
d.type_14[code.EGDC_HIGH_LIGHT] = 0x650070CC -- 选中项: 深蓝(教导龙瞳)
d.type_14[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF -- 高亮文字: 纯白

-- 背景组 (层级分明)
d.type_14[code.EGDC_APP_WORKSPACE] = 0x65002050 -- 工作区: 暗蓝圣堂
d.type_14[code.EGDC_WINDOW] = 0x65C0E0FF -- 窗口: 冰晶圣光
d.type_14[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 输入框: 纯白圣典
d.type_14[code.EGDC_GRAY_EDITABLE] = 0xFFA0C0E0 -- 禁用输入框: 褪色圣光

-- ==== 关键优化区域 ==== --
-- 文字组 (严格区分类型)
d.type_14[code.EGDC_BUTTON_TEXT] = 0xF0003070 -- 按钮文字: 深蓝(如教条文本)
d.type_14[code.EGDC_GRAY_TEXT] = 0xF080C0FF -- 禁用文字: 浅符文蓝
d.type_14[code.EGDC_WINDOW_SYMBOL] = 0xC8001F3D -- 图标文字: 暗蓝(教导龙鳞)
d.type_14[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0003C7D -- 灰图标文字

-- 工具提示组 (独立悬浮层级)
d.type_14[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 工具提示文字: 纯白
d.type_14[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8001F3D -- 背景: 半透暗蓝(比窗口深30%)
d.type_14[code.EGDC_SCROLLBAR] = 0x65FFD700 -- 滚动条: 黄金律法
d.type_14[code.EGDC_ICON] = 0xC8FFFFFF -- 图标: 圣洁白
d.type_14[code.EGDC_ICON_HIGH_LIGHT] = 0xC80070CC -- 高亮图标: 龙瞳蓝

-- 非活动状态 (圣光衰减)
d.type_14[code.EGDC_INACTIVE_BORDER] = 0x65003C7D -- 非活动边框: 褪色符文
d.type_14[code.EGDC_INACTIVE_CAPTION] = 0xFFA0C0E0 -- 非活动标题: 灰圣光

-- 特效组 (神圣爆发)
d.type_14[code.EGDC_FOCUSED_EDITABLE] = 0xFFE0F8FF -- 聚焦输入框: 圣光晕染

d.type_15 = {}
-- 3D元素组（红金渐变）
d.type_15[code.EGDC_3D_DARK_SHADOW] = 0x65800000 -- 暗红阴影(如卡组边框)
d.type_15[code.EGDC_3D_SHADOW] = 0x65CC0000 -- 烈焰红中间调
d.type_15[code.EGDC_3D_FACE] = 0x65FFD700 -- 决斗盘金色主表面
d.type_15[code.EGDC_3D_HIGH_LIGHT] = 0x65FFEE99 -- 闪光黄高光
d.type_15[code.EGDC_3D_LIGHT] = 0x65FFAA00 -- 英雄之证橙黄

-- 界面框架组（高对比度）
d.type_15[code.EGDC_ACTIVE_BORDER] = 0x65A60000 -- 激活边框(如LP血条红)
d.type_15[code.EGDC_ACTIVE_CAPTION] = 0xFFFFCC00 -- 闪光黄标题栏
d.type_15[code.EGDC_APP_WORKSPACE] = 0x651A1212 -- 暗红战场背景
d.type_15[code.EGDC_INACTIVE_BORDER] = 0x654A3A3A -- 未激活深灰红边框
d.type_15[code.EGDC_INACTIVE_CAPTION] = 0xFF332222 -- 暗红标题栏

-- 文字组（确保战斗清晰度）
d.type_15[code.EGDC_BUTTON_TEXT] = 0xF0000000 -- 绝对黑(卡牌文字)
d.type_15[code.EGDC_GRAY_TEXT] = 0xF0666666 -- 失效灰
d.type_15[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF -- 纯白(生命值显示)
d.type_15[code.EGDC_WINDOW_SYMBOL] = 0xC8000000 -- 黑图标
d.type_15[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0555555 -- 灰图标

-- 交互组（动态效果）
d.type_15[code.EGDC_HIGH_LIGHT] = 0x65FF6600 -- 抽卡时橙光
d.type_15[code.EGDC_SCROLLBAR] = 0x65FFAA33 -- 滚动条火焰色
d.type_15[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 卡组编辑白底
d.type_15[code.EGDC_GRAY_EDITABLE] = 0xFFDDDDDD -- 失效输入框
d.type_15[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFACD -- 聚焦米黄

-- 辅助组（保留游戏特色）
d.type_15[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 白底黑字提示
d.type_15[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8330000 -- 暗红提示背景
d.type_15[code.EGDC_WINDOW] = 0x65FFFFFF -- 卡牌白底
d.type_15[code.EGDC_ICON] = 0xC8FFCC00 -- 金色星尘图标
d.type_15[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF3300 -- 红莲高亮

d.type_16 = {}
d.type_16[code.EGDC_3D_DARK_SHADOW] = 0x65450000 -- 深红色阴影
d.type_16[code.EGDC_3D_SHADOW] = 0x65800000 -- 红色阴影
d.type_16[code.EGDC_3D_FACE] = 0x65FF0000 -- 红色主表面
d.type_16[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFF00 -- 黄色高光
d.type_16[code.EGDC_3D_LIGHT] = 0x65FF4500 -- 橙红色亮部
d.type_16[code.EGDC_ACTIVE_BORDER] = 0x65FF0000 -- 红色活动边框
d.type_16[code.EGDC_ACTIVE_CAPTION] = 0xFFFFD700 -- 金色标题
d.type_16[code.EGDC_APP_WORKSPACE] = 0x65222222 -- 深灰工作区
d.type_16[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 白色按钮文字
d.type_16[code.EGDC_GRAY_TEXT] = 0xF0AAAAAA -- 灰色文字
d.type_16[code.EGDC_HIGH_LIGHT] = 0x65FF0000 -- 红色高亮
d.type_16[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFF00 -- 黄色高亮文字
d.type_16[code.EGDC_INACTIVE_BORDER] = 0x65800000 -- 暗红非活动边框
d.type_16[code.EGDC_INACTIVE_CAPTION] = 0xFF800000 -- 暗红非活动标题
d.type_16[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 白色工具提示文字
d.type_16[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8B00000 -- 深红工具提示背景
d.type_16[code.EGDC_SCROLLBAR] = 0x65FF4500 -- 橙红色滚动条
d.type_16[code.EGDC_WINDOW] = 0x65111111 -- 深灰窗口
d.type_16[code.EGDC_WINDOW_SYMBOL] = 0xC8FFD700 -- 金色窗口符号
d.type_16[code.EGDC_ICON] = 0xC8FFD700 -- 金色图标
d.type_16[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF0000 -- 红色图标高亮
d.type_16[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0800000 -- 暗红灰色窗口符号
d.type_16[code.EGDC_EDITABLE] = 0xFF222222 -- 深灰可编辑区
d.type_16[code.EGDC_GRAY_EDITABLE] = 0xFF444444 -- 中灰可编辑区
d.type_16[code.EGDC_FOCUSED_EDITABLE] = 0xFF330000 -- 深红聚焦可编辑区

d.type_17 = {}
-- 3D元素组（星空蓝渐变）
d.type_17[code.EGDC_3D_DARK_SHADOW] = 0x65001F5E -- 深空蓝阴影(如卡组边框)
d.type_17[code.EGDC_3D_SHADOW] = 0x65003CA6 -- 宇宙蓝中间调
d.type_17[code.EGDC_3D_FACE] = 0x65E6F7FF -- 星光体白蓝主表面
d.type_17[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFF8D -- 希望皇金色高光
d.type_17[code.EGDC_3D_LIGHT] = 0x6500C8FF -- 银河眼水蓝光

-- 界面框架组（ZEXAL科技感）
d.type_17[code.EGDC_ACTIVE_BORDER] = 0x65007BFF -- 激活边框(如LP蓝光)
d.type_17[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFF8D -- 金色标题栏(带星尘粒子)
d.type_17[code.EGDC_APP_WORKSPACE] = 0x6500123C -- 深空背景(带星云纹理)
d.type_17[code.EGDC_INACTIVE_BORDER] = 0x654A6DA6 -- 未激活深蓝边框
d.type_17[code.EGDC_INACTIVE_CAPTION] = 0xFF1A3C6E -- 暗蓝标题栏

-- 文字组（绝对可读性）
d.type_17[code.EGDC_BUTTON_TEXT] = 0xF0000000 -- 纯黑(卡牌文字)
d.type_17[code.EGDC_GRAY_TEXT] = 0xF0666666 -- 失效灰
d.type_17[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF -- 纯白(生命值显示)
d.type_17[code.EGDC_WINDOW_SYMBOL] = 0xC8005AFF -- 蓝图标(No.系特效)
d.type_17[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF055A4FF -- 浅蓝灰图标

-- 交互组（超量召唤特效）
d.type_17[code.EGDC_HIGH_LIGHT] = 0x6500FFFF -- 选中时青眼光效
d.type_17[code.EGDC_SCROLLBAR] = 0x6588FFFF -- 滚动条星尘蓝
d.type_17[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 卡组编辑白底
d.type_17[code.EGDC_GRAY_EDITABLE] = 0xFFCCE5FF -- 失效输入框(浅蓝)
d.type_17[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFACD -- 聚焦金边

-- 辅助组（No.卡特色）
d.type_17[code.EGDC_TOOLTIP] = 0xC8000000 -- 黑字白边(如No.卡描述)
d.type_17[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8E6F9FF -- 浅蓝透明背景
d.type_17[code.EGDC_WINDOW] = 0x65FFFFFF -- 卡牌白底
d.type_17[code.EGDC_ICON] = 0xC800A8FF -- No.39金刃图标
d.type_17[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FFDD00 -- 希望皇黄高亮

d.type_18 = {}
d.type_18[code.EGDC_3D_DARK_SHADOW] = 0x65101010 -- 深黑阴影（金属感）
d.type_18[code.EGDC_3D_SHADOW] = 0x65303030 -- 暗灰阴影（机械结构）
d.type_18[code.EGDC_3D_FACE] = 0x65C0C0C0 -- 金属灰主表面
d.type_18[code.EGDC_3D_HIGH_LIGHT] = 0x65FF3300 -- 游星标志性红色高光
d.type_18[code.EGDC_3D_LIGHT] = 0x65E0E0E0 -- 亮金属灰
d.type_18[code.EGDC_ACTIVE_BORDER] = 0x65FF3300 -- 红色活动边框（D轮风格）
d.type_18[code.EGDC_ACTIVE_CAPTION] = 0xFFFF3300 -- 红色标题（高对比）
d.type_18[code.EGDC_APP_WORKSPACE] = 0x65181818 -- 深灰背景（科技感）
d.type_18[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 白色按钮文字（清晰）
d.type_18[code.EGDC_GRAY_TEXT] = 0xF0A0A0A0 -- 浅灰文字（辅助信息）
d.type_18[code.EGDC_HIGH_LIGHT] = 0x65FF6600 -- 橙红高亮（D轮尾焰色）
d.type_18[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFF00 -- 黄色高亮文字（强调）
d.type_18[code.EGDC_INACTIVE_BORDER] = 0x65404040 -- 深灰非活动边框
d.type_18[code.EGDC_INACTIVE_CAPTION] = 0xFF404040 -- 深灰非活动标题
d.type_18[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 白色工具提示文字
d.type_18[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8202020 -- 深灰工具提示背景
d.type_18[code.EGDC_SCROLLBAR] = 0x65FF3300 -- 红色滚动条（D轮风格）
d.type_18[code.EGDC_WINDOW] = 0x65202020 -- 深灰窗口背景
d.type_18[code.EGDC_WINDOW_SYMBOL] = 0xC8FF3300 -- 红色窗口符号
d.type_18[code.EGDC_ICON] = 0xC8FFCC00 -- 金色图标（科技感）
d.type_18[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF3300 -- 红色图标高亮
d.type_18[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0606060 -- 深灰窗口符号
d.type_18[code.EGDC_EDITABLE] = 0xFF252525 -- 深灰可编辑区
d.type_18[code.EGDC_GRAY_EDITABLE] = 0xFF353535 -- 中灰可编辑区
d.type_18[code.EGDC_FOCUSED_EDITABLE] = 0xFF502000 -- 深红棕聚焦可编辑区（D轮引擎色）

d.type_19 = {}
-- 3D元素组（骸骨质感）
d.type_19[code.EGDC_3D_DARK_SHADOW] = 0x65210042 -- 深渊紫黑(骨关节阴影)
d.type_19[code.EGDC_3D_SHADOW] = 0x654A0D6E -- 亡灵紫中间调
d.type_19[code.EGDC_3D_FACE] = 0x65E6D1FF -- 骸骨珍珠白主表面
d.type_19[code.EGDC_3D_HIGH_LIGHT] = 0x65FFD700 -- 亡灵金高光(骨刺反光)
d.type_19[code.EGDC_3D_LIGHT] = 0x659847FF -- 幽魂紫光效

-- 界面框架组（墓地风格）
d.type_19[code.EGDC_ACTIVE_BORDER] = 0x65FF00DC -- 激活边框(灵魂紫光)
d.type_19[code.EGDC_ACTIVE_CAPTION] = 0xFFFFD700 -- 骸骨金标题栏
d.type_19[code.EGDC_APP_WORKSPACE] = 0x65110022 -- 墓穴黑紫背景
d.type_19[code.EGDC_INACTIVE_BORDER] = 0x653D2966 -- 石棺灰紫边框
d.type_19[code.EGDC_INACTIVE_CAPTION] = 0xFF2E004D -- 腐化紫标题栏

-- 文字组（白骨刻字效果）
d.type_19[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 白骨白(绝对可读)
d.type_19[code.EGDC_GRAY_TEXT] = 0xF0A78BBF -- 褪色紫灰
d.type_19[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFD700 -- 灵魂金字
d.type_19[code.EGDC_WINDOW_SYMBOL] = 0xC8FFD700 -- 黄金骨图标
d.type_19[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF07A5ABF -- 半透明紫灰

-- 交互组（亡灵特效）
d.type_19[code.EGDC_HIGH_LIGHT] = 0x65C900FF -- 选中时紫焰
d.type_19[code.EGDC_SCROLLBAR] = 0x65B47AFF -- 滚动条骨节紫
d.type_19[code.EGDC_EDITABLE] = 0xFF222034 -- 墓志铭石板灰
d.type_19[code.EGDC_GRAY_EDITABLE] = 0xFF3A2955 -- 腐蚀紫输入框
d.type_19[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFF0D7 -- 聚焦骨米黄

-- 辅助组（卡牌元素）
d.type_19[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 白骨白提示文字
d.type_19[code.EGDC_TOOLTIP_BACKGROUND] = 0xD8200028 -- 血紫透明背景
d.type_19[code.EGDC_WINDOW] = 0x65FFFFFF -- 卡牌白骨底
d.type_19[code.EGDC_ICON] = 0xC8D4B47A -- 古旧铜绿图标
d.type_19[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FFA724 -- 灵魂之火橙

d.type_20 = {}
d.type_20[code.EGDC_3D_DARK_SHADOW] = 0x65001A33 -- 深海军蓝阴影（龙翼阴影）
d.type_20[code.EGDC_3D_SHADOW] = 0x65003366 -- 中蓝色阴影（龙鳞层次）
d.type_20[code.EGDC_3D_FACE] = 0x6566B3FF -- 青眼白龙蓝主表面
d.type_20[code.EGDC_3D_HIGH_LIGHT] = 0x65FFFFFF -- 白龙高光
d.type_20[code.EGDC_3D_LIGHT] = 0x6599CCFF -- 浅龙鳞蓝
d.type_20[code.EGDC_ACTIVE_BORDER] = 0x657700FF -- 紫晶龙骑士边框
d.type_20[code.EGDC_ACTIVE_CAPTION] = 0xFF0066CC -- 龙瞳蓝色标题
d.type_20[code.EGDC_APP_WORKSPACE] = 0x650D0D2B -- 深紫黑背景（骑士披风）
d.type_20[code.EGDC_BUTTON_TEXT] = 0xF0E6F9FF -- 淡蓝白按钮文字
d.type_20[code.EGDC_GRAY_TEXT] = 0xF06699CC -- 灰蓝文字（辅助信息）
d.type_20[code.EGDC_HIGH_LIGHT] = 0x654400BB -- 紫晶高亮（骑士宝石）
d.type_20[code.EGDC_HIGH_LIGHT_TEXT] = 0xF099FFFF -- 龙息蓝高亮文字
d.type_20[code.EGDC_INACTIVE_BORDER] = 0x65222255 -- 深紫非活动边框
d.type_20[code.EGDC_INACTIVE_CAPTION] = 0xFF333366 -- 暗龙鳞非活动标题
d.type_20[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 白龙色工具提示文字
d.type_20[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8001A4D -- 龙血紫工具提示背景
d.type_20[code.EGDC_SCROLLBAR] = 0x6566B3FF -- 青眼蓝滚动条（龙尾）
d.type_20[code.EGDC_WINDOW] = 0x65111133 -- 紫黑窗口背景（骑士铠甲）
d.type_20[code.EGDC_WINDOW_SYMBOL] = 0xC899CCFF -- 龙鳞蓝窗口符号
d.type_20[code.EGDC_ICON] = 0xC8FFFFFF -- 白龙色图标
d.type_20[code.EGDC_ICON_HIGH_LIGHT] = 0xC87700FF -- 紫晶高亮（骑士剑光）
d.type_20[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0446688 -- 暗龙鳞灰窗口符号
d.type_20[code.EGDC_EDITABLE] = 0xFF0A0A2A -- 深紫黑可编辑区
d.type_20[code.EGDC_GRAY_EDITABLE] = 0xFF1A1A3A -- 中紫黑可编辑区
d.type_20[code.EGDC_FOCUSED_EDITABLE] = 0xFF3300AA -- 紫晶聚焦可编辑区（龙骑士能量）

d.type_21 = {}
-- 3D元素组（机械圣殿质感）
d.type_21[code.EGDC_3D_DARK_SHADOW] = 0x65001F4D -- 神谕深蓝阴影(机械结构凹槽)
d.type_21[code.EGDC_3D_SHADOW] = 0x65003C9E -- 电路板中间调蓝
d.type_21[code.EGDC_3D_FACE] = 0x65E0F7FF -- 圣械冷光白主表面
d.type_21[code.EGDC_3D_HIGH_LIGHT] = 0x65FFEE66 -- 神性金高光(机械边缘)
d.type_21[code.EGDC_3D_LIGHT] = 0x6500D8FF -- 电子回路流光

-- 界面框架组（神谕终端风格）
d.type_21[code.EGDC_ACTIVE_BORDER] = 0x65007BFF -- 激活边框(如仪式光效)
d.type_21[code.EGDC_ACTIVE_CAPTION] = 0xFFCCEEFF -- 全息蓝白标题栏
d.type_21[code.EGDC_APP_WORKSPACE] = 0x65000F2C -- 深空终端背景
d.type_21[code.EGDC_INACTIVE_BORDER] = 0x654A66AA -- 休眠状态灰蓝边框
d.type_21[code.EGDC_INACTIVE_CAPTION] = 0xFF1A3C6E -- 低功耗模式标题栏

-- 文字组（机械铭文清晰度）
d.type_21[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 绝对白(发光文字)
d.type_21[code.EGDC_GRAY_TEXT] = 0xF088AACC -- 失效文字(带电子残影)
d.type_21[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFDD00 -- 神谕金字(关键指令)
d.type_21[code.EGDC_WINDOW_SYMBOL] = 0xC800AAFF -- 龙辉巧核心蓝图标
d.type_21[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF05599FF -- 半激活状态图标

-- 交互组（仪式启动特效）
d.type_21[code.EGDC_HIGH_LIGHT] = 0x6500FFFF -- 选中时神光环绕
d.type_21[code.EGDC_SCROLLBAR] = 0x6588EEFF -- 数据流滚动条
d.type_21[code.EGDC_EDITABLE] = 0xFF002244 -- 指令输入黑底蓝纹
d.type_21[code.EGDC_GRAY_EDITABLE] = 0xFF113355 -- 禁用输入框
d.type_21[code.EGDC_FOCUSED_EDITABLE] = 0xFFAAEEFF -- 聚焦全息蓝

-- 辅助组（机械神性元素）
d.type_21[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 全息白提示文字
d.type_21[code.EGDC_TOOLTIP_BACKGROUND] = 0xD8002A55 -- 神谕蓝透明背景
d.type_21[code.EGDC_WINDOW] = 0x65FFFFFF -- 卡牌冷光白底
d.type_21[code.EGDC_ICON] = 0xC800CCFF -- 龙辉巧纹章图标
d.type_21[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FFCC33 -- 神性金高亮

d.type_22 = {}
-- 3D元素组（星云质感）
d.type_22[code.EGDC_3D_DARK_SHADOW] = 0x6521006F -- 宇宙暗紫(星云阴影)
d.type_22[code.EGDC_3D_SHADOW] = 0x654D00B3 -- 银河紫中间调
d.type_22[code.EGDC_3D_FACE] = 0x65E6FAFF -- 星尘白主表面(带粒子光)
d.type_22[code.EGDC_3D_HIGH_LIGHT] = 0x65B8E2FF -- 星态龙翼尖蓝高光
d.type_22[code.EGDC_3D_LIGHT] = 0x65945CFF -- 极光紫特效

-- 界面框架组（星环结构）
d.type_22[code.EGDC_ACTIVE_BORDER] = 0x6500D8FF -- 激活边框(星轨蓝光)
d.type_22[code.EGDC_ACTIVE_CAPTION] = 0xFFB8E2FF -- 星云蓝白标题栏
d.type_22[code.EGDC_APP_WORKSPACE] = 0x65001F4D -- 深空背景(带星点)
d.type_22[code.EGDC_INACTIVE_BORDER] = 0x656D4DFF -- 休眠紫晶边框
d.type_22[code.EGDC_INACTIVE_CAPTION] = 0xFF4D0099 -- 暗星云紫标题栏

-- 文字组（星尘铭文）
d.type_22[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 绝对白(发光星文)
d.type_22[code.EGDC_GRAY_TEXT] = 0xF0A8C4FF -- 星尘残影蓝灰
d.type_22[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFD700 -- 星核金字
d.type_22[code.EGDC_WINDOW_SYMBOL] = 0xC88CE8FF -- 星态龙瞳图标
d.type_22[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF06D4DFF -- 脉冲星紫图标

-- 交互组（星脉流动）
d.type_22[code.EGDC_HIGH_LIGHT] = 0x6577D8FF -- 选中时星链缠绕
d.type_22[code.EGDC_SCROLLBAR] = 0x6594B8FF -- 星尘带滚动条
d.type_22[code.EGDC_EDITABLE] = 0xFF001F33 -- 黑洞输入框黑底
d.type_22[code.EGDC_GRAY_EDITABLE] = 0xFF2A3F66 -- 星云灰禁用态
d.type_22[code.EGDC_FOCUSED_EDITABLE] = 0xFFE6FAFF -- 聚焦星尘白

-- 辅助组（星象仪元素）
d.type_22[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 星芒白提示文字
d.type_22[code.EGDC_TOOLTIP_BACKGROUND] = 0xD8003F7F -- 星云紫透明背景
d.type_22[code.EGDC_WINDOW] = 0x65FFFFFF -- 卡牌星尘底
d.type_22[code.EGDC_ICON] = 0xC800B4FF -- 星态龙核心蓝
d.type_22[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FFEE66 -- 星核金高亮

d.type_23 = {}
-- 3D元素组（千年寒冰质感）
d.type_23[code.EGDC_3D_DARK_SHADOW] = 0x65005296 -- 深冰蓝阴影(冰层裂隙)
d.type_23[code.EGDC_3D_SHADOW] = 0x65007CB4 -- 冰川中间调蓝
d.type_23[code.EGDC_3D_FACE] = 0x65F0FFFFFF -- 绝对冰晶白主表面
d.type_23[code.EGDC_3D_HIGH_LIGHT] = 0x65A0FFFF -- 极光蓝高光(冰刃反光)
d.type_23[code.EGDC_3D_LIGHT] = 0x6500E4FF -- 冰结龙吐息光效

-- 界面框架组（封印阵结构）
d.type_23[code.EGDC_ACTIVE_BORDER] = 0x6500B4FF -- 激活边框(结界启动蓝光)
d.type_23[code.EGDC_ACTIVE_CAPTION] = 0xFFD0FFFF -- 极光白标题栏
d.type_23[code.EGDC_APP_WORKSPACE] = 0x65001F4D -- 永冻层深蓝背景
d.type_23[code.EGDC_INACTIVE_BORDER] = 0x6566A3CC -- 休眠冰晶灰蓝边框
d.type_23[code.EGDC_INACTIVE_CAPTION] = 0xFF336699 -- 冰封状态标题栏

-- 文字组（冰雕铭文效果）
d.type_23[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 绝对冰白(发光文字)
d.type_23[code.EGDC_GRAY_TEXT] = 0xF088CCFF -- 薄冰透蓝灰
d.type_23[code.EGDC_HIGH_LIGHT_TEXT] = 0xF000FFFF -- 结界核心蓝字
d.type_23[code.EGDC_WINDOW_SYMBOL] = 0xC800D4FF -- 三叉龙图标
d.type_23[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF066A3CC -- 冰结雾凇图标

-- 交互组（冰脉流动特效）
d.type_23[code.EGDC_HIGH_LIGHT] = 0x6500FFFF -- 选中时冰环扩散
d.type_23[code.EGDC_SCROLLBAR] = 0x6588EEFF -- 冰晶棱柱滚动条
d.type_23[code.EGDC_EDITABLE] = 0xFF002244 -- 冰窟输入框黑底
d.type_23[code.EGDC_GRAY_EDITABLE] = 0xFF225577 -- 霜冻禁用态
d.type_23[code.EGDC_FOCUSED_EDITABLE] = 0xFFAAFFFF -- 聚焦极光蓝

-- 辅助组（冰结界元素）
d.type_23[code.EGDC_TOOLTIP] = 0xC8FFFFFF -- 冰晶白提示文字
d.type_23[code.EGDC_TOOLTIP_BACKGROUND] = 0xD8003F7F -- 结界蓝透明背景
d.type_23[code.EGDC_WINDOW] = 0x65FFFFFF -- 卡牌冰晶底
d.type_23[code.EGDC_ICON] = 0xC800AAFF -- 冰结界纹章
d.type_23[code.EGDC_ICON_HIGH_LIGHT] = 0xC8A0FFFF -- 光木仓龙高光

d.type_24 = {}
d.type_24[code.EGDC_3D_DARK_SHADOW] = 0x65001122 -- 宇宙深空底色（超越龙本体暗部）
d.type_24[code.EGDC_3D_SHADOW] = 0x65002244 -- 星云过渡色（翅膀阴影层）
d.type_24[code.EGDC_3D_FACE] = 0x65336699 -- 星尘龙鳞主色（卡面背景蓝）
d.type_24[code.EGDC_3D_HIGH_LIGHT] = 0x6599CCFF -- 进化光效（超越龙光环）
d.type_24[code.EGDC_3D_LIGHT] = 0x6566AACC -- 星间物质亮部
d.type_24[code.EGDC_ACTIVE_BORDER] = 0x65FFCC00 -- 黄金进化纹（卡面金边）
d.type_24[code.EGDC_ACTIVE_CAPTION] = 0xFFFFEE66 -- 神圣进化光（标题光效）
d.type_24[code.EGDC_APP_WORKSPACE] = 0x65000816 -- 深空宙域（卡图背景）
d.type_24[code.EGDC_BUTTON_TEXT] = 0xF0FFFFFF -- 星辉白（最高亮度文字）
d.type_24[code.EGDC_GRAY_TEXT] = 0xF066AACC -- 星际尘埃（辅助文字）
d.type_24[code.EGDC_HIGH_LIGHT] = 0x6544AAFF -- 超量光点（召唤阵亮色）
d.type_24[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFCC00 -- 进化符文（关键文字）
d.type_24[code.EGDC_INACTIVE_BORDER] = 0x65112255 -- 休眠状态紫（未激活边框）
d.type_24[code.EGDC_INACTIVE_CAPTION] = 0xFF334477 -- 星云休眠态（未激活标题）
d.type_24[code.EGDC_TOOLTIP] = 0xC8EEFFFF -- 银河粒子（提示文字）
d.type_24[code.EGDC_TOOLTIP_BACKGROUND] = 0xC8002244 -- 星云帷幕（提示背景）
d.type_24[code.EGDC_SCROLLBAR] = 0x6544AAFF -- 超量通道（滚动条光带）
d.type_24[code.EGDC_WINDOW] = 0x65001133 -- 暗物质空间（主窗口）
d.type_24[code.EGDC_WINDOW_SYMBOL] = 0xC8FFCC00 -- 神圣刻印（界面符号）
d.type_24[code.EGDC_ICON] = 0xC899CCFF -- 星尘结晶（图标主色）
d.type_24[code.EGDC_ICON_HIGH_LIGHT] = 0xC8FF9900 -- 进化焦点（图标高亮）
d.type_24[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xF0446688 -- 星际残影（非活跃符号）
d.type_24[code.EGDC_EDITABLE] = 0xFF001133 -- 次元裂缝（输入区底色）
d.type_24[code.EGDC_GRAY_EDITABLE] = 0xFF112244 -- 星间尘埃（非活跃输入区）
d.type_24[code.EGDC_FOCUSED_EDITABLE] = 0xFF3366FF -- 超量激活（聚焦态光效）

d.type_25 = {}
-- 基础3D效果色
d.type_25[code.EGDC_3D_DARK_SHADOW] = 0xFF434343 -- 深阴影
d.type_25[code.EGDC_3D_SHADOW] = 0xFF888888 -- 普通阴影
d.type_25[code.EGDC_3D_FACE] = 0xFFCCCCCC -- 按钮面
d.type_25[code.EGDC_3D_HIGH_LIGHT] = 0xFFF0F0F0 -- 高亮
d.type_25[code.EGDC_3D_LIGHT] = 0xFFE0E0E0 -- 光源色

-- 窗口元素
d.type_25[code.EGDC_ACTIVE_BORDER] = 0xFF0058D8 -- 微软蓝边框
d.type_25[code.EGDC_ACTIVE_CAPTION] = 0xFF0078D7 -- 标题栏蓝
d.type_25[code.EGDC_INACTIVE_BORDER] = 0xFFABABAB -- 非活动边框
d.type_25[code.EGDC_INACTIVE_CAPTION] = 0xFF999999 -- 非活动标题
d.type_25[code.EGDC_APP_WORKSPACE] = 0xFFF0F0F0 -- 背景灰

-- 文本颜色
d.type_25[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 纯黑文本
d.type_25[code.EGDC_GRAY_TEXT] = 0xFF808080 -- 禁用文本
d.type_25[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 白色高亮文本

-- 选择/高亮
d.type_25[code.EGDC_HIGH_LIGHT] = 0xFF3399FF -- 选中蓝
d.type_25[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFE1 -- 聚焦编辑框

-- 工具提示
d.type_25[code.EGDC_TOOLTIP] = 0xFF000000 -- 工具提示文本
d.type_25[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFFFFFE1 -- 米黄背景

-- 滚动条
d.type_25[code.EGDC_SCROLLBAR] = 0xFFE0E0E0 -- 滚动条灰

-- 窗口背景
d.type_25[code.EGDC_WINDOW] = 0xFFFFFFFF -- 纯白背景
d.type_25[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 可编辑区白
d.type_25[code.EGDC_GRAY_EDITABLE] = 0xFFF0F0F0 -- 禁用编辑区

-- 图标
d.type_25[code.EGDC_ICON] = 0xFF000000 -- 黑色图标
d.type_25[code.EGDC_ICON_HIGH_LIGHT] = 0xFF3399FF -- 高亮蓝图标

-- 符号
d.type_25[code.EGDC_WINDOW_SYMBOL] = 0xFF000000 -- 窗口控制符号
d.type_25[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF808080 -- 禁用符号

d.type_26 = {}
-- 3D元素组
d.type_26[code.EGDC_3D_DARK_SHADOW] = 0xFF404040 -- 深阴影
d.type_26[code.EGDC_3D_SHADOW] = 0xFF808080 -- 标准阴影
d.type_26[code.EGDC_3D_FACE] = 0xFFC0C0C0 -- 按钮表面色
d.type_26[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF -- 高光
d.type_26[code.EGDC_3D_LIGHT] = 0xFFE0E0E0 -- 浅边缘

-- 窗口元素
d.type_26[code.EGDC_ACTIVE_BORDER] = 0xFF0054E3 -- 活动窗口边框(微软蓝)
d.type_26[code.EGDC_ACTIVE_CAPTION] = 0xFF0078D7 -- 活动标题栏
d.type_26[code.EGDC_INACTIVE_BORDER] = 0xFF808080 -- 非活动边框
d.type_26[code.EGDC_INACTIVE_CAPTION] = 0xFF999999 -- 非活动标题栏
d.type_26[code.EGDC_APP_WORKSPACE] = 0xFFABABAB -- 背景色

-- 文本组
d.type_26[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 按钮文本(黑)
d.type_26[code.EGDC_GRAY_TEXT] = 0xFF6D6D6D -- 禁用文本
d.type_26[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 高亮文本(白)
d.type_26[code.EGDC_WINDOW_SYMBOL] = 0xFF000000 -- 窗口控件符号

-- 交互元素
d.type_26[code.EGDC_HIGH_LIGHT] = 0xFF3399FF -- 选中项(亮蓝)
d.type_26[code.EGDC_SCROLLBAR] = 0xFFE5E5E5 -- 滚动条灰色
d.type_26[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 编辑框背景(白)
d.type_26[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFE1 -- 焦点编辑框(米黄)

-- 图标组
d.type_26[code.EGDC_ICON] = 0xFF000000 -- 标准图标(黑)
d.type_26[code.EGDC_ICON_HIGH_LIGHT] = 0xFF3399FF -- 高亮图标(蓝)

-- 工具提示
d.type_26[code.EGDC_TOOLTIP] = 0xFF000000 -- 工具提示文本
d.type_26[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFFFFFE1 -- 工具提示背景(米黄)

-- 特殊状态
d.type_26[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 -- 禁用编辑框
d.type_26[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0A0A0 -- 禁用控件符号
d.type_26[code.EGDC_WINDOW] = 0xFFFFFFFF -- 窗口背景(白)

d.type_27 = {}
-- 3D元素组（融入木叶护额金属色）
d.type_27[code.EGDC_3D_DARK_SHADOW] = 0xFF8B4513 -- 深土色（忍者皮革）
d.type_27[code.EGDC_3D_SHADOW] = 0xFFFF8C00 -- 鸣人橙阴影
d.type_27[code.EGDC_3D_FACE] = 0xFFFFA500 -- 按钮主色（标准鸣人橙）
d.type_27[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFF30 -- 金光色（九尾查克拉）
d.type_27[code.EGDC_3D_LIGHT] = 0xFFFFD700 -- 金属高光（护额色）

-- 窗口元素（木叶村主题）
d.type_27[code.EGDC_ACTIVE_BORDER] = 0xFF0066CC -- 深蓝（忍服内衬色）
d.type_27[code.EGDC_ACTIVE_CAPTION] = 0xFFFF4500 -- 炽热橙（标题栏）
d.type_27[code.EGDC_INACTIVE_BORDER] = 0xFF228B22 -- 森林绿（木叶村色）
d.type_27[code.EGDC_INACTIVE_CAPTION] = 0xFF32CD32 -- 叶绿色
d.type_27[code.EGDC_APP_WORKSPACE] = 0xFFF5DEB3 -- 卷轴米黄（背景色）

-- 文本组（高对比度）
d.type_27[code.EGDC_BUTTON_TEXT] = 0xFF000080 -- 深蓝（忍术卷轴文字）
d.type_27[code.EGDC_GRAY_TEXT] = 0xFFA0522D -- 泥褐色（禁用状态）
d.type_27[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFF00 -- 亮黄（影分身特效）
d.type_27[code.EGDC_WINDOW_SYMBOL] = 0xFF8B0000 -- 赤红（危险提示）

-- 交互元素（查克拉流动感）
d.type_27[code.EGDC_HIGH_LIGHT] = 0xFF00BFFF -- 螺旋丸蓝色
d.type_27[code.EGDC_SCROLLBAR] = 0xFFFF6347 -- 动态橙红
d.type_27[code.EGDC_EDITABLE] = 0xFFFFFFE6 -- 卷轴浅黄（输入区）
d.type_27[code.EGDC_FOCUSED_EDITABLE] = 0xFFB0E0E6 -- 风遁·轻蓝色

-- 图标组（忍者装备配色）
d.type_27[code.EGDC_ICON] = 0xFF00008B -- 深蓝（苦无柄色）
d.type_27[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF1493 -- 粉红（樱花色-小樱主题）

-- 工具提示（忍术说明风格）
d.type_27[code.EGDC_TOOLTIP] = 0xFF2F4F4F -- 暗钢蓝（忍具说明文字）
d.type_27[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFFFFACD -- 手里剑皮套黄

-- 特殊状态（九尾模式）
d.type_27[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 -- 银灰（封印术式色）
d.type_27[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF708090 -- 石灰色（仙人模式）
d.type_27[code.EGDC_WINDOW] = 0xFFFFF8DC -- 玉米丝色（鸣人头发高光）

d.type_28 = {}
-- 斩魄刀风格的3D效果
d.type_28[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A -- 虚化黑（类似死霸装阴影）
d.type_28[code.EGDC_3D_SHADOW] = 0xFF333333 -- 浅虚黑
d.type_28[code.EGDC_3D_FACE] = 0xFFF58220 -- 斩月橙（主色调）
d.type_28[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFD700 -- 卍解金（高光点缀）
d.type_28[code.EGDC_3D_LIGHT] = 0xFFFFA500 -- 普通橙

-- 虚夜宫风格的窗口元素
d.type_28[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 -- 血战红（活跃边框）
d.type_28[code.EGDC_ACTIVE_CAPTION] = 0xFF450000 -- 暗血红标题栏
d.type_28[code.EGDC_INACTIVE_BORDER] = 0xFF413839 -- 灰黑（非活动状态）
d.type_28[code.EGDC_INACTIVE_CAPTION] = 0xFF222222 -- 死霸装黑
d.type_28[code.EGDC_APP_WORKSPACE] = 0xFF000000 -- 纯黑背景

-- 灵压波动的文本色
d.type_28[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 白色（像魂的文字）
d.type_28[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9 -- 灰色（类似浅打未激活）
d.type_28[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFF4500 -- 高亮橙红

-- 月牙天冲特效色
d.type_28[code.EGDC_HIGH_LIGHT] = 0xFF0066CC -- 蓝色（类似破道特效）
d.type_28[code.EGDC_FOCUSED_EDITABLE] = 0x20FFFF00 -- 聚焦黄（灵压感应）

-- 义魂丸提示风格
d.type_28[code.EGDC_TOOLTIP] = 0xFFFFFACD -- 米白（类似魂的对话框）
d.type_28[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F -- 半透黑底

-- 瞬步残影滚动条
d.type_28[code.EGDC_SCROLLBAR] = 0x80F58220 -- 半透斩月橙

-- 断界风格的窗口
d.type_28[code.EGDC_WINDOW] = 0xFF111111 -- 深空黑
d.type_28[code.EGDC_EDITABLE] = 0xFF222222 -- 可编辑区灰黑
d.type_28[code.EGDC_GRAY_EDITABLE] = 0xFF1A1A1A -- 禁用编辑区

-- 斩魄刀图标
d.type_28[code.EGDC_ICON] = 0xFFFFA500 -- 橙色图标
d.type_28[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 -- 高亮红（虚化状态）

-- 鬼道符咒符号
d.type_28[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 -- 金色符号
d.type_28[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF555555 -- 禁用符号灰

d.type_29 = {}
-- 3D元素组（千年神器金属质感）
d.type_29[code.EGDC_3D_DARK_SHADOW] = 0xFF4B0082 -- 靛蓝（黑暗游戏空间）
d.type_29[code.EGDC_3D_SHADOW] = 0xFF8B4513 -- 铜锈色（古文物阴影）
d.type_29[code.EGDC_3D_FACE] = 0xFFDAA520 -- 黄金色（千年积木主色）
d.type_29[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFF00 -- 神光金（千年眼反光）
d.type_29[code.EGDC_3D_LIGHT] = 0xFFC0C0C0 -- 银白（金属边缘）

-- 窗口元素（石板神殿风格）
d.type_29[code.EGDC_ACTIVE_BORDER] = 0xFF000080 -- 深蓝（法老王头巾色）
d.type_29[code.EGDC_ACTIVE_CAPTION] = 0xFFB22222 -- 赤红（黑暗游戏血条）
d.type_29[code.EGDC_INACTIVE_BORDER] = 0xFF2F4F4F -- 石板灰（沉睡记忆）
d.type_29[code.EGDC_INACTIVE_CAPTION] = 0xFF696969 -- 砂石色
d.type_29[code.EGDC_APP_WORKSPACE] = 0xFFF5F5DC -- 羊皮纸色（决斗台）

-- 文本组（象形文字风格）
d.type_29[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 纯黑（魔法咒文）
d.type_29[code.EGDC_GRAY_TEXT] = 0xFF708090 -- 灰蓝（被封印文字）
d.type_29[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFF00 -- 金光（神官文字）
d.type_29[code.EGDC_WINDOW_SYMBOL] = 0xFF8B0000 -- 深红（生命值消耗）

-- 交互元素（卡牌特效）
d.type_29[code.EGDC_HIGH_LIGHT] = 0xFF00CED1 -- 青蓝（青眼白龙吐息）
d.type_29[code.EGDC_SCROLLBAR] = 0xFFDA70D6 -- 紫晶（魔法卡光效）
d.type_29[code.EGDC_EDITABLE] = 0xFFFFFFF0 -- 珍珠白（卡背底色）
d.type_29[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFA07A -- 橙红（陷阱卡触发）

-- 图标组（千年神器配色）
d.type_29[code.EGDC_ICON] = 0xFF4169E1 -- 皇家蓝（欧西里斯天空龙）
d.type_29[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF4500 -- 赤橙（巨神兵能量）

-- 工具提示（神秘卷轴）
d.type_29[code.EGDC_TOOLTIP] = 0xFF2F4F4F -- 暗石板（神官解说）
d.type_29[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFF0E68C -- 莎草黄（古埃及纸）

-- 特殊状态（黑暗游戏领域）
d.type_29[code.EGDC_GRAY_EDITABLE] = 0xFFA9A9A9 -- 铁灰（封印状态）
d.type_29[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF556B2F -- 橄榄绿（守墓一族）
d.type_29[code.EGDC_WINDOW] = 0xFF000000 -- 纯黑（暗黑决斗场）

d.type_30 = {}
-- 被封印部件纹理
d.type_30[code.EGDC_3D_DARK_SHADOW] = 0xFF1E0A3C -- 紫晶黑（左足封印色）
d.type_30[code.EGDC_3D_SHADOW] = 0xFF3A1C6B -- 暗影紫（右足纹理）
d.type_30[code.EGDC_3D_FACE] = 0xFF5E34A1 -- 咒文紫（主体色调）
d.type_30[code.EGDC_3D_HIGH_LIGHT] = 0xFF9D75D6 -- 解封高光
d.type_30[code.EGDC_3D_LIGHT] = 0xFF7B4FCF -- 邪眼紫光

-- 石板封印边框
d.type_30[code.EGDC_ACTIVE_BORDER] = 0xFF6B4D23 -- 青铜锈色
d.type_30[code.EGDC_ACTIVE_CAPTION] = 0xFFD4AF37 -- 法老金（标题栏）
d.type_30[code.EGDC_INACTIVE_BORDER] = 0xFF2A2118 -- 腐化黑石
d.type_30[code.EGDC_INACTIVE_CAPTION] = 0xFF5A4B2C -- 褪色圣书
d.type_30[code.EGDC_APP_WORKSPACE] = 0xFF0F0615 -- 深渊底色

-- 古埃及象形文字
d.type_30[code.EGDC_BUTTON_TEXT] = 0xFFE6D7A7 -- 莎草纸色
d.type_30[code.EGDC_GRAY_TEXT] = 0xFF756D54 -- 磨损文字
d.type_30[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFACD -- 神官金箔

-- 黑暗仪式特效
d.type_30[code.EGDC_HIGH_LIGHT] = 0xFF8A2BE2 -- 邪神紫光
d.type_30[code.EGDC_FOCUSED_EDITABLE] = 0x4DFF4500 -- 血祭红（聚焦时）

-- 卡牌描述栏
d.type_30[code.EGDC_TOOLTIP] = 0xFFD4C99E -- 古卷轴米黄
d.type_30[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD1D0F36 -- 半透咒文底

-- 封印链条滚动条
d.type_30[code.EGDC_SCROLLBAR] = 0x805E34A1 -- 半透封印紫

-- 墓室壁画背景
d.type_30[code.EGDC_WINDOW] = 0xFF150A28 -- 墓室黑紫
d.type_30[code.EGDC_EDITABLE] = 0xFF2D1B4E -- 咒语输入区
d.type_30[code.EGDC_GRAY_EDITABLE] = 0xFF1A102C -- 禁咒区域

-- 千年神器图标
d.type_30[code.EGDC_ICON] = 0xFFD4AF37 -- 黄金积木色
d.type_30[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFD700 -- 千年眼金光

-- 荷鲁斯之眼符号
d.type_30[code.EGDC_WINDOW_SYMBOL] = 0xFF800080 -- 法老深紫
d.type_30[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF483D8B -- 被封印符号

d.type_31 = {}
-- 阴阳两极的3D效果
d.type_31[code.EGDC_3D_DARK_SHADOW] = 0xFF2E1B3D -- 阴之紫（式神契约色）
d.type_31[code.EGDC_3D_SHADOW] = 0xFF5A3D6B -- 鬼火余烬
d.type_31[code.EGDC_3D_FACE] = 0xFFE63B2E -- 火灵红（主色调）
d.type_31[code.EGDC_3D_HIGH_LIGHT] = 0xFFFF7D00 -- 业火橙（高光）
d.type_31[code.EGDC_3D_LIGHT] = 0xFFF05454 -- 血焰色

-- 阴阳寮风格的窗口元素
d.type_31[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 -- 封魔朱印色
d.type_31[code.EGDC_ACTIVE_CAPTION] = 0xFFD72323 -- 赤符标题栏
d.type_31[code.EGDC_INACTIVE_BORDER] = 0xFF3D2B56 -- 结界紫
d.type_31[code.EGDC_INACTIVE_CAPTION] = 0xFF4A3C6B -- 褪色符咒
d.type_31[code.EGDC_APP_WORKSPACE] = 0xFF0F0520 -- 星宿图底色

-- 灵视文字色
d.type_31[code.EGDC_BUTTON_TEXT] = 0xFFF8EDD2 -- 卷轴米白（阴阳寮文书）
d.type_31[code.EGDC_GRAY_TEXT] = 0xFF957D6B -- 古旧墨迹
d.type_31[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFD700 -- 式神召唤金

-- 超·占事略决特效
d.type_31[code.EGDC_HIGH_LIGHT] = 0xFF4B0082 -- 占卜紫（灵视高光）
d.type_31[code.EGDC_FOCUSED_EDITABLE] = 0x60FF0000 -- 血祭输入框（聚焦时）

-- 式神提示框
d.type_31[code.EGDC_TOOLTIP] = 0xFFE6D7A7 -- 式神名签色
d.type_31[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2A1638 -- 半透鬼门阵

-- 灵体流动滚动条
d.type_31[code.EGDC_SCROLLBAR] = 0x80E63B2E -- 半透火灵红

-- 阴间风格的窗口
d.type_31[code.EGDC_WINDOW] = 0xFF1A0A2A -- 黄泉黑紫
d.type_31[code.EGDC_EDITABLE] = 0xFF2E1B3D -- 符咒书写区
d.type_31[code.EGDC_GRAY_EDITABLE] = 0xFF1A102C -- 禁术区域

-- 式神图标
d.type_31[code.EGDC_ICON] = 0xFFFF7D00 -- 业火橙图标
d.type_31[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 -- 鬼眼赤红

-- 阴阳道符号
d.type_31[code.EGDC_WINDOW_SYMBOL] = 0xFF9B30FF -- 灵视紫
d.type_31[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF5D4D7B -- 封印符号

d.type_32 = {}
-- 念珠结界效果
d.type_32[code.EGDC_3D_DARK_SHADOW] = 0xFF3A0C37 -- 鬼门紫（最强巫女服底色）
d.type_32[code.EGDC_3D_SHADOW] = 0xFF5A1D4D -- 怨灵缠绕色
d.type_32[code.EGDC_3D_FACE] = 0xFFD10058 -- 血樱红（主色调）
d.type_32[code.EGDC_3D_HIGH_LIGHT] = 0xFFFF6B9F -- 灵击粉光
d.type_32[code.EGDC_3D_LIGHT] = 0xFFF54278 -- 破魔朱色

-- 神社鸟居边框
d.type_32[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 -- 赤鸟居色
d.type_32[code.EGDC_ACTIVE_CAPTION] = 0xFFD72323 -- 灵视红（标题栏）
d.type_32[code.EGDC_INACTIVE_BORDER] = 0xFF4B2C5E -- 封魔柱紫
d.type_32[code.EGDC_INACTIVE_CAPTION] = 0xFF5A3C6B -- 褪色符纸
d.type_32[code.EGDC_APP_WORKSPACE] = 0xFF1A0A20 -- 恐山夜雾

-- 式神契约文字
d.type_32[code.EGDC_BUTTON_TEXT] = 0xFFF8EDD2 -- 念珠米白
d.type_32[code.EGDC_GRAY_TEXT] = 0xFFA89B8C -- 古旧卷轴
d.type_32[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFE4E1 -- 灵视白（警告色）

-- 鬼道术式特效
d.type_32[code.EGDC_HIGH_LIGHT] = 0xFF9B30FF -- 巫女紫（灵击闪光）
d.type_32[code.EGDC_FOCUSED_EDITABLE] = 0x60FF0037 -- 血祭输入框（聚焦时）

-- 式神札提示
d.type_32[code.EGDC_TOOLTIP] = 0xFFE6D7A7 -- 御札米黄
d.type_32[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD3A0C37 -- 半透鬼门结界

-- 念珠滚动条
d.type_32[code.EGDC_SCROLLBAR] = 0x80D10058 -- 半透血樱色

-- 神社本殿窗口
d.type_32[code.EGDC_WINDOW] = 0xFF2A0A2A -- 神隐黑紫
d.type_32[code.EGDC_EDITABLE] = 0xFF3D1B3D -- 符咒书写区
d.type_32[code.EGDC_GRAY_EDITABLE] = 0xFF2A162A -- 禁术区域

-- 108颗念珠图标
d.type_32[code.EGDC_ICON] = 0xFFFF6B9F -- 灵击粉
d.type_32[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 -- 退魔赤

-- 五芒星符号
d.type_32[code.EGDC_WINDOW_SYMBOL] = 0xFFD72323 -- 朱印色
d.type_32[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF5A3C6B -- 封印符号

d.type_33 = {}
-- 3D元素组（武士刀与灵魂之火质感）
d.type_33[code.EGDC_3D_DARK_SHADOW] = 0xFF2E8B57 -- 海藻绿（叶的耳机色）
d.type_33[code.EGDC_3D_SHADOW] = 0xFF8FBC8F -- 苔藓绿（修行道场阴影）
d.type_33[code.EGDC_3D_FACE] = 0xFF98FB98 -- 叶绿色（经典卫衣主色）
d.type_33[code.EGDC_3D_HIGH_LIGHT] = 0xFF7FFFD4 -- 精灵蓝（水之精灵光）
d.type_33[code.EGDC_3D_LIGHT] = 0xFFF0E68C -- 佛珠金（念珠高光）

-- 窗口元素（神社风格）
d.type_33[code.EGDC_ACTIVE_BORDER] = 0xFF800000 -- 赤红（鸟居主色）
d.type_33[code.EGDC_ACTIVE_CAPTION] = 0xFFFF6347 -- 橙红（火灵底色）
d.type_33[code.EGDC_INACTIVE_BORDER] = 0xFFD2B48C -- 檀木色（神社廊柱）
d.type_33[code.EGDC_INACTIVE_CAPTION] = 0xFFBC8F8F -- 枯玫瑰（退魔绳色）
d.type_33[code.EGDC_APP_WORKSPACE] = 0xFFFAF0E6 -- 麻布色（修行服质感）

-- 文本组（符咒文字风格）
d.type_33[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 墨黑（符咒文字）
d.type_33[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9 -- 灰（被封印的灵）
d.type_33[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFF00 -- 金光（超灵体状态）
d.type_33[code.EGDC_WINDOW_SYMBOL] = 0xFF8B008B -- 紫（巫力数值）

-- 交互元素（灵体特效）
d.type_33[code.EGDC_HIGH_LIGHT] = 0xFF40E0D0 -- 青绿（灵魂之火）
d.type_33[code.EGDC_SCROLLBAR] = 0xFFFFA500 -- 橙（火灵尾巴）
d.type_33[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 白（灵视界面）
d.type_33[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFE4B5 -- 米黄（通灵启示）

-- 图标组（通灵道具配色）
d.type_33[code.EGDC_ICON] = 0xFF4B0082 -- 靛蓝（阿弥陀丸刀鞘）
d.type_33[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 -- 赤红（火灵核心）

-- 工具提示（式神说明）
d.type_33[code.EGDC_TOOLTIP] = 0xFF556B2F -- 暗绿（精灵低语）
d.type_33[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFF5DEB3 -- 梵钟黄（佛前灯）

-- 特殊状态（超灵体模式）
d.type_33[code.EGDC_GRAY_EDITABLE] = 0xFFC0C0C0 -- 银灰（武士铠甲）
d.type_33[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF708090 -- 霭色（雨之精灵）
d.type_33[code.EGDC_WINDOW] = 0xFF000000 -- 纯黑（暗黑通灵界）

d.type_34 = {}
d.type_34[code.EGDC_3D_DARK_SHADOW] = 0xFFD8D8D8
d.type_34[code.EGDC_3D_SHADOW] = 0xFFE0E0E0
d.type_34[code.EGDC_3D_FACE] = 0xFFFFC080
d.type_34[code.EGDC_3D_HIGH_LIGHT] = 0xFFF0E0EF
d.type_34[code.EGDC_3D_LIGHT] = 0xFFFFE0A0
d.type_34[code.EGDC_APP_WORKSPACE] = 0xFFF0F0F0
d.type_34[code.EGDC_BUTTON_TEXT] = 0xFF333333 -- 深色文字在浅色背景
d.type_34[code.EGDC_GRAY_TEXT] = 0xFF808080
d.type_34[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000 -- 黑色高亮文本
d.type_34[code.EGDC_HIGH_LIGHT] = 0xaaFFB366
d.type_34[code.EGDC_ACTIVE_BORDER] = 0xFFFF8080 -- 浅红色边框
d.type_34[code.EGDC_ACTIVE_CAPTION] = d.type_34[code.EGDC_HIGH_LIGHT_TEXT]
d.type_34[code.EGDC_INACTIVE_BORDER] = 0xFFE0D8D8
d.type_34[code.EGDC_INACTIVE_CAPTION] = 0xFFDDDDDD
d.type_34[code.EGDC_TOOLTIP] = 0xFF333333 -- 深色提示文字
d.type_34[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFFFFF -- 白色半透明背景
d.type_34[code.EGDC_SCROLLBAR] = 0x80FFC080
d.type_34[code.EGDC_EDITABLE] = d.type_34[code.EGDC_3D_HIGH_LIGHT]
d.type_34[code.EGDC_GRAY_EDITABLE] = 0xFFC0C0C0
d.type_34[code.EGDC_FOCUSED_EDITABLE] = d.type_34[code.EGDC_HIGH_LIGHT]
d.type_34[code.EGDC_ICON] = 0xFFFFC000 -- 浅橙色图标
d.type_34[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6060 -- 浅红色高亮
d.type_34[code.EGDC_WINDOW_SYMBOL] = 0xFFFFE880 -- 浅金色
d.type_34[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF333333 -- 深灰色
d.type_34[code.EGDC_WINDOW] = 0xFFF8F8F8
--~ cc.rs :type_1 'my'

d.type_35 = {}

-- 3D元素阴影（保持原有透明度FF，饱和度降低，明度提高）
d.type_35[code.EGDC_3D_DARK_SHADOW] = 0xFFD6D6D6 -- 原1A→D6 (保持20%暗度)
d.type_35[code.EGDC_3D_SHADOW] = 0xFFE6E6E6 -- 原33→E6 (保持30%暗度)

-- 主色调转换（保持FF不透明度和饱和度）
d.type_35[code.EGDC_3D_FACE] = 0xFFFFC28A -- F58220→FFC28A (橙色明度+40%)
d.type_35[code.EGDC_3D_HIGH_LIGHT] = 0xFFE8D0E7 -- 3A0C37→E8D0E7 (紫色明度+75%)
d.type_35[code.EGDC_3D_LIGHT] = 0xFFFFD699 -- FFA500→FFD699 (橙色明度+20%)

-- 工作区（保持FF不透明度）
d.type_35[code.EGDC_APP_WORKSPACE] = 0xFFF8F8F8 -- FFFFFF→F8F8F8 (轻微灰化)

-- 文本颜色（反转对比度）
d.type_35[code.EGDC_BUTTON_TEXT] = 0xFF404040 -- FFFFFF→404040 (保持相同对比度)
d.type_35[code.EGDC_GRAY_TEXT] = 0xFF909090 -- A9A9A9→909090 (明度同步调整)

-- 高亮元素（严格保持F0/aa透明度）
d.type_35[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0000000 -- F0FFFFFF→F0000000 (反色)
d.type_35[code.EGDC_HIGH_LIGHT] = 0xaaFFB366 -- aaFF6600→aaFFB366 (明度+30%)

-- 边框与标题（保持原透明度）
d.type_35[code.EGDC_ACTIVE_BORDER] = 0xFFFF6666 -- 8B0000→FF6666 (红调明度+50%)
d.type_35[code.EGDC_ACTIVE_CAPTION] = d.type_35[code.EGDC_HIGH_LIGHT_TEXT]
d.type_35[code.EGDC_INACTIVE_BORDER] = 0xFFD4CCCD -- 413839→D4CCCD
d.type_35[code.EGDC_INACTIVE_CAPTION] = 0xFFDDDDDD -- 222222→DDDDDD

-- 工具提示（保持DD/F0透明度）
d.type_35[code.EGDC_TOOLTIP] = 0xFFFFF3A0 -- FFFACD→FFF3A0 (暖黄调加深)
d.type_35[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFFFFF -- 2F2F2F→FFFFFF (反色)

-- 滚动条（保持80透明度）
d.type_35[code.EGDC_SCROLLBAR] = 0x80FFC28A -- 80F58220→80FFC28A

-- 编辑框状态（保持层次关系）
d.type_35[code.EGDC_EDITABLE] = d.type_35[code.EGDC_3D_HIGH_LIGHT]
d.type_35[code.EGDC_GRAY_EDITABLE] = 0xFFECECEC -- D3D3D3→ECECEC (明度+15%)
d.type_35[code.EGDC_FOCUSED_EDITABLE] = d.type_35[code.EGDC_HIGH_LIGHT]

-- 图标系统（保持鲜艳度）
d.type_35[code.EGDC_ICON] = 0xFFFFD699 -- FFA500→FFD699
d.type_35[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6B6B -- FF0000→FF6B6B (红调明度+40%)

-- 窗口元素
d.type_35[code.EGDC_WINDOW_SYMBOL] = 0xFFFFEB99 -- FFD700→FFEB99 (金色明度+20%)
d.type_35[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFC0C0C0 -- FFFFFF→C0C0C0 (增加可视性)
d.type_35[code.EGDC_WINDOW] = 0xFFF0F0F0 -- FFFFFF→F0F0F0 (减少眩光)

d.type_36 = {}

-- 3D元素阴影（柔和的粉灰调）
d.type_36[code.EGDC_3D_DARK_SHADOW] = 0xFFFFD6E6 -- 粉白阴影（原1A→FFD6E6）
d.type_36[code.EGDC_3D_SHADOW] = 0xFFFFE6F0 -- 樱花粉投影（原33→FFE6F0）

-- 主色调（甜蜜马卡龙色系）
d.type_36[code.EGDC_3D_FACE] = 0xFFFFB6C1 -- 粉橙色（原F58220→FFB6C1）
d.type_36[code.EGDC_3D_HIGH_LIGHT] = 0xFFE6CFEF -- 薰衣草紫（原3A0C37→E6CFEF）
d.type_36[code.EGDC_3D_LIGHT] = 0xFFFFD1DC -- 奶油粉（原FFA500→FFD1DC）

-- 工作区（柔光白）
d.type_36[code.EGDC_APP_WORKSPACE] = 0xFFFFF9FA -- 带粉调的珍珠白

-- 文本颜色（甜系深色）
d.type_36[code.EGDC_BUTTON_TEXT] = 0xFF8A4F7B -- 玫瑰豆沙色文字
d.type_36[code.EGDC_GRAY_TEXT] = 0xFFC7A8BA -- 灰粉副文本

-- 高亮元素（保持透明度的甜蜜强调）
d.type_36[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FF4F94 -- 桃红色高亮文字
d.type_36[code.EGDC_HIGH_LIGHT] = 0xaaFF9BB9 -- 樱花粉高亮背景

-- 边框与标题（柔和边框）
d.type_36[code.EGDC_ACTIVE_BORDER] = 0xFFFF809D -- 草莓红边框
d.type_36[code.EGDC_ACTIVE_CAPTION] = 0xFFE83A6C -- 玫红标题文字
d.type_36[code.EGDC_INACTIVE_BORDER] = 0xFFFFD6E0
d.type_36[code.EGDC_INACTIVE_CAPTION] = 0xFFF0B6C6

-- 工具提示（糖果系提示）
d.type_36[code.EGDC_TOOLTIP] = 0xFFFFF0F5 -- 淡粉提示背景
d.type_36[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFF8BB3 -- 半透明粉紫

-- 滚动条（花瓣质感）
d.type_36[code.EGDC_SCROLLBAR] = 0x80FFB6C1 -- 半透明粉橙

-- 编辑框状态（渐变粉）
d.type_36[code.EGDC_EDITABLE] = 0xFFF8E0E8 -- 粉白编辑框
d.type_36[code.EGDC_GRAY_EDITABLE] = 0xFFF0D6DF -- 灰粉禁用状态
d.type_36[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFE6F0 -- 聚焦粉

-- 图标系统（糖果色）
d.type_36[code.EGDC_ICON] = 0xFFFF9BB9 -- 樱花粉图标
d.type_36[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF4F94 -- 桃红高亮

-- 窗口元素（奶油质感）
d.type_36[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD1E0 -- 粉金按钮
d.type_36[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFF8E0E8
d.type_36[code.EGDC_WINDOW] = 0xFFFFF0F5 -- 淡粉背景

d.type_37 = {}
d.type_37[code.EGDC_3D_DARK_SHADOW] = 0xFFE0E0E0 -- 柔和的浅灰阴影
d.type_37[code.EGDC_3D_SHADOW] = 0xFFF0F0F0 -- 更浅的阴影
d.type_37[code.EGDC_3D_FACE] = 0xFFB5E2FA -- 宁静的浅蓝色按钮背景(原橙色对应)
d.type_37[code.EGDC_3D_HIGH_LIGHT] = 0xFFE6F9FF -- 极浅蓝下拉框背景(原深紫对应)
d.type_37[code.EGDC_3D_LIGHT] = 0xFF87CEEB -- 中等浅蓝(原橙色对应)
d.type_37[code.EGDC_APP_WORKSPACE] = 0xFFF8F8F8 -- 极浅灰工作区
d.type_37[code.EGDC_BUTTON_TEXT] = 0xFF333333 -- 深灰按钮文字
d.type_37[code.EGDC_GRAY_TEXT] = 0xFFA0A0A0 -- 中灰禁用文字
d.type_37[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF00688B -- 深蓝高亮文字(保持对比度)
d.type_37[code.EGDC_HIGH_LIGHT] = 0xAAADD8E6 -- 半透明浅蓝高亮背景(原橙色对应)
d.type_37[code.EGDC_ACTIVE_BORDER] = 0xFFB0E0E6 -- 柔和蓝绿色边框(原暗红对应)
d.type_37[code.EGDC_ACTIVE_CAPTION] = d.type_37[code.EGDC_HIGH_LIGHT_TEXT] -- 使用高亮文字色
d.type_37[code.EGDC_INACTIVE_BORDER] = 0xFFD4D4D4 -- 浅灰非活动边框
d.type_37[code.EGDC_INACTIVE_CAPTION] = 0xFFC0C0C0 -- 浅灰非活动标题
d.type_37[code.EGDC_TOOLTIP] = 0xFF505050 -- 深灰工具提示文字
d.type_37[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFFFFF -- 半透明白色背景
d.type_37[code.EGDC_SCROLLBAR] = 0x80B5E2FA -- 半透明浅蓝滚动条(原橙色对应)
d.type_37[code.EGDC_EDITABLE] = d.type_37[code.EGDC_3D_HIGH_LIGHT] -- 极浅蓝编辑框
d.type_37[code.EGDC_GRAY_EDITABLE] = 0xFFE8E8E8 -- 浅灰禁用编辑框
d.type_37[code.EGDC_FOCUSED_EDITABLE] = d.type_37[code.EGDC_HIGH_LIGHT] -- 浅蓝激活编辑框
d.type_37[code.EGDC_ICON] = 0xFF5F9EA0 -- 宁静的蓝绿色图标
d.type_37[code.EGDC_ICON_HIGH_LIGHT] = 0xFF4682B4 -- 更饱和的蓝色高亮
d.type_37[code.EGDC_WINDOW_SYMBOL] = 0xFF20B2AA -- 明快的浅海绿色
d.type_37[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0A0A0 -- 中灰窗口符号
d.type_37[code.EGDC_WINDOW] = 0xFFF5F5F5 -- 极浅灰窗口背景

d.type_38 = {}
d.type_38[code.EGDC_3D_DARK_SHADOW] = 0xFFC8E0EA -- 浅水蓝色暗阴影
d.type_38[code.EGDC_3D_SHADOW] = 0xFFE0F0F5 -- 更浅的水蓝色阴影
d.type_38[code.EGDC_3D_FACE] = 0xFFF0F9FC -- 接近白色的极浅蓝（按钮/窗口背景）
d.type_38[code.EGDC_3D_HIGH_LIGHT] = 0xFFD4EDF8 -- 下拉框背景（柔和的天蓝色）
d.type_38[code.EGDC_3D_LIGHT] = 0xFF7EC8E6 -- 水波般的中等蓝色
d.type_38[code.EGDC_APP_WORKSPACE] = 0xFFF5FDFF -- 极浅的湖水色
d.type_38[code.EGDC_BUTTON_TEXT] = 0xFF2F4F6B -- 深海军蓝文字
d.type_38[code.EGDC_GRAY_TEXT] = 0xFF8CA7B8 -- 灰蓝色文字
d.type_38[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF00688B -- 深水蓝色高亮文本
d.type_38[code.EGDC_HIGH_LIGHT] = 0xAAAFDCEC -- 半透明水蓝色高亮背景
d.type_38[code.EGDC_ACTIVE_BORDER] = 0xFF5F9EA0 -- 绿松石色活动边框
d.type_38[code.EGDC_ACTIVE_CAPTION] = d.type_38[code.EGDC_HIGH_LIGHT_TEXT] -- 深水蓝色标题文本
d.type_38[code.EGDC_INACTIVE_BORDER] = 0xFFB0E0E6 -- 浅绿松石非活动边框
d.type_38[code.EGDC_INACTIVE_CAPTION] = 0xFF87CEEB -- 天空蓝非活动标题
d.type_38[code.EGDC_TOOLTIP] = 0xFF2F4F6B -- 深海军蓝工具提示文本
d.type_38[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDF0F9FF -- 半透明浅蓝工具提示背景
d.type_38[code.EGDC_SCROLLBAR] = 0x807EC8E6 -- 半透明水蓝色滚动条
d.type_38[code.EGDC_EDITABLE] = d.type_38[code.EGDC_3D_HIGH_LIGHT] -- 天蓝色编辑框
d.type_38[code.EGDC_GRAY_EDITABLE] = 0xFFE0EBEE -- 灰蓝色禁用编辑框
d.type_38[code.EGDC_FOCUSED_EDITABLE] = 0xFFB9E3F2 -- 更亮的水蓝色聚焦编辑框
d.type_38[code.EGDC_ICON] = 0xFF5F9EA0 -- 绿松石色图标
d.type_38[code.EGDC_ICON_HIGH_LIGHT] = 0xFF00BFFF -- 深天蓝高亮图标
d.type_38[code.EGDC_WINDOW_SYMBOL] = 0xFF1E90FF -- 道奇蓝窗口符号
d.type_38[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB0C4DE -- 浅钢蓝灰色符号
d.type_38[code.EGDC_WINDOW] = 0xFFF5FDFF -- 极浅湖水色窗口背景

d.type_39 = {}
-- 3D 控件阴影系统（改为浅色投影）
d.type_39[code.EGDC_3D_DARK_SHADOW] = 0xFFE0E0E0 -- 浅灰暗阴影（原1A1A1A的浅色反转）
d.type_39[code.EGDC_3D_SHADOW] = 0xFFEEEEEE -- 接近白色的浅阴影（原333333反转）
d.type_39[code.EGDC_3D_FACE] = 0xFFFFFFFF -- 纯白背景（原F58220的极高亮度转换）
d.type_39[code.EGDC_3D_HIGH_LIGHT] = 0xFFF5F5F5 -- 极浅灰下拉背景（原3A0C37的亮度反转）
d.type_39[code.EGDC_3D_LIGHT] = 0xFFCCCCCC -- 中灰色高光（原FFA500的灰度化）

-- 基础界面区域
d.type_39[code.EGDC_APP_WORKSPACE] = 0xFFFAFAFA -- 极浅灰工作区（保持与原白色相近的层次）
d.type_39[code.EGDC_WINDOW] = 0xFFFFFFFF -- 纯白窗口背景

-- 文字系统（保持原始对比关系）
d.type_39[code.EGDC_BUTTON_TEXT] = 0xFF222222 -- 深灰按钮文字（原白→黑的反转）
d.type_39[code.EGDC_GRAY_TEXT] = 0xFF909090 -- 中灰禁用文字（原A9A9A9保持）
d.type_39[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000 -- 纯黑高亮文字（原F0FFFFFF反转）
d.type_39[code.EGDC_ACTIVE_CAPTION] = 0xFF000000 -- 纯黑标题文字

-- 高亮与交互元素（保持原始透明度）
d.type_39[code.EGDC_HIGH_LIGHT] = 0x55AAAAAA -- 半透明灰高亮（原aaFF6600的灰度化）
d.type_39[code.EGDC_ACTIVE_BORDER] = 0xFF707070 -- 深灰活动边框（原8B0000的灰度化）
d.type_39[code.EGDC_INACTIVE_BORDER] = 0xFFD0D0D0 -- 浅灰非活动边框
d.type_39[code.EGDC_INACTIVE_CAPTION] = 0xFF808080 -- 中灰非活动标题

-- 辅助功能元素
d.type_39[code.EGDC_TOOLTIP] = 0xFF404040 -- 深灰工具提示文字（原FFFACD反转）
d.type_39[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFFFFF -- 半透明白提示背景（原DD2F2F2F反转）
d.type_39[code.EGDC_SCROLLBAR] = 0x80C0C0C0 -- 半透明灰滚动条（原80F58220的灰度化）

-- 输入控件（保持层次关系）
d.type_39[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑框
d.type_39[code.EGDC_GRAY_EDITABLE] = 0xFFEAEAEA -- 浅灰禁用编辑框
d.type_39[code.EGDC_FOCUSED_EDITABLE] = 0xFFF0F0F0 -- 聚焦状态极浅灰

-- 图标系统（极简单色方案）
d.type_39[code.EGDC_ICON] = 0xFF606060 -- 中灰图标（原FFA500的灰度化）
d.type_39[code.EGDC_ICON_HIGH_LIGHT] = 0xFF000000 -- 纯黑高亮图标
d.type_39[code.EGDC_WINDOW_SYMBOL] = 0xFF404040 -- 深灰窗口符号
d.type_39[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0A0A0 -- 浅灰禁用符号

d.type_40 = {}
d.type_40[code.EGDC_3D_DARK_SHADOW] = 0xFFA8C0D0 -- 浅蓝色暗阴影，如秋水深处
d.type_40[code.EGDC_3D_SHADOW] = 0xFFC0D8E8 -- 浅蓝色右下阴影，如水波反光
d.type_40[code.EGDC_3D_FACE] = 0xFF60C0F0 -- 主色调：明亮的秋水蓝
d.type_40[code.EGDC_3D_HIGH_LIGHT] = 0xFFE0F7FF -- 极浅蓝，如天空倒影
d.type_40[code.EGDC_3D_LIGHT] = 0xFF80E0FF -- 亮蓝色高光，如水波亮点
d.type_40[code.EGDC_APP_WORKSPACE] = 0xFFF8FCFF -- 极浅蓝白背景
d.type_40[code.EGDC_BUTTON_TEXT] = 0xFF003366 -- 深蓝文本，保持对比度
d.type_40[code.EGDC_GRAY_TEXT] = 0xFF90A8B8 -- 灰蓝色禁用文本
d.type_40[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF003366 -- 深蓝高亮文本
d.type_40[code.EGDC_HIGH_LIGHT] = 0xAA80D0FF -- 半透明浅蓝高亮背景
d.type_40[code.EGDC_ACTIVE_BORDER] = 0xFF0088CC -- 活跃边框使用较深蓝色
d.type_40[code.EGDC_ACTIVE_CAPTION] = d.type_40[code.EGDC_HIGH_LIGHT_TEXT]
d.type_40[code.EGDC_INACTIVE_BORDER] = 0xFFB0D0E0 -- 非活跃边框使用浅蓝灰
d.type_40[code.EGDC_INACTIVE_CAPTION] = 0xFFA0B8C8 -- 非活跃标题
d.type_40[code.EGDC_TOOLTIP] = 0xFF334455 -- 深蓝灰工具提示文本
d.type_40[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDF0F8FF -- 半透明浅蓝背景
d.type_40[code.EGDC_SCROLLBAR] = 0x8060C0F0 -- 主色调半透明滚动条
d.type_40[code.EGDC_EDITABLE] = 0xFFE0F0FF -- 编辑框使用极浅蓝
d.type_40[code.EGDC_GRAY_EDITABLE] = 0xFFE0E8F0 -- 禁用状态编辑框
d.type_40[code.EGDC_FOCUSED_EDITABLE] = 0xFFC0E8FF -- 聚焦编辑框稍深
d.type_40[code.EGDC_ICON] = 0xFF00A0E0 -- 图标使用中等蓝色
d.type_40[code.EGDC_ICON_HIGH_LIGHT] = 0xFF00C0FF -- 高亮图标更亮
d.type_40[code.EGDC_WINDOW_SYMBOL] = 0xFF0088CC -- 窗口符号使用深蓝
d.type_40[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0C0D0 -- 灰色窗口符号
d.type_40[code.EGDC_WINDOW] = 0xFFF0F8FF -- 窗口背景使用极浅蓝白

d.type_41 = {}
d.type_41[code.EGDC_3D_DARK_SHADOW] = 0xFFD4AF37 -- 金属暗影，如古铜色阴影
d.type_41[code.EGDC_3D_SHADOW] = 0xFFE6C229 -- 金色右下阴影，如阳光斜照
d.type_41[code.EGDC_3D_FACE] = 0xFFFFD700 -- 主色调：经典金色
d.type_41[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFF0A0 -- 浅金色高光，如阳光反射
d.type_41[code.EGDC_3D_LIGHT] = 0xFFFFFF80 -- 亮金色高光点
d.type_41[code.EGDC_APP_WORKSPACE] = 0xFFFFFBE6 -- 米白色背景，如丝绸底色
d.type_41[code.EGDC_BUTTON_TEXT] = 0xFF8B6508 -- 深棕色文本，保持对比度
d.type_41[code.EGDC_GRAY_TEXT] = 0xFFC0A86D -- 灰金色禁用文本
d.type_41[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF5D4A00 -- 深棕高亮文本
d.type_41[code.EGDC_HIGH_LIGHT] = 0xAAFFD700 -- 半透明金色高亮背景
d.type_41[code.EGDC_ACTIVE_BORDER] = 0xFFCD950C -- 活跃边框使用较深金色
d.type_41[code.EGDC_ACTIVE_CAPTION] = d.type_41[code.EGDC_HIGH_LIGHT_TEXT]
d.type_41[code.EGDC_INACTIVE_BORDER] = 0xFFE8C897 -- 非活跃边框使用浅金色
d.type_41[code.EGDC_INACTIVE_CAPTION] = 0xFFD1B280 -- 非活跃标题
d.type_41[code.EGDC_TOOLTIP] = 0xFF5D4A00 -- 深棕工具提示文本
d.type_41[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFEE99 -- 半透明浅金背景
d.type_41[code.EGDC_SCROLLBAR] = 0x80FFD700 -- 主色调半透明滚动条
d.type_41[code.EGDC_EDITABLE] = 0xFFFFF4C0 -- 编辑框使用浅米金
d.type_41[code.EGDC_GRAY_EDITABLE] = 0xFFF0E5C0 -- 禁用状态编辑框
d.type_41[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFE880 -- 聚焦编辑框更亮
d.type_41[code.EGDC_ICON] = 0xFFFFC000 -- 图标使用温暖金色
d.type_41[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF8000 -- 高亮图标更鲜艳
d.type_41[code.EGDC_WINDOW_SYMBOL] = 0xFFCD950C -- 窗口符号使用古铜金
d.type_41[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFE8D9A5 -- 灰色窗口符号
d.type_41[code.EGDC_WINDOW] = 0xFFFFFAF0 -- 窗口背景使用珍珠白

d.type_42 = {}
d.type_42[code.EGDC_3D_DARK_SHADOW] = 0xFFA0A0A0 -- 浅色主题的暗阴影(保持透明度)
d.type_42[code.EGDC_3D_SHADOW] = 0xFFC0C0C0 -- 浅色主题的右下阴影
d.type_42[code.EGDC_3D_FACE] = 0xFFF0F0F0 -- 主背景色，类似暴风雨前的苍白天空
d.type_42[code.EGDC_3D_HIGH_LIGHT] = 0xFFE6F2FF -- 下拉框背景，冷色调
d.type_42[code.EGDC_3D_LIGHT] = 0xFF4682B4 -- 钢蓝色，象征即将到来的暴风雨
d.type_42[code.EGDC_APP_WORKSPACE] = 0xFFE6E6FA -- 淡紫色工作区，增加层次感

-- 文本与交互元素
d.type_42[code.EGDC_BUTTON_TEXT] = 0xFF333333 -- 深色文本保持可读性
d.type_42[code.EGDC_GRAY_TEXT] = 0xFF808080 -- 灰色文本
d.type_42[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000080 -- 深蓝色高亮文本
d.type_42[code.EGDC_HIGH_LIGHT] = 0xAAFFD700 -- 金色高亮背景，象征暴风雨前的最后阳光(保持透明度)

-- 边框与标题
d.type_42[code.EGDC_ACTIVE_BORDER] = 0xFF4169E1 -- 活跃边框使用皇家蓝
d.type_42[code.EGDC_ACTIVE_CAPTION] = 0xFF000000 -- 纯黑标题文本增强对比度
d.type_42[code.EGDC_INACTIVE_BORDER] = 0xFFB0C4DE -- 浅钢蓝非活跃边框
d.type_42[code.EGDC_INACTIVE_CAPTION] = 0xFF708090 -- 石板灰非活跃标题

-- 工具提示
d.type_42[code.EGDC_TOOLTIP] = 0xFF2F4F4F -- 深石板灰工具提示文本
d.type_42[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDF5F5F5 -- 接近白色的工具提示背景(保持透明度)

-- 编辑框
d.type_42[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑框
d.type_42[code.EGDC_GRAY_EDITABLE] = 0xFFDCDCDC -- 浅灰禁用状态
d.type_42[code.EGDC_FOCUSED_EDITABLE] = 0xFFE6F2FF -- 聚焦时变为淡蓝色

-- 图标与符号
d.type_42[code.EGDC_ICON] = 0xFF4682B4 -- 钢蓝色图标
d.type_42[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF8C00 -- 深橙色高亮图标，象征预警
d.type_42[code.EGDC_WINDOW_SYMBOL] = 0xFF000080 -- 深蓝色窗口符号
d.type_42[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA9A9A9 -- 灰色窗口符号

-- 窗口背景
d.type_42[code.EGDC_WINDOW] = 0xFFF8F8FF -- 幽灵白窗口背景
d.type_42[code.EGDC_SCROLLBAR] = 0x804682B4 -- 半透明钢蓝滚动条(保持透明度)

d.type_43 = {}
d.type_43[code.EGDC_3D_DARK_SHADOW] = 0xFFE0B0B0 -- 浅玫瑰色的暗阴影(保持透明度)
d.type_43[code.EGDC_3D_SHADOW] = 0xFFF0C0C0 -- 浅粉色的右下阴影
d.type_43[code.EGDC_3D_FACE] = 0xFFFFF0F5 -- 淡粉红主背景(类似害羞时的脸颊)
d.type_43[code.EGDC_3D_HIGH_LIGHT] = 0xFFF5E6FF -- 极淡的薰衣草色下拉框背景
d.type_43[code.EGDC_3D_LIGHT] = 0xFFFFB6C1 -- 浅粉色高光(少女害羞时的红晕)
d.type_43[code.EGDC_APP_WORKSPACE] = 0xFFFFFAFA -- 雪白工作区

-- 文本与交互元素
d.type_43[code.EGDC_BUTTON_TEXT] = 0xFF8B008B -- 深洋红色按钮文本
d.type_43[code.EGDC_GRAY_TEXT] = 0xFFC0A0B0 -- 灰粉色文本
d.type_43[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF800080 -- 深紫色高亮文本
d.type_43[code.EGDC_HIGH_LIGHT] = 0xAAFF69B4 -- 半透明热粉色高亮背景(保持透明度)

-- 边框与标题
d.type_43[code.EGDC_ACTIVE_BORDER] = 0xFFDA70D6 -- 兰花粉活跃边框
d.type_43[code.EGDC_ACTIVE_CAPTION] = 0xFFC71585 -- 中紫红色标题文本
d.type_43[code.EGDC_INACTIVE_BORDER] = 0xFFE6E6FA -- 淡紫非活跃边框
d.type_43[code.EGDC_INACTIVE_CAPTION] = 0xFFD8BFD8 -- 蓟色非活跃标题

-- 工具提示
d.type_43[code.EGDC_TOOLTIP] = 0xFF9370DB -- 中紫色工具提示文本
d.type_43[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFF0F5 -- 半透明淡粉红工具提示背景(保持透明度)

-- 编辑框
d.type_43[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑框
d.type_43[code.EGDC_GRAY_EDITABLE] = 0xFFF5E6FF -- 极淡薰衣草禁用状态
d.type_43[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFF0FF -- 聚焦时变为极淡粉色

-- 图标与符号
d.type_43[code.EGDC_ICON] = 0xFFFF69B4 -- 热粉色图标
d.type_43[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF1493 -- 深粉色高亮图标
d.type_43[code.EGDC_WINDOW_SYMBOL] = 0xFFBA55D3 -- 中紫色窗口符号
d.type_43[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFDDA0DD -- 浅紫色窗口符号

-- 窗口背景
d.type_43[code.EGDC_WINDOW] = 0xFFFFFAFA -- 雪白窗口背景
d.type_43[code.EGDC_SCROLLBAR] = 0x80FFB6C1 -- 半透明浅粉色滚动条(保持透明度)

d.type_44 = {}
d.type_44[code.EGDC_3D_DARK_SHADOW] = 0xFFE6B89C -- 夕阳的暗部色调
d.type_44[code.EGDC_3D_SHADOW] = 0xFFF4D8C9 -- 夕阳的中等阴影
d.type_44[code.EGDC_3D_FACE] = 0xFFFFA07A -- 主色调：夕阳橙 (保持饱和度)
d.type_44[code.EGDC_3D_HIGH_LIGHT] = 0xFFF5E6D8 -- 落日余晖的暖白
d.type_44[code.EGDC_3D_LIGHT] = 0xFFFFD1A5 -- 明亮的夕阳高光
d.type_44[code.EGDC_APP_WORKSPACE] = 0xFFF9F5F0 -- 浅沙色背景
d.type_44[code.EGDC_BUTTON_TEXT] = 0xFF4A3C30 -- 深咖啡色文字(保持对比度)
d.type_44[code.EGDC_GRAY_TEXT] = 0xFFA89B91 -- 中性灰文字
d.type_44[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF5D4037 -- 深褐色高亮文本
d.type_44[code.EGDC_HIGH_LIGHT] = 0xaaFFB347 -- 半透明夕阳高亮(保持透明度)
d.type_44[code.EGDC_ACTIVE_BORDER] = 0xFFD35400 -- 深橙色边框
d.type_44[code.EGDC_ACTIVE_CAPTION] = d.type_44[code.EGDC_HIGH_LIGHT_TEXT]
d.type_44[code.EGDC_INACTIVE_BORDER] = 0xFFEED9C4
d.type_44[code.EGDC_INACTIVE_CAPTION] = 0xFFD4BEB1
d.type_44[code.EGDC_TOOLTIP] = 0xFF5D4037 -- 深褐色工具提示
d.type_44[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFEBD6 -- 半透明奶油色背景
d.type_44[code.EGDC_SCROLLBAR] = 0x80FFA07A -- 半透明夕阳色滚动条
d.type_44[code.EGDC_EDITABLE] = d.type_44[code.EGDC_3D_HIGH_LIGHT]
d.type_44[code.EGDC_GRAY_EDITABLE] = 0xFFE6E0D9 -- 浅灰色禁用状态
d.type_44[code.EGDC_FOCUSED_EDITABLE] = d.type_44[code.EGDC_HIGH_LIGHT]
d.type_44[code.EGDC_ICON] = 0xFFFF8C42 -- 夕阳图标色
d.type_44[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE74C3C -- 落日红高亮
d.type_44[code.EGDC_WINDOW_SYMBOL] = 0xFFFFA500 -- 保持金色符号
d.type_44[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA89B91
d.type_44[code.EGDC_WINDOW] = 0xFFFDF5E6 -- 乳白色窗口

d.type_45 = {}
-- 森林阴影层次（保持透明度FF）
d.type_45[code.EGDC_3D_DARK_SHADOW] = 0xFF4A6B3A -- 深苔绿阴影
d.type_45[code.EGDC_3D_SHADOW] = 0xFF6B8E4E -- 中绿色阴影
d.type_45[code.EGDC_3D_FACE] = 0xFF8FBC8F -- 森林主色（保持原饱和度）
d.type_45[code.EGDC_3D_HIGH_LIGHT] = 0xFFE8F5E9 -- 溪水反光色
d.type_45[code.EGDC_3D_LIGHT] = 0xFFC1E1C1 -- 嫩叶高光

-- 基础界面（对比度维持）
d.type_45[code.EGDC_APP_WORKSPACE] = 0xFFF0F8F0 -- 雾面浅绿背景
d.type_45[code.EGDC_BUTTON_TEXT] = 0xFF2E4B2E -- 深松针文字
d.type_45[code.EGDC_GRAY_TEXT] = 0xFFA0B8A0 -- 灰绿禁用文字
d.type_45[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFF0FFF0 -- 透白高亮文字（F0透明度保留）
d.type_45[code.EGDC_HIGH_LIGHT] = 0xaa6B8E23 -- 半透明新芽绿（aa透明度保留）

-- 边框与标题
d.type_45[code.EGDC_ACTIVE_BORDER] = 0xFF3D5C33 -- 活跃树干色
d.type_45[code.EGDC_ACTIVE_CAPTION] = d.type_45[code.EGDC_HIGH_LIGHT_TEXT]
d.type_45[code.EGDC_INACTIVE_BORDER] = 0xFFCADBCA -- 枯枝灰绿
d.type_45[code.EGDC_INACTIVE_CAPTION] = 0xFF7A997A

-- 交互元素
d.type_45[code.EGDC_TOOLTIP] = 0xFF2F4F4F -- 深溪石文字
d.type_45[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDE6F2E6 -- 半透明水雾绿（DD透明度）
d.type_45[code.EGDC_SCROLLBAR] = 0x808FBC8F -- 半透明森林色（80透明度）

-- 输入框状态
d.type_45[code.EGDC_EDITABLE] = d.type_45[code.EGDC_3D_HIGH_LIGHT]
d.type_45[code.EGDC_GRAY_EDITABLE] = 0xFFD3E3D3 -- 浅灰绿禁用态
d.type_45[code.EGDC_FOCUSED_EDITABLE] = 0xFFC8E6C0 -- 聚焦时的溪水绿

-- 图标与装饰
d.type_45[code.EGDC_ICON] = 0xFF2E8B57 -- 森林图标色
d.type_45[code.EGDC_ICON_HIGH_LIGHT] = 0xFF32CD32 -- 鲜绿高亮
d.type_45[code.EGDC_WINDOW_SYMBOL] = 0xFF6B8E23 -- 橄榄金符号
d.type_45[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFC0D6C0
d.type_45[code.EGDC_WINDOW] = 0xFFF5FFF5 -- 极浅水色

d.type_46 = {}
d.type_46[code.EGDC_3D_DARK_SHADOW] = 0xFFD3D3D3 -- 浅灰色暗阴影 (原深色1A1A1A的浅色对应)
d.type_46[code.EGDC_3D_SHADOW] = 0xFFE6E6E6 -- 更浅的灰色阴影 (原333333的对应)
d.type_46[code.EGDC_3D_FACE] = 0xFFF0F8FF -- AliceBlue作为主背景 (原F58220橙色的冷色对应)
d.type_46[code.EGDC_3D_HIGH_LIGHT] = 0xFFE6F0FF -- 淡蓝色下拉背景 (原3A0C37深紫色的对应)
d.type_46[code.EGDC_3D_LIGHT] = 0xFF87CEFA -- 浅天空蓝高光 (原FFA500橙色的对应)
d.type_46[code.EGDC_APP_WORKSPACE] = 0xFFF5F5F5 -- 浅灰白工作区
d.type_46[code.EGDC_BUTTON_TEXT] = 0xFF333333 -- 深灰文字 (原白色的对应)
d.type_46[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9 -- 保持相同灰度值但感觉更亮
d.type_46[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF0066CC -- 深蓝高亮文本 (原F0FFFFFF的对应)
d.type_46[code.EGDC_HIGH_LIGHT] = 0xAAADD8E6 -- 淡蓝高亮背景 (原aaFF6600的对应)
d.type_46[code.EGDC_ACTIVE_BORDER] = 0xFF4682B4 -- 钢蓝活动边框 (原8B0000深红的对应)
d.type_46[code.EGDC_ACTIVE_CAPTION] = d.type_46[code.EGDC_HIGH_LIGHT_TEXT]
d.type_46[code.EGDC_INACTIVE_BORDER] = 0xFFDCDCDC -- 淡灰非活动边框
d.type_46[code.EGDC_INACTIVE_CAPTION] = 0xFFCCCCCC -- 更浅的非活动标题
d.type_46[code.EGDC_TOOLTIP] = 0xFF333333 -- 深灰工具提示文本
d.type_46[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFFFFF -- 白色半透明工具提示背景
d.type_46[code.EGDC_SCROLLBAR] = 0x8087CEFA -- 半透明浅蓝滚动条
d.type_46[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑框
d.type_46[code.EGDC_GRAY_EDITABLE] = 0xFFF0F0F0 -- 浅灰禁用编辑框
d.type_46[code.EGDC_FOCUSED_EDITABLE] = 0xFFE6F0FF -- 淡蓝聚焦编辑框
d.type_46[code.EGDC_ICON] = 0xFF1E90FF -- 道奇蓝图标 (原FFA500的对应)
d.type_46[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6347 -- 番茄红高亮 (原FF0000的亮色保持)
d.type_46[code.EGDC_WINDOW_SYMBOL] = 0xFF4169E1 -- 皇室蓝符号 (原FFD700金色的对应)
d.type_46[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA9A9A9 -- 灰色符号
d.type_46[code.EGDC_WINDOW] = 0xFFFAFAFA -- 雪白窗口背景

d.type_47 = {}
d.type_47[code.EGDC_3D_DARK_SHADOW] = 0xFFE0E0E0 -- 浅灰阴影（原1A1A1A的浅色对应）
d.type_47[code.EGDC_3D_SHADOW] = 0xFFCCCCCC -- 更浅的阴影（原333333对应）
d.type_47[code.EGDC_3D_FACE] = 0xFF007ACC -- 主色调：微软蓝（原F58220橙→蓝，保持高饱和）
d.type_47[code.EGDC_3D_HIGH_LIGHT] = 0xFFE6F2FF -- 淡蓝下拉背景（原3A0C37深紫→浅蓝）
d.type_47[code.EGDC_3D_LIGHT] = 0xFF4FC3F7 -- 浅青高光（原FFA500橙→青）
d.type_47[code.EGDC_APP_WORKSPACE] = 0xFFF5F5F5 -- 极浅灰背景（原FFFFFF微调，避免过曝）
d.type_47[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 白色按钮文字（保持高对比）
d.type_47[code.EGDC_GRAY_TEXT] = 0xFF888888 -- 中灰文字（原A9A9A9稍深，提高可读性）
d.type_47[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF0066CC -- 深蓝高亮文本（原F0FFFFFF→深蓝）
d.type_47[code.EGDC_HIGH_LIGHT] = 0xAA4FC3F7 -- 半透明青高亮背景（原aaFF6600→青）
d.type_47[code.EGDC_ACTIVE_BORDER] = 0xFF1E88E5 -- 亮蓝活动边框（原8B0000深红→蓝）
d.type_47[code.EGDC_ACTIVE_CAPTION] = d.type_47[code.EGDC_HIGH_LIGHT_TEXT] -- 深蓝标题文本
d.type_47[code.EGDC_INACTIVE_BORDER] = 0xFFD6D6D6 -- 浅灰非活动边框（原413839→浅灰）
d.type_47[code.EGDC_INACTIVE_CAPTION] = 0xFFAAAAAA -- 浅灰非活动标题（原222222→浅灰）
d.type_47[code.EGDC_TOOLTIP] = 0xFF333333 -- 深灰工具提示文本（原FFFACD→深色）
d.type_47[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFFFFF -- 白半透明提示背景（原DD2F2F2F→白）
d.type_47[code.EGDC_SCROLLBAR] = 0x804FC3F7 -- 半透明青滚动条（原80F58220→青）
d.type_47[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑框（原3D_HIGH_LIGHT→白）
d.type_47[code.EGDC_GRAY_EDITABLE] = 0xFFEEEEEE -- 极浅灰禁用编辑框（原D3D3D3→更浅）
d.type_47[code.EGDC_FOCUSED_EDITABLE] = 0xFFE6F2FF -- 淡蓝聚焦编辑框（原HIGH_LIGHT→淡蓝）
d.type_47[code.EGDC_ICON] = 0xFF1E88E5 -- 亮蓝图标（原FFA500橙→蓝）
d.type_47[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF5252 -- 亮红高亮（原FF0000→更现代红）
d.type_47[code.EGDC_WINDOW_SYMBOL] = 0xFF1E88E5 -- 亮蓝窗口符号（原FFD700金→蓝）
d.type_47[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFCCCCCC -- 浅灰符号（原FFFFFF→稍暗）
d.type_47[code.EGDC_WINDOW] = 0xFFF9F9F9 -- 雪白窗口（原FFFFFF→微暖白）

d.type_48 = {}
-- 基础色系（保持原有透明度/饱和度/对比度关系）
d.type_48[code.EGDC_3D_DARK_SHADOW] = 0xFFE0E0E0 -- 浅灰阴影（原1A1A1A的浅色反转）
d.type_48[code.EGDC_3D_SHADOW] = 0xFFF0F0F0 -- 极浅阴影（原333333的浅色反转）
d.type_48[code.EGDC_3D_FACE] = 0xFF4A90E2 -- 主色调改为深天蓝（原F58220橙的冷色系对应）
d.type_48[code.EGDC_3D_HIGH_LIGHT] = 0xFFF8F4FF -- 珍珠白背景（原3A0C37的浅色反转）

-- 阴阳对比增强
d.type_48[code.EGDC_3D_LIGHT] = 0xFFFFD166 -- 琥珀色高光（原FFA500的暖色强化）
d.type_48[code.EGDC_APP_WORKSPACE] = 0xFFF5F7FA -- 冰川白工作区
d.type_48[code.EGDC_BUTTON_TEXT] = 0xFF2D3748 -- 深钢蓝文字（原FFFFFFFF的反转）

-- 层次感控制组
d.type_48[code.EGDC_GRAY_TEXT] = 0xFF94A3B8 -- 雾霾灰文字（保持A9A9A9的饱和度）
d.type_48[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF1E293B -- 午夜蓝高亮文（原F0FFFFFF的反转）
d.type_48[code.EGDC_HIGH_LIGHT] = 0xAA4C8CFF -- 半透明湖蓝高亮（原aaFF6600的冷色对应）

-- 阴阳边界组
d.type_48[code.EGDC_ACTIVE_BORDER] = 0xFF2563EB -- 活力蓝边框（原8B0000的冷色对应）
d.type_48[code.EGDC_ACTIVE_CAPTION] = d.type_48[code.EGDC_HIGH_LIGHT_TEXT]
d.type_48[code.EGDC_INACTIVE_BORDER] = 0xFFCBD5E1 -- 浅灰蓝边框（原413839的浅色反转）
d.type_48[code.EGDC_INACTIVE_CAPTION] = 0xFFE2E8F0 -- 云母灰标题（原222222的浅色反转）

-- 辅助元素组
d.type_48[code.EGDC_TOOLTIP] = 0xFF1E293B -- 深空蓝提示文（原FFFACD的反转）
d.type_48[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDEDF2F8 -- 半透明珍珠背（原DD2F2F2F的反转）
d.type_48[code.EGDC_SCROLLBAR] = 0x804A90E2 -- 主色调半透明滚动条

-- 输入控件组（保持层次对比）
d.type_48[code.EGDC_EDITABLE] = 0xFFF1F5F9 -- 雪白编辑区（原3D_HIGH_LIGHT的浅化）
d.type_48[code.EGDC_GRAY_EDITABLE] = 0xFFE2E8F0 -- 浅灰禁用态
d.type_48[code.EGDC_FOCUSED_EDITABLE] = 0xFFDBEAFE -- 天蓝聚焦态

-- 图标系统（阴阳对比强化）
d.type_48[code.EGDC_ICON] = 0xFFFFA500 -- 保留橙色图标（形成冷暖对比）
d.type_48[code.EGDC_ICON_HIGH_LIGHT] = 0xFF3B82F6 -- 亮蓝高光（原FF0000的冷色对应）
d.type_48[code.EGDC_WINDOW_SYMBOL] = 0xFFF59E0B -- 琥珀黄符号
d.type_48[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF64748B -- 石板灰符号
d.type_48[code.EGDC_WINDOW] = 0xFFFFFFFF -- 纯白窗口背景

d.type_49 = {}
-- 阴阳基色（白为阳，青为阴）
d.type_49[code.EGDC_3D_DARK_SHADOW] = 0xFFE8E8E8 -- 素绢阴影（如宣纸褶皱）
d.type_49[code.EGDC_3D_SHADOW] = 0xFFF0F0F0 -- 蝉翼阴影（保持33%透明度感）
d.type_49[code.EGDC_3D_FACE] = 0xFF5D8CFF -- 青花瓷蓝（原橙色的阴阳对应）
d.type_49[code.EGDC_3D_HIGH_LIGHT] = 0xFFF8F4FF -- 象牙白背景（对应原深紫）

-- 五行配色体系
d.type_49[code.EGDC_3D_LIGHT] = 0xFFFFD700 -- 金（帝王黄高光）
d.type_49[code.EGDC_APP_WORKSPACE] = 0xFFF9F9F9 -- 宣纸白工作区
d.type_49[code.EGDC_BUTTON_TEXT] = 0xFF333333 -- 墨色文字（阴阳反转）

-- 水墨层次组
d.type_49[code.EGDC_GRAY_TEXT] = 0xFFA6A6A6 -- 淡墨文字（保持原饱和度）
d.type_49[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF2A2A2A -- 焦墨高亮文（虚实对比）
d.type_49[code.EGDC_HIGH_LIGHT] = 0xAA66B3FF -- 半透明天青（如汝窑釉色）

-- 阴阳边界（借鉴园林漏窗意象）
d.type_49[code.EGDC_ACTIVE_BORDER] = 0xFF4A7CFF -- 靛蓝窗框（对应原暗红）
d.type_49[code.EGDC_ACTIVE_CAPTION] = 0xFF2A2A2A -- 黛瓦色标题
d.type_49[code.EGDC_INACTIVE_BORDER] = 0xFFD4D4D4 -- 月白边框
d.type_49[code.EGDC_INACTIVE_CAPTION] = 0xFFE5E5E5 -- 云灰色标题

-- 文房四宝元素
d.type_49[code.EGDC_TOOLTIP] = 0xFF4A4A4A -- 松烟墨提示
d.type_49[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDF7F7F7 -- 澄心堂纸背
d.type_49[code.EGDC_SCROLLBAR] = 0x805D8CFF -- 青花卷轴（保持80透明度）

-- 虚实编辑区（借鉴留白美学）
d.type_49[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 素白编辑区
d.type_49[code.EGDC_GRAY_EDITABLE] = 0xFFEAEAEA -- 雨过天青云破处
d.type_49[code.EGDC_FOCUSED_EDITABLE] = 0xFFE6F2FF -- 天青色聚焦

-- 点睛之笔（朱砂与石青）
d.type_49[code.EGDC_ICON] = 0xFFFF6B6B -- 朱砂图标（原橙转绛色）
d.type_49[code.EGDC_ICON_HIGH_LIGHT] = 0xFF4A7CFF -- 石青高光
d.type_49[code.EGDC_WINDOW_SYMBOL] = 0xFFFFA500 -- 保留琥珀色（五行之土）
d.type_49[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB8B8B8 -- 青灰符号
d.type_49[code.EGDC_WINDOW] = 0xFFFFFFFF -- 纯白如绢

d.type_50 = {}
-- 基础色系 (久旱逢甘霖 - 清新水色系)
d.type_50[code.EGDC_3D_DARK_SHADOW] = 0xFFD6E4F0 -- 深水蓝阴影
d.type_50[code.EGDC_3D_SHADOW] = 0xFFE1EFF9 -- 水波涟漪的浅阴影
d.type_50[code.EGDC_3D_FACE] = 0xFFF5F9FC -- 纯净水面般的按钮背景

-- 活力色系 (他乡遇故知 - 温暖橙色系)
d.type_50[code.EGDC_3D_HIGH_LIGHT] = 0xFFF8E0B0 -- 老友相见的温暖米黄
d.type_50[code.EGDC_3D_LIGHT] = 0xFFFFD166 -- 欢乐相聚的亮橙色

-- 浪漫色系 (洞房花烛夜 - 柔美粉紫色)
d.type_50[code.EGDC_APP_WORKSPACE] = 0xFFFFF9FB -- 柔和的婚纱白
d.type_50[code.EGDC_HIGH_LIGHT] = 0xAAFFB6C1 -- 半透明玫瑰粉(高亮背景)
d.type_50[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF80AB -- 喜庆的粉红色

-- 荣耀色系 (金榜题名时 - 辉煌金绿系)
d.type_50[code.EGDC_BUTTON_TEXT] = 0xFF555555 -- 稳重深灰文本
d.type_50[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF2A5C0D -- 荣耀金绿色文本
d.type_50[code.EGDC_WINDOW_SYMBOL] = 0xFFC9B037 -- 状元金牌色

-- 辅助色系 (保持原透明度对比度)
d.type_50[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9 -- 保持原灰度
d.type_50[code.EGDC_ACTIVE_BORDER] = 0xFFF0A830 -- 活力橙边框
d.type_50[code.EGDC_ACTIVE_CAPTION] = 0xFF4A90E2 -- 清新蓝标题
d.type_50[code.EGDC_INACTIVE_BORDER] = 0xFFD4D8D0
d.type_50[code.EGDC_INACTIVE_CAPTION] = 0xFFA0A0A0
d.type_50[code.EGDC_TOOLTIP] = 0xFF555555 -- 深灰工具文字
d.type_50[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDEEEEEE -- 半透明白背景
d.type_50[code.EGDC_SCROLLBAR] = 0x80FFD166 -- 保持原透明度橙色
d.type_50[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑框
d.type_50[code.EGDC_GRAY_EDITABLE] = 0xFFF0F0F0 -- 浅灰禁用状态
d.type_50[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFE0 -- 米黄聚焦状态
d.type_50[code.EGDC_ICON] = 0xFF4FC3F7 -- 清新蓝图标
d.type_50[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFCCCCCC
d.type_50[code.EGDC_WINDOW] = 0xFFFDFDFD -- 纯净窗白

d.type_51 = {}
-- 基础阴影与3D效果（降低对比度，使用灰调）
d.type_51[code.EGDC_3D_DARK_SHADOW] = 0xFFD1D1D1 -- 浅灰阴影（原深黑）
d.type_51[code.EGDC_3D_SHADOW] = 0xFFE0E0E0 -- 更浅的阴影层
d.type_51[code.EGDC_3D_FACE] = 0xFFF5F5F5 -- 主背景（柔白）
d.type_51[code.EGDC_3D_HIGH_LIGHT] = 0xFFE3F2FD -- 淡蓝作为高亮（护眼冷色调）
d.type_51[code.EGDC_3D_LIGHT] = 0xFFFAFAFA -- 最浅层高光

-- 工作区与文本（提高可读性）
d.type_51[code.EGDC_APP_WORKSPACE] = 0xFFF8F8F8 -- 米白工作区
d.type_51[code.EGDC_BUTTON_TEXT] = 0xFF555555 -- 深灰文字（非纯黑）
d.type_51[code.EGDC_GRAY_TEXT] = 0xFFAAAAAA -- 禁用态文字（中灰）
d.type_51[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF4A89DC -- 高亮文字（柔和蓝）

-- 交互元素（柔化焦点色）
d.type_51[code.EGDC_HIGH_LIGHT] = 0xAAE3F2FD -- 半透明淡蓝高亮背景
d.type_51[code.EGDC_ACTIVE_BORDER] = 0xFF81D4FA -- 活动边框（天蓝）
d.type_51[code.EGDC_ACTIVE_CAPTION] = 0xFF4A89DC -- 标题文字（统一蓝色系）

-- 非活跃状态（弱化对比）
d.type_51[code.EGDC_INACTIVE_BORDER] = 0xFFE0E0E0 -- 浅灰边框
d.type_51[code.EGDC_INACTIVE_CAPTION] = 0xFF999999 -- 中灰标题

-- 辅助功能（柔光黄+灰）
d.type_51[code.EGDC_TOOLTIP] = 0xFF666666 -- 工具提示文字（深灰）
d.type_51[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF5F5F5 -- 半透明白底
d.type_51[code.EGDC_SCROLLBAR] = 0x80B0BEC5 -- 滚动条（灰蓝）

-- 编辑框状态（层次区分）
d.type_51[code.EGDC_EDITABLE] = 0xFFFFFFFF -- 纯白编辑区
d.type_51[code.EGDC_GRAY_EDITABLE] = 0xFFEEEEEE -- 禁用态（浅灰）
d.type_51[code.EGDC_FOCUSED_EDITABLE] = 0xFFE3F2FD -- 聚焦时淡蓝背景

-- 图标与符号（降低刺眼度）
d.type_51[code.EGDC_ICON] = 0xFF81D4FA -- 图标主色（天蓝）
d.type_51[code.EGDC_ICON_HIGH_LIGHT] = 0xFF4A89DC -- 高亮图标（深蓝）
d.type_51[code.EGDC_WINDOW_SYMBOL] = 0xFF4A89DC -- 窗口符号色
d.type_51[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFCCCCCC -- 灰色符号
d.type_51[code.EGDC_WINDOW] = 0xFFFFFFFF -- 窗口背景纯白

d.type_52 = {}
-- 基础灰阶系统（从0x10到0xE0分6个层级）
d.type_52[code.EGDC_3D_DARK_SHADOW] = 0xFF101010 -- 最深背景层
d.type_52[code.EGDC_3D_SHADOW] = 0xFF252525 -- 次级背景
d.type_52[code.EGDC_3D_FACE] = 0xFF404040 -- 主界面底色
d.type_52[code.EGDC_3D_HIGH_LIGHT] = 0xFF606060 -- 高亮面板
d.type_52[code.EGDC_3D_LIGHT] = 0xFF808080 -- 边缘高光
d.type_52[code.EGDC_APP_WORKSPACE] = 0xFFE0E0E0 -- 最浅工作区

-- 功能色系统（主色调：科技蓝 0xFF4285F4）
d.type_52[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 纯白文字
d.type_52[code.EGDC_GRAY_TEXT] = 0xFFA0A0A0 -- 禁用文字
d.type_52[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF4285F4 -- 主色文字
d.type_52[code.EGDC_HIGH_LIGHT] = 0x334285F4 -- 25%透明度主色高亮
d.type_52[code.EGDC_ACTIVE_BORDER] = 0xFF4285F4 -- 活动边框
d.type_52[code.EGDC_ACTIVE_CAPTION] = 0xFF4285F4 -- 活动标题
d.type_52[code.EGDC_INACTIVE_BORDER] = 0xFF505050 -- 非活动边框
d.type_52[code.EGDC_INACTIVE_CAPTION] = 0xFF707070 -- 非活动标题

-- 辅助元素
d.type_52[code.EGDC_TOOLTIP] = 0xFFF0F0F0 -- 工具提示文字
d.type_52[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD303030 -- 工具提示背景
d.type_52[code.EGDC_SCROLLBAR] = 0x804285F4 -- 半透明滚动条
d.type_52[code.EGDC_EDITABLE] = 0xFF505050 -- 输入框底色
d.type_52[code.EGDC_GRAY_EDITABLE] = 0xFF353535 -- 禁用输入框
d.type_52[code.EGDC_FOCUSED_EDITABLE] = 0xFF606060 -- 激活输入框

-- 图标系统
d.type_52[code.EGDC_ICON] = 0xFF4285F4 -- 主色图标
d.type_52[code.EGDC_ICON_HIGH_LIGHT] = 0xFFEA4335 -- 警示红图标
d.type_52[code.EGDC_WINDOW_SYMBOL] = 0xFF4285F4 -- 窗口控件
d.type_52[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF808080 -- 禁用控件
d.type_52[code.EGDC_WINDOW] = 0xFF202020 -- 窗口背景

d.type_53 = {}
d.type_53[code.EGDC_3D_DARK_SHADOW] = 0xFF2D4A36    -- 深绿阴影 (基于#3A5A40加深)
d.type_53[code.EGDC_3D_SHADOW] = 0xFF3A5A40         -- 主深绿色
d.type_53[code.EGDC_3D_FACE] = 0xFFE3EDCD          -- 浅绿作为按钮/窗口背景
d.type_53[code.EGDC_3D_HIGH_LIGHT] = 0xFFA7C4BC    -- 浅青色用于高亮元素
d.type_53[code.EGDC_3D_LIGHT] = 0xFFF0F7E6         -- 米白色作为亮部

d.type_53[code.EGDC_APP_WORKSPACE] = 0xFFF0F7E6    -- 米白工作区
d.type_53[code.EGDC_BUTTON_TEXT] = 0xFF3A5A40      -- 深绿按钮文字
d.type_53[code.EGDC_GRAY_TEXT] = 0xFF8A9B8C        -- 灰化文字
d.type_53[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFF0F7E6  -- 米白高亮文字
d.type_53[code.EGDC_HIGH_LIGHT] = 0xAA3A5A40       -- 半透明深绿高亮背景

d.type_53[code.EGDC_ACTIVE_BORDER] = 0xFF3A5A40    -- 深绿活动边框
d.type_53[code.EGDC_ACTIVE_CAPTION] = 0xFFF0F7E6   -- 米白活动标题文字
d.type_53[code.EGDC_INACTIVE_BORDER] = 0x80A7C4BC  -- 半透明浅青非活动边框
d.type_53[code.EGDC_INACTIVE_CAPTION] = 0xFF8A9B8C -- 灰化非活动标题

d.type_53[code.EGDC_TOOLTIP] = 0xFF3A5A40          -- 深绿工具提示文字
d.type_53[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDF0F7E6 -- 半透明米白工具提示背景

d.type_53[code.EGDC_SCROLLBAR] = 0x803A5A40        -- 半透明深绿滚动条
d.type_53[code.EGDC_EDITABLE] = 0xFFF0F7E6        -- 米白编辑框
d.type_53[code.EGDC_GRAY_EDITABLE] = 0xFFD1D9C6    -- 灰化编辑框
d.type_53[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF -- 纯白聚焦编辑框

d.type_53[code.EGDC_ICON] = 0xFF3A5A40             -- 深绿图标
d.type_53[code.EGDC_ICON_HIGH_LIGHT] = 0xFFA7C4BC  -- 浅青高亮图标
d.type_53[code.EGDC_WINDOW_SYMBOL] = 0xFF3A5A40    -- 深绿复选框
d.type_53[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8A9B8C -- 灰化符号
d.type_53[code.EGDC_WINDOW] = 0xFFF0F7E6           -- 米白窗口背景

d.type_54 = {}

-- 深绿色作为暗阴影，用于增加深度感
d.type_54[code.EGDC_3D_DARK_SHADOW] = 0xFF3A5A40
-- 浅绿色稍微变暗作为右下阴影
d.type_54[code.EGDC_3D_SHADOW] = 0xFF4A6A50
-- 浅绿色作为按钮与窗口的背景，提供清新感
d.type_54[code.EGDC_3D_FACE] = 0xFFF0F7E6
-- 淡黄色作为高亮部分，增加对比度
d.type_54[code.EGDC_3D_HIGH_LIGHT] = 0xFFE3EDCD
-- 浅灰色作为另一种高光或轻阴影效果
d.type_54[code.EGDC_3D_LIGHT] = 0xFFA7C4BC

-- 应用工作区背景使用浅绿色
d.type_54[code.EGDC_APP_WORKSPACE] = 0xFFF0F7E6
-- 按钮文本使用深绿色，确保可读性
d.type_54[code.EGDC_BUTTON_TEXT] = 0xFF3A5A40
-- 灰色文本用于不重要的信息
d.type_54[code.EGDC_GRAY_TEXT] = 0xFFA7C4BC
-- 高亮项的文本使用白色，确保在任何背景下都可读
d.type_54[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF
-- 高亮项背景使用淡黄色，增加视觉焦点
d.type_54[code.EGDC_HIGH_LIGHT] = 0xFFE3EDCD

-- 窗口标题在聚焦时的左边使用深绿色
d.type_54[code.EGDC_ACTIVE_BORDER] = 0xFF3A5A40
-- 窗口标题文本使用白色以确保可读性
d.type_54[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF
-- 非活动窗口边框使用浅灰色
d.type_54[code.EGDC_INACTIVE_BORDER] = 0xFFA7C4BC
-- 非活动窗口标题文本使用深绿色，但降低透明度以保持非活动状态
d.type_54[code.EGDC_INACTIVE_CAPTION] = 0x803A5A40

-- 工具提示文本使用深绿色，确保与背景对比
d.type_54[code.EGDC_TOOLTIP] = 0xFF3A5A40
-- 工具提示背景使用浅灰色，提供柔和的背景
d.type_54[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFA7C4BC

-- 滚动条使用淡黄色，与高亮部分呼应
d.type_54[code.EGDC_SCROLLBAR] = 0xFFE3EDCD
-- 普通状态的编辑框使用浅绿色背景
d.type_54[code.EGDC_EDITABLE] = 0xFFF0F7E6
-- 禁用状态的编辑框使用浅灰色，表示不可操作
d.type_54[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 -- 这里保留原配色以保持一致性，或可改为更深的灰色
-- 激活状态的编辑框使用高亮黄色，增加焦点
d.type_54[code.EGDC_FOCUSED_EDITABLE] = 0xFFE3EDCD

-- 图标使用深绿色，与主题色调一致
d.type_54[code.EGDC_ICON] = 0xFF3A5A40
-- 高亮图标使用红色，作为特殊标记或焦点
d.type_54[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 -- 这里保留原配色以突出重要性
-- 复选框文本使用淡黄色，与整体色调协调
d.type_54[code.EGDC_WINDOW_SYMBOL] = 0xFFE3EDCD
-- 非高亮复选框文本使用白色，确保可读性（或根据具体设计调整）
d.type_54[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFFFFFFF -- 根据实际视觉效果调整，这里设为白色以保持清晰

-- 窗口背景使用浅绿色，与整体主题一致
d.type_54[code.EGDC_WINDOW] = 0xFFF0F7E6


d.type_55 = {}
d.type_55[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A --按钮与窗口的暗阴影
d.type_55[code.EGDC_3D_SHADOW] = 0xFF333333 --按钮与窗口的右下阴影
d.type_55[code.EGDC_3D_FACE] = 0xFFF58220 --按钮与窗口的背景
d.type_55[code.EGDC_3D_HIGH_LIGHT] = 0xFF3A0C37 --下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项
d.type_55[code.EGDC_3D_LIGHT] = 0xFFFFA500
d.type_55[code.EGDC_APP_WORKSPACE] = 0xFFffffff
d.type_55[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF
d.type_55[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9
d.type_55[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF --高亮项的文本
d.type_55[code.EGDC_HIGH_LIGHT] = 0xaaFF6600 --高亮项的背景
d.type_55[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 --窗口标题在聚焦时的左边
d.type_55[code.EGDC_ACTIVE_CAPTION] = d.type_55[code.EGDC_HIGH_LIGHT_TEXT] --窗口标题的文本
d.type_55[code.EGDC_INACTIVE_BORDER] = 0xa0FFFFFF
d.type_55[code.EGDC_INACTIVE_CAPTION] = 0xFF222222
d.type_55[code.EGDC_TOOLTIP] = 0xFFFFFACD --工具提示的文本
d.type_55[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F --工具提示的背景
d.type_55[code.EGDC_SCROLLBAR] = 0x80F58220 --滚动条
d.type_55[code.EGDC_EDITABLE] = d.type_55[code.EGDC_3D_HIGH_LIGHT] --普通状态的编辑框
d.type_55[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 --禁用状态的编辑框
d.type_55[code.EGDC_FOCUSED_EDITABLE] = d.type_55[code.EGDC_HIGH_LIGHT] --激活状态的编辑框
d.type_55[code.EGDC_ICON] = 0xFFFFA500
d.type_55[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000
d.type_55[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 --复选框的文本
d.type_55[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFffffff
d.type_55[code.EGDC_WINDOW] = 0xFFffffff
-- 基础阴影与立体感
d.type_55[code.EGDC_3D_DARK_SHADOW] = 0xFF000000     -- 纯黑（最深阴影）
d.type_55[code.EGDC_3D_SHADOW]      = 0xFF222222     -- 暗灰（次级阴影）
d.type_55[code.EGDC_3D_FACE]        = 0xFF1A1A1A     -- 哑光黑（按钮/面板背景）
d.type_55[code.EGDC_3D_HIGH_LIGHT]  = 0xFF333333     -- 金属灰（高光边缘）
d.type_55[code.EGDC_3D_LIGHT]       = 0xFF444444     -- 浅灰（最强高光）

-- 核心黑金对比
d.type_55[code.EGDC_APP_WORKSPACE]  = 0xFF121212     -- 微光黑（主背景）
d.type_55[code.EGDC_BUTTON_TEXT]    = 0xFFFFD700     -- 黄金（按钮文字）
d.type_55[code.EGDC_HIGH_LIGHT]     = 0xAAFFD700     -- 半透明金（高亮背景）
d.type_55[code.EGDC_HIGH_LIGHT_TEXT]= 0xFFFFD700     -- 黄金（高亮文字）

-- 强调色（危险感）
d.type_55[code.EGDC_ACTIVE_BORDER]  = 0xFF8B0000     -- 暗红（活动边框，如血痕）
d.type_55[code.EGDC_ACTIVE_CAPTION] = 0xFFFFD700     -- 黄金（活动标题）
d.type_55[code.EGDC_ICON]           = 0xFFFFD700     -- 黄金（默认图标）
d.type_55[code.EGDC_ICON_HIGH_LIGHT]= 0xFFFF0000     -- 猩红（危险操作图标）

-- 辅助色
d.type_55[code.EGDC_GRAY_TEXT]      = 0xFF777777     -- 灰化文字（禁用状态）
d.type_55[code.EGDC_TOOLTIP]        = 0xFF000000     -- 纯黑（工具提示文字）
d.type_55[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEFFD700 -- 半透明金（工具提示背景）
d.type_55[code.EGDC_SCROLLBAR]      = 0x88FFD700     -- 透明金（滚动条）

-- 编辑框
d.type_55[code.EGDC_EDITABLE]       = 0xFF222222     -- 暗灰编辑框
d.type_55[code.EGDC_FOCUSED_EDITABLE] = 0xFF333333   -- 聚焦时加深
d.type_55[code.EGDC_GRAY_EDITABLE]  = 0xFF0A0A0A     -- 禁用时纯黑

-- 窗口元素
d.type_55[code.EGDC_WINDOW]         = 0xFF1A1A1A     -- 哑光黑窗口背景
d.type_55[code.EGDC_WINDOW_SYMBOL]  = 0xFFFFD700     -- 黄金复选框/符号


d.type_56 = {}
d.type_56[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A --按钮与窗口的暗阴影
d.type_56[code.EGDC_3D_SHADOW] = 0xFF333333 --按钮与窗口的右下阴影
d.type_56[code.EGDC_3D_FACE] = 0xFFF58220 --按钮与窗口的背景
d.type_56[code.EGDC_3D_HIGH_LIGHT] = 0xFF3A0C37 --下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项
d.type_56[code.EGDC_3D_LIGHT] = 0xFFFFA500
d.type_56[code.EGDC_APP_WORKSPACE] = 0xFFffffff
d.type_56[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF
d.type_56[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9
d.type_56[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF --高亮项的文本
d.type_56[code.EGDC_HIGH_LIGHT] = 0xaaFF6600 --高亮项的背景
d.type_56[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 --窗口标题在聚焦时的左边
d.type_56[code.EGDC_ACTIVE_CAPTION] = d.type_56[code.EGDC_HIGH_LIGHT_TEXT] --窗口标题的文本
d.type_56[code.EGDC_INACTIVE_BORDER] = 0xa0FFFFFF
d.type_56[code.EGDC_INACTIVE_CAPTION] = 0xFF222222
d.type_56[code.EGDC_TOOLTIP] = 0xFFFFFACD --工具提示的文本
d.type_56[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F --工具提示的背景
d.type_56[code.EGDC_SCROLLBAR] = 0x80F58220 --滚动条
d.type_56[code.EGDC_EDITABLE] = d.type_56[code.EGDC_3D_HIGH_LIGHT] --普通状态的编辑框
d.type_56[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 --禁用状态的编辑框
d.type_56[code.EGDC_FOCUSED_EDITABLE] = d.type_56[code.EGDC_HIGH_LIGHT] --激活状态的编辑框
d.type_56[code.EGDC_ICON] = 0xFFFFA500
d.type_56[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000
d.type_56[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 --复选框的文本
d.type_56[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFffffff
d.type_56[code.EGDC_WINDOW] = 0xFFffffff
-- 基础色调（中性色系）
d.type_56[code.EGDC_3D_DARK_SHADOW] = 0xFF3A3A3A     -- 深灰（阴影）
d.type_56[code.EGDC_3D_SHADOW]      = 0xFF5A5A5A     -- 中灰（次级阴影）
d.type_56[code.EGDC_3D_FACE]        = 0xFFE8E8E8     -- 珍珠白（按钮/面板背景）
d.type_56[code.EGDC_3D_HIGH_LIGHT]  = 0xFFF5F5F5     -- 纯白（高光）
d.type_56[code.EGDC_3D_LIGHT]       = 0xFFFFFFFF     -- 极亮白（最强高光）

-- 核心优雅配色
d.type_56[code.EGDC_APP_WORKSPACE]  = 0xFFF0F0F0     -- 浅灰白（主背景）
d.type_56[code.EGDC_BUTTON_TEXT]    = 0xFF5A4A3A     -- 深咖啡（按钮文字，优雅不刺眼）
d.type_56[code.EGDC_HIGH_LIGHT]     = 0x55D4AF37     -- 半透明金（高亮背景）
d.type_56[code.EGDC_HIGH_LIGHT_TEXT]= 0xFFD4AF37     -- 金属金（高亮文字）

-- 强调色（金色与深褐）
d.type_56[code.EGDC_ACTIVE_BORDER]  = 0xFFD4AF37     -- 金属金（活动边框）
d.type_56[code.EGDC_ACTIVE_CAPTION] = 0xFF5A4A3A     -- 深咖啡（活动标题）
d.type_56[code.EGDC_ICON]           = 0xFFA08B6B     -- 古铜金（默认图标）
d.type_56[code.EGDC_ICON_HIGH_LIGHT]= 0xFFD4AF37     -- 金属金（高亮图标）

-- 辅助色（低对比优雅）
d.type_56[code.EGDC_GRAY_TEXT]      = 0xFFA0A0A0     -- 灰化文字（禁用状态）
d.type_56[code.EGDC_TOOLTIP]        = 0xFF5A4A3A     -- 深咖啡（工具提示文字）
d.type_56[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF5F5F5 -- 半透明白（工具提示背景）
d.type_56[code.EGDC_SCROLLBAR]      = 0x88D4AF37     -- 透明金（滚动条）

-- 编辑框（柔和对比）
d.type_56[code.EGDC_EDITABLE]       = 0xFFFFFFFF     -- 纯白编辑框
d.type_56[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5F5F5   -- 浅灰聚焦状态
d.type_56[code.EGDC_GRAY_EDITABLE]  = 0xFFE0E0E0     -- 灰白禁用状态

-- 窗口元素（经典衬线风格）
d.type_56[code.EGDC_WINDOW]         = 0xFFFFFFFF     -- 纯白窗口背景
d.type_56[code.EGDC_WINDOW_SYMBOL]  = 0xFF5A4A3A     -- 深咖啡（复选框/符号）


d.type_57 = {}

-- 深绿色作为暗阴影，比基础色稍深一些以增加层次感
d.type_57[code.EGDC_3D_DARK_SHADOW] = 0xFF2A4A30
-- 浅灰绿色作为右下阴影，与深绿色形成对比
d.type_57[code.EGDC_3D_SHADOW] = 0xFFA0C0A0
-- 浅绿色作为按钮与窗口的背景，明亮且舒适
d.type_57[code.EGDC_3D_FACE] = 0xFFF0F7E6
-- 淡黄色作为高亮部分，如下拉框背景、窗口左边等，增加活力
d.type_57[code.EGDC_3D_HIGH_LIGHT] = 0xFFE3EDCD
-- 稍浅的淡黄色作为轻阴影，与高亮部分形成过渡
d.type_57[code.EGDC_3D_LIGHT] = 0xFFFEFEFE

-- 工作区背景使用浅绿色，保持一致性
d.type_57[code.EGDC_APP_WORKSPACE] = 0xFFF0F7E6
-- 按钮文本使用深绿色，与背景形成对比
d.type_57[code.EGDC_BUTTON_TEXT] = 0xFF3A5A40
-- 灰色文本使用浅灰绿色变暗，用于非活跃文本
d.type_57[code.EGDC_GRAY_TEXT] = 0xFF8A9A80
-- 高亮项文本使用白色，确保在任何背景下都清晰可见
d.type_57[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF
-- 高亮项背景使用淡黄色，与整体色调协调
d.type_57[code.EGDC_HIGH_LIGHT] = 0xFFE3EDCD

-- 聚焦窗口边框使用深绿色，表示当前激活状态
d.type_57[code.EGDC_ACTIVE_BORDER] = 0xFF3A5A40
-- 窗口标题文本使用高亮项文本颜色，确保清晰可见
d.type_57[code.EGDC_ACTIVE_CAPTION] = d.type_57[code.EGDC_HIGH_LIGHT_TEXT]
-- 非聚焦窗口边框使用浅灰绿色，表示非激活状态
d.type_57[code.EGDC_INACTIVE_BORDER] = 0xFFA7C4BC
-- 非聚焦窗口标题文本使用深绿色变暗，表示非活跃状态
d.type_57[code.EGDC_INACTIVE_CAPTION] = 0xFF5A7A60

-- 工具提示文本使用深绿色，与背景形成对比
d.type_57[code.EGDC_TOOLTIP] = 0xFF3A5A40
-- 工具提示背景使用浅绿色，确保文本清晰可见
d.type_57[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFECECEC -- 使用稍浅的灰色以确保文本可读性，原浅绿色可能不够明显

-- 滚动条使用深绿色，与整体色调协调
d.type_57[code.EGDC_SCROLLBAR] = 0xFF5A7A60
-- 普通状态编辑框使用淡黄色，与高亮部分呼应
d.type_57[code.EGDC_EDITABLE] = d.type_57[code.EGDC_3D_HIGH_LIGHT]
-- 禁用状态编辑框使用浅灰绿色变暗，表示不可编辑
d.type_57[code.EGDC_GRAY_EDITABLE] = 0xFFB0C8B0
-- 激活状态编辑框使用高亮项背景色，表示当前焦点
d.type_57[code.EGDC_FOCUSED_EDITABLE] = d.type_57[code.EGDC_HIGH_LIGHT]

-- 图标使用深绿色，与整体色调一致
d.type_57[code.EGDC_ICON] = 0xFF3A5A40
-- 高亮图标使用淡黄色，增加视觉焦点
d.type_57[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE3EDCD
-- 复选框文本使用淡黄色，与编辑框和高亮部分呼应
d.type_57[code.EGDC_WINDOW_SYMBOL] = 0xFFE3EDCD
-- 非活跃复选框文本使用浅灰绿色，表示非选中状态
d.type_57[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA7C4BC
-- 窗口背景使用浅绿色，与整体色调保持一致
d.type_57[code.EGDC_WINDOW] = 0xFFF0F7E6


d.type_58 = {}
d.type_58[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A --按钮与窗口的暗阴影
d.type_58[code.EGDC_3D_SHADOW] = 0xFF333333 --按钮与窗口的右下阴影
d.type_58[code.EGDC_3D_FACE] = 0xFFF58220 --按钮与窗口的背景
d.type_58[code.EGDC_3D_HIGH_LIGHT] = 0xFF3A0C37 --下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项
d.type_58[code.EGDC_3D_LIGHT] = 0xFFFFA500
d.type_58[code.EGDC_APP_WORKSPACE] = 0xFFffffff
d.type_58[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF
d.type_58[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9
d.type_58[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF --高亮项的文本
d.type_58[code.EGDC_HIGH_LIGHT] = 0xaaFF6600 --高亮项的背景
d.type_58[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 --窗口标题在聚焦时的左边
d.type_58[code.EGDC_ACTIVE_CAPTION] = d.type_58[code.EGDC_HIGH_LIGHT_TEXT] --窗口标题的文本
d.type_58[code.EGDC_INACTIVE_BORDER] = 0xa0FFFFFF
d.type_58[code.EGDC_INACTIVE_CAPTION] = 0xFF222222
d.type_58[code.EGDC_TOOLTIP] = 0xFFFFFACD --工具提示的文本
d.type_58[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F --工具提示的背景
d.type_58[code.EGDC_SCROLLBAR] = 0x80F58220 --滚动条
d.type_58[code.EGDC_EDITABLE] = d.type_58[code.EGDC_3D_HIGH_LIGHT] --普通状态的编辑框
d.type_58[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 --禁用状态的编辑框
d.type_58[code.EGDC_FOCUSED_EDITABLE] = d.type_58[code.EGDC_HIGH_LIGHT] --激活状态的编辑框
d.type_58[code.EGDC_ICON] = 0xFFFFA500
d.type_58[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000
d.type_58[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 --复选框的文本
d.type_58[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFffffff
d.type_58[code.EGDC_WINDOW] = 0xFFffffff
-- 基础色调（天地自然）
d.type_58[code.EGDC_3D_DARK_SHADOW] = 0xFF6B8E94     -- 远山青（最深阴影）
d.type_58[code.EGDC_3D_SHADOW]      = 0xFF9DB4B8     -- 雾霭灰（次级阴影）
d.type_58[code.EGDC_3D_FACE]        = 0xFFE8F1E6     -- 新芽白（按钮/面板背景）
d.type_58[code.EGDC_3D_HIGH_LIGHT]  = 0xFFF5F9F3     -- 云纱白（高光）
d.type_58[code.EGDC_3D_LIGHT]       = 0xFFFFFFFF     -- 雪色（最强高光）

-- 核心太平配色
d.type_58[code.EGDC_APP_WORKSPACE]  = 0xFFF0F5ED     -- 宣纸白（主背景）
d.type_58[code.EGDC_BUTTON_TEXT]    = 0xFF5A716A     -- 松墨绿（按钮文字）
d.type_58[code.EGDC_HIGH_LIGHT]     = 0x556B8E94     -- 半透明远山青（高亮背景）
d.type_58[code.EGDC_HIGH_LIGHT_TEXT]= 0xFF5A716A     -- 松墨绿（高亮文字）

-- 强调色（生命与和谐）
d.type_58[code.EGDC_ACTIVE_BORDER]  = 0xFFA7C4BC     -- 溪水青（活动边框）
d.type_58[code.EGDC_ACTIVE_CAPTION] = 0xFF3A5A40     -- 深竹绿（活动标题）
d.type_58[code.EGDC_ICON]           = 0xFF7A9D96     -- 青瓷色（默认图标）
d.type_58[code.EGDC_ICON_HIGH_LIGHT]= 0xFF3A5A40     -- 深竹绿（高亮图标）

-- 辅助色（柔和过渡）
d.type_58[code.EGDC_GRAY_TEXT]      = 0xFFB0BEC5     -- 雁灰（禁用文字）
d.type_58[code.EGDC_TOOLTIP]        = 0xFF5A716A     -- 松墨绿（工具提示文字）
d.type_58[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF0F5ED -- 半透明宣纸白（提示背景）
d.type_58[code.EGDC_SCROLLBAR]      = 0x887A9D96     -- 透明青瓷（滚动条）

-- 编辑框（水墨意境）
d.type_58[code.EGDC_EDITABLE]       = 0xFFFFFFFF     -- 雪色编辑框
d.type_58[code.EGDC_FOCUSED_EDITABLE] = 0xFFE8F1E6   -- 新芽白聚焦状态
d.type_58[code.EGDC_GRAY_EDITABLE]  = 0xFFDFE6DA     -- 苔灰禁用状态

-- 窗口元素（留白之美）
d.type_58[code.EGDC_WINDOW]         = 0xFFFFFFFF     -- 雪色窗口背景
d.type_58[code.EGDC_WINDOW_SYMBOL]  = 0xFF5A716A     -- 松墨绿（复选框/符号）

d.type_59 = {}
d.type_59 = {}
d.type_59[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A --按钮与窗口的暗阴影
d.type_59[code.EGDC_3D_SHADOW] = 0xFF333333 --按钮与窗口的右下阴影
d.type_59[code.EGDC_3D_FACE] = 0xFFF58220 --按钮与窗口的背景
d.type_59[code.EGDC_3D_HIGH_LIGHT] = 0xFF3A0C37 --下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项
d.type_59[code.EGDC_3D_LIGHT] = 0xFFFFA500
d.type_59[code.EGDC_APP_WORKSPACE] = 0xFFffffff
d.type_59[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF
d.type_59[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9
d.type_59[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF --高亮项的文本
d.type_59[code.EGDC_HIGH_LIGHT] = 0xaaFF6600 --高亮项的背景
d.type_59[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 --窗口标题在聚焦时的左边
d.type_59[code.EGDC_ACTIVE_CAPTION] = d.type_59[code.EGDC_HIGH_LIGHT_TEXT] --窗口标题的文本
d.type_59[code.EGDC_INACTIVE_BORDER] = 0xa0FFFFFF
d.type_59[code.EGDC_INACTIVE_CAPTION] = 0xFF222222
d.type_59[code.EGDC_TOOLTIP] = 0xFFFFFACD --工具提示的文本
d.type_59[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F --工具提示的背景
d.type_59[code.EGDC_SCROLLBAR] = 0x80F58220 --滚动条
d.type_59[code.EGDC_EDITABLE] = d.type_59[code.EGDC_3D_HIGH_LIGHT] --普通状态的编辑框
d.type_59[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 --禁用状态的编辑框
d.type_59[code.EGDC_FOCUSED_EDITABLE] = d.type_59[code.EGDC_HIGH_LIGHT] --激活状态的编辑框
d.type_59[code.EGDC_ICON] = 0xFFFFA500
d.type_59[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000
d.type_59[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 --复选框的文本
d.type_59[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFffffff
d.type_59[code.EGDC_WINDOW] = 0xFFffffff
--==== 龙鳞金 ====--
d.type_59[code.EGDC_3D_DARK_SHADOW] = 0xFF5D432C  -- 玄铁龙鳞暗纹
d.type_59[code.EGDC_3D_SHADOW]      = 0xFFD4AF37  -- 龙腹金鳞反光
d.type_59[code.EGDC_3D_FACE]        = 0xFFFFD700  -- 龙睛纯金色
d.type_59[code.EGDC_3D_HIGH_LIGHT]  = 0xFFF8E473  -- 龙角高光

--==== 凤羽彩 ====--
d.type_59[code.EGDC_3D_LIGHT]       = 0xFFE0115F  -- 凤冠朱砂红
d.type_59[code.EGDC_HIGH_LIGHT]     = 0x66FF1493  -- 凤尾霓虹光晕
d.type_59[code.EGDC_ICON_HIGH_LIGHT]= 0xFFFF00FF  -- 凤翎紫晶色

--==== 天宫云 ====--
d.type_59[code.EGDC_APP_WORKSPACE]  = 0xFFF0F8FF  -- 天河云浪底色
d.type_59[code.EGDC_WINDOW]         = 0x88E6E6FA  -- 月华纱雾透明度
d.type_59[code.EGDC_TOOLTIP_BACKGROUND]=0xCC483D8B-- 夜穹星河背景

--==== 仙器光 ====--
d.type_59[code.EGDC_ACTIVE_BORDER]  = 0xFF00BFFF  -- 轩辕剑剑气蓝
d.type_59[code.EGDC_SCROLLBAR]      = 0xFF7FFFD4  -- 碧玉琵琶弦色
d.type_59[code.EGDC_EDITABLE]       = 0xFF7CFC00  -- 神农鼎药草绿

-- 特别彩蛋 --
d.type_59[code.EGDC_BUTTON_TEXT]    = 0xFFFFDEAD  -- 仙桃蜜糖色文字
d.type_59[code.EGDC_HIGH_LIGHT_TEXT]= 0xFFFFFF00  -- 金丹发光特效


d.type_60 = {}
-- 基础色调（自然疗愈系）
d.type_60[code.EGDC_3D_DARK_SHADOW] = 0xFF2D4A36    -- 深松绿（安全感的阴影）
d.type_60[code.EGDC_3D_SHADOW] = 0xFF3A5A40       -- 主森林绿（稳固支撑）
d.type_60[code.EGDC_3D_FACE] = 0xFFE3EDCD         -- 嫩芽白（充满生机的背景）
d.type_60[code.EGDC_3D_HIGH_LIGHT] = 0xFFA7C4BC   -- 溪水青（温柔的高亮）
d.type_60[code.EGDC_3D_LIGHT] = 0xFFF0F7E6        -- 晨雾白（最柔和的亮部）

-- 核心交互色（符合WCAG AA对比度标准）
d.type_60[code.EGDC_APP_WORKSPACE] = 0xFFF0F7E6   -- 主背景（护眼米白）
d.type_60[code.EGDC_BUTTON_TEXT] = 0xFF3A5A40      -- 森林绿（6.3:1对比度）
d.type_60[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF3A5A40  -- 强调文字（清晰可读）
d.type_60[code.EGDC_HIGH_LIGHT] = 0x33A7C4BC      -- 10%透明溪水青（柔和提示）

-- 状态色（充满人文关怀）
d.type_60[code.EGDC_ACTIVE_BORDER] = 0xFF5A8C72   -- 新生绿（活跃状态）
d.type_60[code.EGDC_ACTIVE_CAPTION] = 0xFF3A5A40  -- 森林绿（当前焦点）
d.type_60[code.EGDC_INACTIVE_BORDER] = 0x80A7C4BC -- 20%溪水青（非活动状态）
d.type_60[code.EGDC_INACTIVE_CAPTION] = 0xFF88A38D -- 灰绿（非活动文字）

-- 辅助功能色（无障碍设计）
d.type_60[code.EGDC_GRAY_TEXT] = 0xFFA7B8A9       -- 苔藓灰（禁用状态4.5:1对比度）
d.type_60[code.EGDC_TOOLTIP] = 0xFF3A5A40         -- 森林绿工具提示
d.type_60[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF0F7E6 -- 半透明米白背景
d.type_60[code.EGDC_SCROLLBAR] = 0x883A5A40       -- 森林绿滚动条（易发现）

-- 输入区域（专注友好）
d.type_60[code.EGDC_EDITABLE] = 0xFFFFFFFF        -- 纯白编辑框
d.type_60[code.EGDC_FOCUSED_EDITABLE] = 0xFFF0F7E6 -- 米白聚焦状态
d.type_60[code.EGDC_GRAY_EDITABLE] = 0xFFE0E8D8   -- 浅灰绿禁用状态

-- 图标与符号（激发潜能）
d.type_60[code.EGDC_ICON] = 0xFF5A8C72           -- 新生绿（正向操作）
d.type_60[code.EGDC_ICON_HIGH_LIGHT] = 0xFF3A5A40 -- 森林绿（重要行动）
d.type_60[code.EGDC_WINDOW_SYMBOL] = 0xFF5A8C72  -- 新生绿复选框
d.type_60[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA7B8A9 -- 苔藓灰禁用符号

--~ -- 窗口元素（宁静包容）
d.type_60[code.EGDC_WINDOW] = 0xFFFFFFFF          -- 纯白窗口
--~ d.type_60[code.EGDC_WINDOW_TEXT] = 0xFF3A5A40     -- 森林绿文字

d.type_61 = {}
-- 基础3D效果色组（增强立体感）
d.type_61[code.EGDC_3D_DARK_SHADOW]    = 0xFF2A0A37  -- 深紫色阴影（替代原来的灰色，增加游戏感）
d.type_61[code.EGDC_3D_SHADOW]         = 0xFF5E1D6E  -- 亮紫色阴影（与主色调呼应）
d.type_61[code.EGDC_3D_FACE]           = 0xFFFF6B00  -- 活力橙（核心按钮色，比原版更鲜艳）
d.type_61[code.EGDC_3D_HIGH_LIGHT]     = 0xFF00E0FF  -- 赛博蓝（高亮色，科技感替代原紫色）
d.type_61[code.EGDC_3D_LIGHT]          = 0xFFFFD166  -- 琥珀黄（边缘高光）

-- 背景/文字色（保证可读性）
d.type_61[code.EGDC_APP_WORKSPACE]     = 0xFF1E1E2C  -- 深蓝紫背景（减少眼部疲劳）
d.type_61[code.EGDC_BUTTON_TEXT]       = 0xFFFFFFFF  -- 纯白文字（高对比）
d.type_61[code.EGDC_GRAY_TEXT]         = 0xFFA0A0C0  -- 浅灰蓝（禁用状态文字）

-- 交互元素高亮（突出玩家操作）
d.type_61[code.EGDC_HIGH_LIGHT_TEXT]   = 0xFFFFF200  -- 荧光黄（重要文本）
d.type_61[code.EGDC_HIGH_LIGHT]        = 0xAA00C8FF  -- 半透明亮蓝（选中项背景）

-- 窗口/边框（清晰分层）
d.type_61[code.EGDC_ACTIVE_BORDER]     = 0xFFFF6B00  -- 橙色边框（活动窗口）
d.type_61[code.EGDC_ACTIVE_CAPTION]    = 0xFFFFF200  -- 荧光黄标题（替代原白色）
d.type_61[code.EGDC_INACTIVE_BORDER]   = 0x803D3D5E  -- 半透明灰紫（非活动窗口）
d.type_61[code.EGDC_INACTIVE_CAPTION]  = 0xFFC0C0E0  -- 浅灰紫文本

-- 辅助功能（工具提示/滚动条）
d.type_61[code.EGDC_TOOLTIP]           = 0xFFF0F0FF  -- 浅蓝白提示文字
d.type_61[code.EGDC_TOOLTIP_BACKGROUND]= 0xDD0A0A1E  -- 深紫黑半透明背景
d.type_61[code.EGDC_SCROLLBAR]         = 0xB300E0FF  -- 赛博蓝滚动条（半透明）

-- 输入控件（动态反馈）
d.type_61[code.EGDC_EDITABLE]          = 0xFF2A2A4A  -- 深蓝紫输入框
d.type_61[code.EGDC_GRAY_EDITABLE]     = 0xFF30304D  -- 禁用态输入框
d.type_61[code.EGDC_FOCUSED_EDITABLE]  = 0xFF3D3D7E  -- 聚焦时变亮紫

-- 图标/符号（增强识别度）
d.type_61[code.EGDC_ICON]              = 0xFFFFB347  -- 橙黄图标
d.type_61[code.EGDC_ICON_HIGH_LIGHT]   = 0xFFFF00A6  -- 粉红高亮（悬停时）
d.type_61[code.EGDC_WINDOW_SYMBOL]     = 0xFFFFF200  -- 荧光黄复选框
d.type_61[code.EGDC_GRAY_WINDOW_SYMBOL]= 0xFF8080A0  -- 灰化符号
d.type_61[code.EGDC_WINDOW]            = 0xFF2A2A3A  -- 深色窗口背景

d.type_62 = {}  
-- 天与地的统治色  
d.type_62[code.EGDC_3D_DARK_SHADOW]    = 0xFF1A001A  -- 深渊黑（阴影也要有帝王血脉）  
d.type_62[code.EGDC_3D_SHADOW]         = 0xFF4B0082  -- 暗夜紫（权柄的底色）  
d.type_62[code.EGDC_3D_FACE]           = 0xFF8A2BE2  -- 皇家紫（龙袍主色）  
d.type_62[code.EGDC_3D_HIGH_LIGHT]     = 0xFFFFD700  -- 鎏金高光（天授神权）  

-- 万界臣服的视觉暴力  
d.type_62[code.EGDC_APP_WORKSPACE]     = 0xFF000000  -- 绝对黑（虚空背景）  
d.type_62[code.EGDC_BUTTON_TEXT]       = 0xFFFFF8DC  -- 圣旨白（凡人岂配直视？）  
d.type_62[code.EGDC_HIGH_LIGHT]        = 0xAAFF4500  -- 赤金（警告色：触怒天威的下场）  

-- 天规戒律的具象化  
d.type_62[code.EGDC_ACTIVE_BORDER]     = 0xFFFF0000  -- 朱砂红（禁忌之线）  
d.type_62[code.EGDC_ACTIVE_CAPTION]    = 0xFFFFFF00  -- 天罚黄（违逆者的标记）  
d.type_62[code.EGDC_WINDOW]            = 0xFF2E0854  -- 九幽紫（窗口即封印）  

-- 连空气都要服从的设计  
d.type_62[code.EGDC_TOOLTIP]           = 0xFFE6E6FA  -- 仙气银（天道启示）  
d.type_62[code.EGDC_TOOLTIP_BACKGROUND]= 0xDD000033  -- 夜穹半透明（天机不可全露）  
d.type_62[code.EGDC_ICON_HIGH_LIGHT]   = 0xFFFF00FF  -- 紫微星闪（帝星所指，众生跪拜）  


d.type_63 = {}  
-- **基础色组（低对比但富有层次）**  
d.type_63[code.EGDC_3D_DARK_SHADOW]    = 0xFFD8E1E8  -- 晨雾灰（最浅阴影，几乎融入背景）  
d.type_63[code.EGDC_3D_SHADOW]         = 0xFFB7C4D1  -- 云影灰（柔和过渡）  
d.type_63[code.EGDC_3D_FACE]           = 0xFFF5F9FC  -- 雪原白（主背景，98%白+2%蓝调）  
d.type_63[code.EGDC_3D_HIGH_LIGHT]     = 0xFFE1EBF2  -- 冰川蓝（高光色，冷而不刺眼）  

-- **文字与交互（确保可读性但不突兀）**  
d.type_63[code.EGDC_BUTTON_TEXT]       = 0xFF4A5C6A  -- 深灰蓝（如墨水晕染）  
d.type_63[code.EGDC_HIGH_LIGHT_TEXT]   = 0xFF6D8BAB  -- 湖蓝（聚焦时轻微显色）  
d.type_63[code.EGDC_GRAY_TEXT]         = 0xFFA3B1BF  -- 遗忘灰（非活跃文本）  

-- **核心洞察点（用1%的对比引导视线）**  
d.type_63[code.EGDC_HIGH_LIGHT]        = 0x557DABD8  -- 半透明水蓝（选中项，像透过玻璃的光）  
d.type_63[code.EGDC_ACTIVE_CAPTION]    = 0xFF7DABD8  -- 知更鸟蓝（唯一醒目的标题色）  
d.type_63[code.EGDC_FOCUSED_EDITABLE]  = 0xFFE8F0F7  -- 聚焦输入框（极浅蓝白渐变）  

-- **辅助元素（消除视觉噪音）**  
d.type_63[code.EGDC_TOOLTIP]           = 0xFF5C6B7A  -- 石板灰（提示文字）  
d.type_63[code.EGDC_TOOLTIP_BACKGROUND]= 0xEEF0F5F9  -- 毛玻璃背景（98%透明度）  
d.type_63[code.EGDC_ICON]              = 0xFF9AB4CC  -- 旧书页蓝（图标弱化但可辨）  


d.type_64 = {}  
-- 〖基础色组〗（模拟大地与天空）  
d.type_64[code.EGDC_3D_DARK_SHADOW]    = 0xFFC8E0C9  -- 苔藓阴影（湿润的深春绿）  
d.type_64[code.EGDC_3D_SHADOW]         = 0xFFA5D6A7  -- 新叶投影（阳光穿透感）  
d.type_64[code.EGDC_3D_FACE]           = 0xFFE8F5E9  -- 晨雾白（98%白+2%叶绿素）  
d.type_64[code.EGDC_3D_HIGH_LIGHT]     = 0xFFF1F8E9  -- 花瓣高光（带黄调的绿）  
d.type_64[code.EGDC_3D_LIGHT]          = 0xFFFFECB3  -- 蜜阳光（叶片反光点）  

-- 〖生命核心色〗（花果焦点）  
d.type_64[code.EGDC_ACTIVE_CAPTION]    = 0xFFFF6F00  -- 金盏橘（最具活力的标题）  
d.type_64[code.EGDC_HIGH_LIGHT]        = 0x4AFFB74D  -- 半透明杏黄（选中项像阳光斑点）  
d.type_64[code.EGDC_ICON]              = 0xFF8BC34A  -- 青苹果（功能图标）  
d.type_64[code.EGDC_ICON_HIGH_LIGHT]   = 0xFFFF5722  -- 石榴红（悬停爆发色）  

-- 〖水系色组〗（流动感）  
d.type_64[code.EGDC_SCROLLBAR]         = 0xFF80DEEA  -- 浅溪蓝（滚动条如水痕）  
d.type_64[code.EGDC_EDITABLE]          = 0xFFE0F7FA  -- 水光输入框（极浅蓝）  
d.type_64[code.EGDC_FOCUSED_EDITABLE]  = 0xFFB2EBF2  -- 泉眼蓝（聚焦时加深）  

-- 〖文本色系〗（从土壤到嫩芽）  
d.type_64[code.EGDC_BUTTON_TEXT]       = 0xFF33691E  -- 松针绿（主要文字）  
d.type_64[code.EGDC_HIGH_LIGHT_TEXT]   = 0xFFFFA000  -- 琥珀黄（关键信息）  
d.type_64[code.EGDC_GRAY_TEXT]         = 0xFF78909C  -- 雨季灰（辅助文字）  

-- 〖结构性色彩〗（枝干与容器）  
d.type_64[code.EGDC_APP_WORKSPACE]     = 0xFFF1F8E9  -- 叶脉背景（浅绿白）  
d.type_64[code.EGDC_WINDOW]            = 0xFFDCEDC8  -- 柳絮白（次级面板）  
d.type_64[code.EGDC_ACTIVE_BORDER]     = 0xFFAED581  -- 青柠边框（活动窗口）  
d.type_64[code.EGDC_INACTIVE_BORDER]   = 0xFFCFD8DC  -- 晨露灰（非活动边框）  

-- 〖特殊状态〗（季节变化隐喻）  
d.type_64[code.EGDC_TOOLTIP]           = 0xFF424242  -- 腐殖土黑（提示文字）  
d.type_64[code.EGDC_TOOLTIP_BACKGROUND]= 0xEEF1F8E9  -- 半透明新叶（工具提示底）  
d.type_64[code.EGDC_GRAY_EDITABLE]     = 0xFFE0E0E0  -- 蛛网灰（禁用状态）  
d.type_64[code.EGDC_WINDOW_SYMBOL]     = 0xFF689F38  -- 橡果绿（复选框）  
d.type_64[code.EGDC_GRAY_WINDOW_SYMBOL]= 0xFFBCAAA4  -- 枯枝褐（禁用符号）  


d.type_65 = {}
d.type_65[code.EGDC_3D_DARK_SHADOW] = 0xFFE0F7FA  -- 青瓷暗部（冰蓝釉色）
d.type_65[code.EGDC_3D_SHADOW] = 0xFFB2EBF2     -- 钴蓝勾勒线
d.type_65[code.EGDC_3D_FACE] = 0xFFE8F5E9      -- 瓷胎底色（汝窑暖白）
d.type_65[code.EGDC_3D_HIGH_LIGHT] = 0xFF4FC3F7 -- 青花主色（霁蓝）
d.type_65[code.EGDC_3D_LIGHT] = 0xFF80DEEA     -- 冰裂纹高光
d.type_65[code.EGDC_APP_WORKSPACE] = 0xFFF5F5F6 -- 宣纸背景
d.type_65[code.EGDC_BUTTON_TEXT] = 0xFF1565C0   -- 苏麻离青颜料色
d.type_65[code.EGDC_GRAY_TEXT] = 0xFF90A4AE    -- 墨色晕染
d.type_65[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF006064 -- 题跋深青
d.type_65[code.EGDC_HIGH_LIGHT] = 0x804FC3F7    -- 半透明青釉
d.type_65[code.EGDC_ACTIVE_BORDER] = 0xFF00838F -- 窑变青边
d.type_65[code.EGDC_ACTIVE_CAPTION] = 0xFF00796B -- 官窑题款色
d.type_65[code.EGDC_INACTIVE_BORDER] = 0x60B2DFDB
d.type_65[code.EGDC_INACTIVE_CAPTION] = 0xFF78909C
d.type_65[code.EGDC_TOOLTIP] = 0xFFE1F5FE      -- 冰片纹提示
d.type_65[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD4DB6AC
d.type_65[code.EGDC_SCROLLBAR] = 0x60B2EBF2    -- 青釉描金滚轴
d.type_65[code.EGDC_EDITABLE] = 0xFFE0F7FA     -- 瓷胎输入区
d.type_65[code.EGDC_GRAY_EDITABLE] = 0xFFCFD8DC
d.type_65[code.EGDC_FOCUSED_EDITABLE] = 0xFFB2EBF2
d.type_65[code.EGDC_ICON] = 0xFF00ACC1         -- 缠枝莲纹色
d.type_65[code.EGDC_ICON_HIGH_LIGHT] = 0xFF26C6DA
d.type_65[code.EGDC_WINDOW_SYMBOL] = 0xFF00897B -- 篆刻朱文
d.type_65[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB0BEC5
d.type_65[code.EGDC_WINDOW] = 0xFFF5F5F6       -- 澄泥底款


d.type_66 = {}
-- 晨雾层（基础光影）
d.type_66[code.EGDC_3D_DARK_SHADOW] = 0xFFF8BBD0  -- 藕荷色暗部（带10%灰调）
d.type_66[code.EGDC_3D_SHADOW] = 0xFFFFCCBC      -- 初阳投射光
d.type_66[code.EGDC_3D_FACE] = 0xFFFFF3E0       -- 生丝底色（未漂原色）
d.type_66[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFE0B2 -- 晨光第一缕（蜜糖色）

-- 空间结构
d.type_66[code.EGDC_APP_WORKSPACE] = 0xFFFBE9E7 -- 浣纱水面（带波纹质感）
d.type_66[code.EGDC_ACTIVE_BORDER] = 0xFFFFAB91 -- 染坊茜草红（焦点边界）
d.type_66[code.EGDC_INACTIVE_BORDER] = 0x30FFD180

-- 文字系统（丝绸绣线逻辑）
d.type_66[code.EGDC_BUTTON_TEXT] = 0xFFE65100   -- 柿漆色（重要按钮）
d.type_66[code.EGDC_GRAY_TEXT] = 0xFFBCAAA4     -- 旧绢褪色
d.type_66[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFF7043 -- 朱砂点染
d.type_66[code.EGDC_ACTIVE_CAPTION] = 0xFFFF8A65 -- 缂丝金线

-- 动态元素
d.type_66[code.EGDC_HIGH_LIGHT] = 0x40FFCC80    -- 半透明蚕丝效果
d.type_66[code.EGDC_SCROLLBAR] = 0x80FFB74D     -- 蜜蜡滚轴
d.type_66[code.EGDC_ICON] = 0xFFFFA000          -- 琥珀纽扣
d.type_66[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFD54F

-- 输入系统（织机逻辑）
d.type_66[code.EGDC_EDITABLE] = 0xFFFFECB3      -- 绷紧的绢面
d.type_66[code.EGDC_GRAY_EDITABLE] = 0xFFD7CCC8 -- 待染素坯
d.type_66[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFCC80

-- 装饰元素
d.type_66[code.EGDC_TOOLTIP] = 0xFF5D4037       -- 织机墨斗色
d.type_66[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDFFE0B2
d.type_66[code.EGDC_WINDOW_SYMBOL] = 0xFFFFAB40 -- 金箔点缀
d.type_66[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA1887F
d.type_66[code.EGDC_WINDOW] = 0xFFFFF8E1       -- 绷绢画框


d.type_67 = {}
-- 基础3D元素
d.type_67[code.EGDC_3D_DARK_SHADOW] = 0xFF121212   -- 更深的暗阴影（提升层次感）
d.type_67[code.EGDC_3D_SHADOW] = 0xFF2A2A2A       -- 中性灰阴影
d.type_67[code.EGDC_3D_FACE] = 0xFFF58220         -- 保留橙色主色调
d.type_67[code.EGDC_3D_HIGH_LIGHT] = 0xFF4A0D44   -- 深紫色（增强与橙色的互补对比）
d.type_67[code.EGDC_3D_LIGHT] = 0xFFFFB340        -- 更柔和的橙色高光

-- 工作区与文本
d.type_67[code.EGDC_APP_WORKSPACE] = 0xFFF5F5F5   -- 浅灰白背景（减少眩光）
d.type_67[code.EGDC_BUTTON_TEXT] = 0xFFF0F0F0     -- 柔和白色
d.type_67[code.EGDC_GRAY_TEXT] = 0xFF909090       -- 中灰色（更好的可读性）

-- 高亮元素
d.type_67[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 纯白高亮文本
d.type_67[code.EGDC_HIGH_LIGHT] = 0xBBFF8000      -- 半透明橙色（现代感高亮）

-- 窗口元素
d.type_67[code.EGDC_ACTIVE_BORDER] = 0xFFA00000   -- 深红色（降低饱和度）
d.type_67[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF  -- 纯白标题文本
d.type_67[code.EGDC_INACTIVE_BORDER] = 0xB0FFFFFF -- 半透明白色
d.type_67[code.EGDC_INACTIVE_CAPTION] = 0xFF444444-- 深灰标题

-- 工具提示
d.type_67[code.EGDC_TOOLTIP] = 0xFF333333         -- 深灰文本（提高可读性）
d.type_67[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF5E9FF -- 米白色背景（柔和对比）

-- 交互元素
d.type_67[code.EGDC_SCROLLBAR] = 0xC0F58220       -- 主色调半透明滚动条
d.type_67[code.EGDC_EDITABLE] = 0xFFF0F0F0        -- 浅灰编辑框
d.type_67[code.EGDC_GRAY_EDITABLE] = 0xFFD8D8D8   -- 禁用状态灰
d.type_67[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFCC -- 聚焦时半透明白色

-- 图标与符号
d.type_67[code.EGDC_ICON] = 0xFFFFB340            -- 柔和橙色图标
d.type_67[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF4500 -- 珊瑚红高亮
d.type_67[code.EGDC_WINDOW_SYMBOL] = 0xFF555555   -- 深灰符号（更专业）
d.type_67[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFAAAAAA

-- 窗口背景
d.type_67[code.EGDC_WINDOW] = 0xFFF8F8F8          -- 非常浅的灰白

d.type_68 = {}
d.type_68[code.EGDC_3D_DARK_SHADOW] = 0xFF4A4A48 --深灰阴影
d.type_68[code.EGDC_3D_SHADOW] = 0xFF7D7D7A --中灰阴影
d.type_68[code.EGDC_3D_FACE] = 0xFFE0D3C9 --米白背景
d.type_68[code.EGDC_3D_HIGH_LIGHT] = 0xFFB8A99A --浅卡其高亮
d.type_68[code.EGDC_3D_LIGHT] = 0xFFF5ECE4 --珍珠白
d.type_68[code.EGDC_APP_WORKSPACE] = 0xFFF9F7F5 --灰白工作区
d.type_68[code.EGDC_BUTTON_TEXT] = 0xFF5C5C5C --深灰文字
d.type_68[code.EGDC_GRAY_TEXT] = 0xFFA8A8A8 --浅灰文字
d.type_68[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF6B8E23 --橄榄绿高亮文字
d.type_68[code.EGDC_HIGH_LIGHT] = 0x55D4B483 --半透明米黄高亮背景
d.type_68[code.EGDC_ACTIVE_BORDER] = 0xFF8B7355 --棕黄激活边框
d.type_68[code.EGDC_ACTIVE_CAPTION] = 0xFF5C5C5C --深灰标题文字
d.type_68[code.EGDC_INACTIVE_BORDER] = 0x80E0D3C9 --半透明米白非激活边框
d.type_68[code.EGDC_INACTIVE_CAPTION] = 0xFFA8A8A8 --浅灰非激活标题
d.type_68[code.EGDC_TOOLTIP] = 0xFF5C5C5C --深灰提示文字
d.type_68[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF5ECE4 --珍珠白提示背景
d.type_68[code.EGDC_SCROLLBAR] = 0x88B8A99A --半透明卡其滚动条
d.type_68[code.EGDC_EDITABLE] = 0xFFF9F7F5 --灰白编辑框
d.type_68[code.EGDC_GRAY_EDITABLE] = 0xFFE5E5E5 --浅灰禁用编辑框
d.type_68[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF --纯白聚焦编辑框
d.type_68[code.EGDC_ICON] = 0xFF8B7355 --棕黄图标
d.type_68[code.EGDC_ICON_HIGH_LIGHT] = 0xFF6B8E23 --橄榄绿高亮图标
d.type_68[code.EGDC_WINDOW_SYMBOL] = 0xFF5C5C5C --深灰窗口符号
d.type_68[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA8A8A8 --浅灰窗口符号
d.type_68[code.EGDC_WINDOW] = 0xFFF9F7F5 --灰白窗口背景

d.type_69 = {}
-- 天空与阳光元素
d.type_69[code.EGDC_3D_DARK_SHADOW] = 0xFF4A90E2   -- 深海蓝（云层阴影）
d.type_69[code.EGDC_3D_SHADOW] = 0xFF7FB3FF       -- 晴空蓝（中间色调）
d.type_69[code.EGDC_3D_FACE] = 0xFFFFD166         -- 日光金（主按钮色）
d.type_69[code.EGDC_3D_HIGH_LIGHT] = 0xFFA5D8FF   -- 天光蓝（高光区）
d.type_69[code.EGDC_3D_LIGHT] = 0xFFFFF0B3        -- 阳光晕染（柔和光效）

-- 大地与植物元素
d.type_69[code.EGDC_APP_WORKSPACE] = 0xFFF0F8FF   -- 雪原白（背景色）
d.type_69[code.EGDC_BUTTON_TEXT] = 0xFF2C4D6F     -- 松针蓝（深色文本）
d.type_69[code.EGDC_GRAY_TEXT] = 0xFF8CACD9       -- 晨雾蓝（禁用文本）

-- 高亮元素（阳光焦点）
d.type_69[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF  -- 纯白（最高对比）
d.type_69[code.EGDC_HIGH_LIGHT] = 0x66FFB347      -- 琥珀光（透明高亮）

-- 窗口元素（云朵意象）
d.type_69[code.EGDC_ACTIVE_BORDER] = 0xFFF5A623   -- 金边（活动窗口）
d.type_69[code.EGDC_ACTIVE_CAPTION] = 0xFF486B8C  -- 积雨云蓝（标题文本）
d.type_69[code.EGDC_INACTIVE_BORDER] = 0x88D4EFFF -- 薄云白（非活动边框）
d.type_69[code.EGDC_INACTIVE_CAPTION] = 0xFFA8C6E8

-- 工具提示（露珠效果）
d.type_69[code.EGDC_TOOLTIP] = 0xFF3A5F8F         -- 深潭蓝（工具文本）
d.type_69[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEFDFFDD -- 晨露白（玻璃质感）

-- 交互元素（水光波动）
d.type_69[code.EGDC_SCROLLBAR] = 0xAA4A90E2       -- 半透明湖蓝
d.type_69[code.EGDC_EDITABLE] = 0xFFFFFFFF        -- 纯白编辑区
d.type_69[code.EGDC_GRAY_EDITABLE] = 0xFFE6F1FF   -- 冰面反光灰
d.type_69[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5FEFF -- 水面反光蓝

-- 图标系统（自然元素）
d.type_69[code.EGDC_ICON] = 0xFFF5A623            -- 向日葵黄
d.type_69[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE74C3C -- 浆果红
d.type_69[code.EGDC_WINDOW_SYMBOL] = 0xFF5D8EC6   -- 青金石蓝
d.type_69[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB8D8FF

-- 基础背景（雪地质感）
d.type_69[code.EGDC_WINDOW] = 0xFFF5FBFF          -- 新雪蓝白


d.type_70 = {}
-- 基础结构色（惊艳点）
d.type_70[code.EGDC_3D_DARK_SHADOW] = 0xFF1E2A4A  -- 深海蓝阴影
d.type_70[code.EGDC_3D_SHADOW] = 0xFF3A4B7A     -- 钴蓝过渡阴影
d.type_70[code.EGDC_3D_FACE] = 0xFFF0F4FF      -- 冰川白背景
d.type_70[code.EGDC_3D_HIGH_LIGHT] = 0xFFFF7D45 -- 琥珀橙高亮（视觉焦点）
d.type_70[code.EGDC_3D_LIGHT] = 0xFFAAC8FF     -- 天蓝光晕

-- 功能色（耐看层）
d.type_70[code.EGDC_APP_WORKSPACE] = 0xFFF8FAFE -- 雪青工作区
d.type_70[code.EGDC_BUTTON_TEXT] = 0xFF2C3E5A   -- 石板蓝文字
d.type_70[code.EGDC_GRAY_TEXT] = 0xFF8D9CB8     -- 雾霾蓝禁用文字
d.type_70[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 纯白高亮文字
d.type_70[code.EGDC_HIGH_LIGHT] = 0x55FF9E6B    -- 半透明蜜橙高亮背景

-- 动态反馈色（细节层次）
d.type_70[code.EGDC_ACTIVE_BORDER] = 0xFFFF7D45 -- 琥珀橙激活边框（呼应高亮）
d.type_70[code.EGDC_ACTIVE_CAPTION] = 0xFF1E2A4A -- 深海蓝标题文字
d.type_70[code.EGDC_INACTIVE_BORDER] = 0x88AAC8FF -- 半透明天蓝非激活边框
d.type_70[code.EGDC_INACTIVE_CAPTION] = 0xFF8D9CB8 -- 雾霾蓝非激活标题

-- 交互元素（精致细节）
d.type_70[code.EGDC_TOOLTIP] = 0xFFF0F4FF      -- 冰川白提示文字
d.type_70[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD1E2A4A -- 深海蓝提示背景
d.type_70[code.EGDC_SCROLLBAR] = 0xAAFF7D45    -- 琥珀橙滚动条（动态呼应）
d.type_70[code.EGDC_EDITABLE] = 0xFFFFFFFF     -- 纯白编辑框
d.type_70[code.EGDC_GRAY_EDITABLE] = 0xFFE6ECF8 -- 淡蓝灰禁用编辑框
d.type_70[code.EGDC_FOCUSED_EDITABLE] = 0xFFF0F4FF -- 冰川白聚焦编辑框

-- 图形元素（点睛之笔）
d.type_70[code.EGDC_ICON] = 0xFF5A7FC4        -- 宝石蓝图标
d.type_70[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF9E6B -- 蜜橙高亮图标
d.type_70[code.EGDC_WINDOW_SYMBOL] = 0xFF2C3E5A  -- 石板蓝窗口符号
d.type_70[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8D9CB8 -- 雾霾蓝禁用符号
d.type_70[code.EGDC_WINDOW] = 0xFFF8FAFE      -- 雪青窗口背景


d.type_71 = {}
-- 家庭基础色系（实木家具意象）
d.type_71[code.EGDC_3D_DARK_SHADOW] = 0xFF5D4037   -- 胡桃木纹（最深阴影）
d.type_71[code.EGDC_3D_SHADOW] = 0xFF8D6E63       -- 橡木棕（中间色调）
d.type_71[code.EGDC_3D_FACE] = 0xFFD7CCC8         -- 原木色（主背景）
d.type_71[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFF3E0   -- 米白麻布（高光区）
d.type_71[code.EGDC_3D_LIGHT] = 0xFFFFE0B2        -- 宣纸黄（辅助光）

-- 核心阅读区域（文房四宝意象）
d.type_71[code.EGDC_APP_WORKSPACE] = 0xFFEFEBE9   -- 宣纸白（阅读背景）
d.type_71[code.EGDC_BUTTON_TEXT] = 0xFF3E2723     -- 墨黑（最高对比文本）
d.type_71[code.EGDC_GRAY_TEXT] = 0xFFA1887F       -- 茶渍灰（次要文本）

-- 重点元素（朱砂印章意象）
d.type_71[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFD32F2F -- 朱砂红（关键文本）
d.type_71[code.EGDC_HIGH_LIGHT] = 0x33FFAB40      -- 透明橙黄（柔和标记）

-- 界面框架（窗棂结构意象）
d.type_71[code.EGDC_ACTIVE_BORDER] = 0xFFA1887F    -- 窗框棕（活动边界）
d.type_71[code.EGDC_ACTIVE_CAPTION] = 0xFF4E342E  -- 匾额深棕（标题文本）
d.type_71[code.EGDC_INACTIVE_BORDER] = 0xFFBCAAA4 -- 纱窗灰（非活动边）
d.type_71[code.EGDC_INACTIVE_CAPTION] = 0xFF8D6E63

-- 提示系统（青花瓷意象）
d.type_71[code.EGDC_TOOLTIP] = 0xFF1A237E         -- 靛青纹（提示文本）
d.type_71[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEFFFFFF -- 白瓷胎（半透底）

-- 交互控件（铜件装饰意象）
d.type_71[code.EGDC_SCROLLBAR] = 0xFFA1887F       -- 铜绿灰（滚动条）
d.type_71[code.EGDC_EDITABLE] = 0xFFFFFFFF        -- 纯白输入区
d.type_71[code.EGDC_GRAY_EDITABLE] = 0xFFEEEEEE   -- 素胚灰（禁用态）
d.type_71[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5F5F5 -- 细麻布（聚焦态）

-- 图标系统（传统色彩意象）
d.type_71[code.EGDC_ICON] = 0xFFE64A19            -- 柿红（功能图标）
d.type_71[code.EGDC_ICON_HIGH_LIGHT] = 0xFF5D4037 -- 木雕棕（激活态）
d.type_71[code.EGDC_WINDOW_SYMBOL] = 0xFF3E2723   -- 砚台黑（符号）
d.type_71[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFBCAAA4

-- 主背景（裱糊墙面意象）
d.type_71[code.EGDC_WINDOW] = 0xFFF5F5F5          -- 素墙灰白


d.type_72 = {}
-- 魔法书皮质元素（界面基底）
d.type_72[code.EGDC_3D_DARK_SHADOW] = 0xFF3A2E28   -- 古籍封边深棕
d.type_72[code.EGDC_3D_SHADOW] = 0xFF5D4B44       -- 羊皮纸卷轴暗纹
d.type_72[code.EGDC_3D_FACE] = 0xFF8B7355         -- 古铜书钉色（主按钮）
d.type_72[code.EGDC_3D_HIGH_LIGHT] = 0xFFD4C9A8   -- 魔法墨水反光
d.type_72[code.EGDC_3D_LIGHT] = 0xFFF0E6C8        -- 咒语高亮描边

-- 阅读区域（魔法书页意象）
d.type_72[code.EGDC_APP_WORKSPACE] = 0xFFF5F0DD   -- 秘银纸（抗疲劳底色）
d.type_72[code.EGDC_BUTTON_TEXT] = 0xFF2A2118     -- 龙血墨水（主文本）
d.type_72[code.EGDC_GRAY_TEXT] = 0xFF9D8B72       -- 褪色咒文（次要文本）

-- 魔法特效元素（动态高亮）
d.type_72[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFC41F3B -- 红宝石咒文（紧急提示）
d.type_72[code.EGDC_HIGH_LIGHT] = 0x55FFD700      -- 透明魔法光晕（悬浮态）

-- 界面框架（魔法结界意象）
d.type_72[code.EGDC_ACTIVE_BORDER] = 0xFF6B8E23   -- 精灵藤蔓绿（活动边）
d.type_72[code.EGDC_ACTIVE_CAPTION] = 0xFF8B5A2B  -- 狮鹫羽毛棕（标题）
d.type_72[code.EGDC_INACTIVE_BORDER] = 0xFFC0A377 -- 月光镀银边
d.type_72[code.EGDC_INACTIVE_CAPTION] = 0xFFA2947B

-- 提示系统（水晶球意象）
d.type_72[code.EGDC_TOOLTIP] = 0xFF1E3F8B         -- 预言蓝（提示文本）
d.type_72[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF8F4E5 -- 魔法雾气（毛玻璃底）

-- 交互控件（魔法装置意象）
d.type_72[code.EGDC_SCROLLBAR] = 0xFF8B7355       -- 铜质导轨
d.type_72[code.EGDC_EDITABLE] = 0xFFFFFFF8        -- 圣洁白（输入区）
d.type_72[code.EGDC_GRAY_EDITABLE] = 0xFFE8DFC8   -- 封印灰（禁用态）
d.type_72[code.EGDC_FOCUSED_EDITABLE] = 0xFFFDF9E7 -- 聚焦金光

-- 图标系统（魔法素材意象）
d.type_72[code.EGDC_ICON] = 0xFF8A2BE2           -- 紫水晶（功能图标）
d.type_72[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF8C00 -- 火焰橙（激活态）
d.type_72[code.EGDC_WINDOW_SYMBOL] = 0xFF556B2F   -- 毒蘑菇绿（符号）
d.type_72[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFC0A377

-- 主背景（古堡石墙意象）
d.type_72[code.EGDC_WINDOW] = 0xFFEDE8D5         -- 魔法羊皮纸


d.type_73 = {}

-- 暗影与边框
d.type_73[code.EGDC_3D_DARK_SHADOW] = 0xFF001122 -- 深邃的宇宙蓝，作为暗阴影
d.type_73[code.EGDC_3D_SHADOW] = 0xFF003344 -- 较浅的宇宙蓝，作为右下阴影
d.type_73[code.EGDC_ACTIVE_BORDER] = 0xFF005566 -- 活跃边框，稍亮的宇宙蓝
d.type_73[code.EGDC_INACTIVE_BORDER] = 0xFF6699AA -- 非活跃边框，带有科幻感的蓝绿色

-- 背景与高光
d.type_73[code.EGDC_3D_FACE] = 0xFFAAFFFF -- 赛尔号特色的亮蓝色，作为按钮与窗口背景
d.type_73[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFAA -- 淡黄色高光，增加活力
d.type_73[code.EGDC_3D_LIGHT] = 0xFFFFFFFF -- 白色轻阴影，增强立体感
d.type_73[code.EGDC_HIGH_LIGHT] = 0xFFDDFF00 -- 高亮项背景，鲜明的亮黄色

-- 文本颜色
d.type_73[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 黑色文本，确保高对比度
d.type_73[code.EGDC_GRAY_TEXT] = 0xFF555555 -- 灰色文本，用于次要信息
d.type_73[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000 -- 高亮项文本，保持黑色以确保可读性
d.type_73[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF -- 窗口标题文本，白色以突出
d.type_73[code.EGDC_INACTIVE_CAPTION] = 0xFF888888 -- 非活跃窗口标题文本，深灰色

-- 特殊元素
d.type_73[code.EGDC_APP_WORKSPACE] = 0xFFEEFFFF -- 应用工作区背景，淡蓝色，营造清新氛围
d.type_73[code.EGDC_TOOLTIP] = 0xFFFFFFFF -- 工具提示文本，白色以确保在任何背景下都可见
d.type_73[code.EGDC_TOOLTIP_BACKGROUND] = 0xFF003344 -- 工具提示背景，深宇宙蓝，形成鲜明对比
d.type_73[code.EGDC_SCROLLBAR] = 0xFF55AAFF -- 滚动条，赛尔号特色的亮蓝色变体
d.type_73[code.EGDC_EDITABLE] = 0xFFDDFFFF -- 普通状态编辑框，淡蓝白色，清新舒适
d.type_73[code.EGDC_GRAY_EDITABLE] = 0xFFCCCCCC -- 禁用状态编辑框，中灰色，低调不突兀
d.type_73[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFDD00 -- 激活状态编辑框，鲜明的亮黄色，吸引注意
d.type_73[code.EGDC_ICON] = 0xFF00FF00 -- 图标，亮绿色，代表生机与活力
d.type_73[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF00FF -- 高亮图标，亮紫色，突出显示
d.type_73[code.EGDC_WINDOW_SYMBOL] = 0xFFFF0000 -- 复选框文本，亮红色，醒目且易于识别
d.type_73[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF888888 -- 灰色复选框文本，用于非活跃状态
d.type_73[code.EGDC_WINDOW] = 0xFFEEFFFF -- 窗口背景，与应用工作区保持一致，营造统一感


d.type_74 = {}
d.type_74[code.EGDC_3D_DARK_SHADOW] = 0xFF0A1E3C  -- 深蓝色暗阴影，营造宇宙深邃感
d.type_74[code.EGDC_3D_SHADOW] = 0xFF1C3A6E     -- 中等蓝色阴影，用于按钮和窗口右下
d.type_74[code.EGDC_3D_FACE] = 0xFF2D5BB8      -- 主按钮和窗口背景，赛尔号标志性蓝色
d.type_74[code.EGDC_3D_HIGH_LIGHT] = 0xFF4A90E2 -- 高亮蓝色，用于下拉框和特殊元素
d.type_74[code.EGDC_3D_LIGHT] = 0xFF6BB9FF     -- 浅蓝色光效，用于边缘高光

-- 界面基础色
d.type_74[code.EGDC_APP_WORKSPACE] = 0xFF0F2B5A  -- 深蓝背景，宇宙感
d.type_74[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF    -- 白色按钮文字，高对比度
d.type_74[code.EGDC_GRAY_TEXT] = 0xFFA7C4E8     -- 浅灰蓝色非活动文本
d.type_74[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFF -- 高亮白色文本
d.type_74[code.EGDC_HIGH_LIGHT] = 0xAA4A90E2    -- 半透明高亮蓝背景

-- 窗口元素
d.type_74[code.EGDC_ACTIVE_BORDER] = 0xFFF5D742 -- 金色活动边框，象征能量
d.type_74[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFF  -- 白色活动标题文字
d.type_74[code.EGDC_INACTIVE_BORDER] = 0x801C3A6E -- 半透明非活动边框
d.type_74[code.EGDC_INACTIVE_CAPTION] = 0xFFA7C4E8 -- 浅蓝非活动标题

-- 辅助元素
d.type_74[code.EGDC_TOOLTIP] = 0xFFF5D742      -- 金色工具提示文字
d.type_74[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD0A1E3C -- 深蓝工具提示背景
d.type_74[code.EGDC_SCROLLBAR] = 0x804A90E2    -- 半透明蓝色滚动条

-- 编辑框状态
d.type_74[code.EGDC_EDITABLE] = 0xFF1C3A6E     -- 普通编辑框
d.type_74[code.EGDC_GRAY_EDITABLE] = 0xFF3A4D6C -- 禁用状态编辑框
d.type_74[code.EGDC_FOCUSED_EDITABLE] = 0xFF4A90E2 -- 聚焦编辑框

-- 图标与符号
d.type_74[code.EGDC_ICON] = 0xFFF5D742         -- 金色图标，象征能量
d.type_74[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6B00 -- 橙色高亮图标，警告/重要
d.type_74[code.EGDC_WINDOW_SYMBOL] = 0xFFF5D742 -- 金色复选框符号
d.type_74[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA7C4E8 -- 浅蓝非活动符号
d.type_74[code.EGDC_WINDOW] = 0xFF0F2B5A       -- 窗口背景深蓝色


d.type_75 = {}
d.type_75[code.EGDC_3D_DARK_SHADOW] = 0xFF1A0C33  -- 深紫黑色暗影，象征通灵界的深邃  
d.type_75[code.EGDC_3D_SHADOW] = 0xFF3A1F5C      -- 紫黑色阴影，增强立体感  
d.type_75[code.EGDC_3D_FACE] = 0xFF5A2D8C        -- 主按钮与窗口背景，通灵紫  
d.type_75[code.EGDC_3D_HIGH_LIGHT] = 0xFF8A4FBF  -- 高亮紫，用于下拉框和特殊元素  
d.type_75[code.EGDC_3D_LIGHT] = 0xFFB87CE6       -- 灵光紫，边缘高光  

-- **基础界面色**  
d.type_75[code.EGDC_APP_WORKSPACE] = 0xFF0F0522  -- 深黑紫背景，通灵界的黑暗氛围  
d.type_75[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF     -- 纯白文字，清晰可读  
d.type_75[code.EGDC_GRAY_TEXT] = 0xFFA08FC7      -- 灰紫色非活动文本  
d.type_75[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFD700 -- 金色高亮文本，象征通灵之力  
d.type_75[code.EGDC_HIGH_LIGHT] = 0xAA8A4FBF     -- 半透明高亮紫，增强交互感  

-- **窗口元素**  
d.type_75[code.EGDC_ACTIVE_BORDER] = 0xFFFFD700  -- 金色活动边框，象征通灵能量  
d.type_75[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF -- 白色活动标题文字  
d.type_75[code.EGDC_INACTIVE_BORDER] = 0x803A1F5C -- 半透明非活动边框  
d.type_75[code.EGDC_INACTIVE_CAPTION] = 0xFFA08FC7 -- 灰紫色非活动标题  

-- **辅助元素**  
d.type_75[code.EGDC_TOOLTIP] = 0xFFFFD700        -- 金色工具提示文字，增强神秘感  
d.type_75[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD1A0C33 -- 深紫黑工具提示背景  
d.type_75[code.EGDC_SCROLLBAR] = 0x808A4FBF      -- 半透明紫色滚动条  

-- **编辑框状态**  
d.type_75[code.EGDC_EDITABLE] = 0xFF3A1F5C      -- 普通编辑框  
d.type_75[code.EGDC_GRAY_EDITABLE] = 0xFF4A3A6C  -- 禁用状态编辑框  
d.type_75[code.EGDC_FOCUSED_EDITABLE] = 0xFF8A4FBF -- 聚焦编辑框  

-- **图标与符号**  
d.type_75[code.EGDC_ICON] = 0xFFFFD700          -- 金色图标，象征通灵术式  
d.type_75[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6B00 -- 橙金色高亮，强调重要元素  
d.type_75[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700  -- 金色复选框符号  
d.type_75[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA08FC7 -- 灰紫色非活动符号  
d.type_75[code.EGDC_WINDOW] = 0xFF0F0522        -- 窗口背景深黑紫  


d.type_76 = {}
d.type_76[code.EGDC_3D_DARK_SHADOW] = 0x20D4D4FF  -- 极浅蓝灰阴影，如玻璃边缘折射
d.type_76[code.EGDC_3D_SHADOW] = 0x50E6E6FF      -- 半透明白蓝阴影，柔和立体感
d.type_76[code.EGDC_3D_FACE] = 0x88FFFFFF        -- 主按钮背景（半透明白，磨砂玻璃质感）
d.type_76[code.EGDC_3D_HIGH_LIGHT] = 0xAA00D4FF  -- 高亮霓虹蓝，用于动态焦点
d.type_76[code.EGDC_3D_LIGHT] = 0xC0FFFFFF       -- 强光白，边缘辉光效果

-- 基础界面
d.type_76[code.EGDC_APP_WORKSPACE] = 0xFFF0F5FF  -- 极浅蓝白背景（雪原反光感）
d.type_76[code.EGDC_BUTTON_TEXT] = 0xFF0066CC    -- 深晶蓝文字，高可读性
d.type_76[code.EGDC_GRAY_TEXT] = 0xFF88AACC      -- 雾霾蓝非活跃文字
d.type_76[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFF00FF -- 品红高亮文字（炫光点缀）
d.type_76[code.EGDC_HIGH_LIGHT] = 0x4000FFFF     -- 半透明霓虹蓝高亮区

-- 窗口元素
d.type_76[code.EGDC_ACTIVE_BORDER] = 0xFF00B4FF  -- 活性边框（电离蓝）
d.type_76[code.EGDC_ACTIVE_CAPTION] = 0xFF0099FF -- 动态标题蓝
d.type_76[code.EGDC_INACTIVE_BORDER] = 0x30AAAAFF -- 冰冻蓝非活动边框
d.type_76[code.EGDC_INACTIVE_CAPTION] = 0xFF88CCEE -- 浅冰蓝非活动标题

-- 辅助元素
d.type_76[code.EGDC_TOOLTIP] = 0xFF6600CC        -- 紫晶工具提示文字
d.type_76[code.EGDC_TOOLTIP_BACKGROUND] = 0xE0F5FFFF -- 半透明白玻璃背景
d.type_76[code.EGDC_SCROLLBAR] = 0x8000D4FF      -- 霓虹蓝滚动条

-- 输入控件
d.type_76[code.EGDC_EDITABLE] = 0xA0FFFFFF       -- 磨砂玻璃输入框
d.type_76[code.EGDC_GRAY_EDITABLE] = 0x60DDEEFF  -- 结霜玻璃禁用状态
d.type_76[code.EGDC_FOCUSED_EDITABLE] = 0xB000FFFF -- 聚焦时霓虹紫光晕

-- 装饰元素
d.type_76[code.EGDC_ICON] = 0xFFFF00AA           -- 品红水晶图标
d.type_76[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6600 -- 橙红高亮图标（警告色）
d.type_76[code.EGDC_WINDOW_SYMBOL] = 0xFF00AAFF  -- 电离蓝复选框
d.type_76[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFAADDEE -- 霜化符号
d.type_76[code.EGDC_WINDOW] = 0xFFE6F7FF         -- 极浅蓝白窗口背景


d.type_77 = {}

-- 基础背景与阴影
d.type_77[code.EGDC_APP_WORKSPACE] = 0xFFE0F7FA -- 浅天蓝色背景，清新明亮
d.type_77[code.EGDC_3D_DARK_SHADOW] = 0xFF4A5A64 -- 深灰色阴影，增加层次感
d.type_77[code.EGDC_3D_SHADOW] = 0xFF6C7E8A -- 中灰色阴影，过渡自然

-- 按钮与窗口背景
d.type_77[code.EGDC_3D_FACE] = 0xFFEAF5FF -- 浅蓝白色，作为按钮与窗口背景
d.type_77[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF -- 白色高光，提升亮度
d.type_77[code.EGDC_3D_LIGHT] = 0xFFEAF5FF -- 与背景相同，形成平滑过渡

-- 文本颜色
d.type_77[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 黑色文本，确保高对比度与阅读感
d.type_77[code.EGDC_GRAY_TEXT] = 0xFF6C7E8A -- 中灰色文本，用于次要信息或禁用状态
d.type_77[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000 -- 高亮项文本，保持黑色以确保可读性

-- 标题与边框
d.type_77[code.EGDC_ACTIVE_BORDER] = 0xFF1E90FF -- 亮蓝色边框，活跃状态
d.type_77[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF -- 白色标题文本，清晰醒目
d.type_77[code.EGDC_INACTIVE_BORDER] = 0xFFA9A9A9 -- 灰色边框，非活跃状态
d.type_77[code.EGDC_INACTIVE_CAPTION] = 0xFF6C7E8A -- 中灰色标题文本，低调不突兀

-- 特殊元素
d.type_77[code.EGDC_TOOLTIP] = 0xFF000000 -- 工具提示文本，黑色以确保在任何背景下都可见
d.type_77[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFEAF5FF -- 工具提示背景，与按钮背景相同，保持统一感
d.type_77[code.EGDC_SCROLLBAR] = 0xFF87CEEB -- 浅蓝色滚动条，与整体色调和谐
d.type_77[code.EGDC_EDITABLE] = 0xFFEAF5FF -- 普通状态编辑框，与背景一致，简洁明了
d.type_77[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 -- 禁用状态编辑框，中灰色，低调处理
d.type_77[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFD700 -- 激活状态编辑框，亮黄色，吸引注意

-- 图标与符号
d.type_77[code.EGDC_ICON] = 0xFF006400 -- 亮绿色图标，代表生机与活力
d.type_77[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF69B4 -- 高亮图标，亮粉色，突出显示
d.type_77[code.EGDC_WINDOW_SYMBOL] = 0xFFFF0000 -- 窗口符号，亮红色，醒目且易于识别
d.type_77[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA9A9A9 -- 灰色窗口符号，用于非活跃状态

-- 高亮与特殊背景
d.type_77[code.EGDC_HIGH_LIGHT] = 0xFFFFD700 -- 高亮项背景，亮黄色，与激活编辑框相呼应
d.type_77[code.EGDC_WINDOW] = 0xFFE0F7FA -- 窗口背景，与整体色调保持一致，营造统一氛围


d.type_78 = {}
d.type_78[code.EGDC_3D_DARK_SHADOW] = 0x15E0D8C0  -- 浅檀木阴影（叶王的和服衣褶色）
d.type_78[code.EGDC_3D_SHADOW] = 0x30EEE0B0      -- 宣纸投影色（柔和立体感）
d.type_78[code.EGDC_3D_FACE] = 0x88FFF9E6        -- 主按钮色（巫女服米白半透明）
d.type_78[code.EGDC_3D_HIGH_LIGHT] = 0x55C27DED  -- 式神紫高光（叶王灵视瞳色）
d.type_78[code.EGDC_3D_LIGHT] = 0xA0FFFFF0       -- 灵光白（超占事略决发动特效）

-- 基础界面
d.type_78[code.EGDC_APP_WORKSPACE] = 0xFFFDF5E6  -- 卷轴底色（带有古纸纹理感的暖白）
d.type_78[code.EGDC_BUTTON_TEXT] = 0xFF6B4C2A    -- 墨茶色文字（叶王发色演变）
d.type_78[code.EGDC_GRAY_TEXT] = 0xFFB5A589      -- 褪色古书文字（非活跃状态）
d.type_78[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF9C27B0 -- 通灵紫高亮文字（巫力涌动）
d.type_78[code.EGDC_HIGH_LIGHT] = 0x22F4D03F     -- 金色灵光（持有灵微光）

-- 窗口元素
d.type_78[code.EGDC_ACTIVE_BORDER] = 0xFFF4D03F  -- 活性金边（叶王耳环色）
d.type_78[code.EGDC_ACTIVE_CAPTION] = 0xFF8B4513 -- 红木色标题（神社鸟居色）
d.type_78[code.EGDC_INACTIVE_BORDER] = 0x15D7B89E -- 青苔绿非活动边（式神残留灵气）
d.type_78[code.EGDC_INACTIVE_CAPTION] = 0xFFCDAB7D -- 古铜色非活动标题

-- 辅助元素
d.type_78[code.EGDC_TOOLTIP] = 0xFF5E35B1       -- 深紫工具提示（式神契约文字色）
d.type_78[code.EGDC_TOOLTIP_BACKGROUND] = 0xD8FFF3E0 -- 灵视白绿背景（叶王灵视视角）
d.type_78[code.EGDC_SCROLLBAR] = 0x40F4D03F     -- 金色滚动条（灵魂流动意象）

-- 输入控件
d.type_78[code.EGDC_EDITABLE] = 0xA0FFFFFF       -- 半透白输入框（通灵镜面）
d.type_78[code.EGDC_GRAY_EDITABLE] = 0x60E3D9C6  -- 封魔结界灰（被封印状态）
d.type_78[code.EGDC_FOCUSED_EDITABLE] = 0x55C27DED -- 紫光输入框（灵视激活）

-- 通灵元素
d.type_78[code.EGDC_ICON] = 0xFFF4D03F          -- 金色图标（叶王耳环/灵珠）
d.type_78[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE53935 -- 赤红高亮（火灵之色）
d.type_78[code.EGDC_WINDOW_SYMBOL] = 0xFF8E24AA  -- 巫力紫复选框
d.type_78[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFBCAAA4 -- 灰结界符号
d.type_78[code.EGDC_WINDOW] = 0xFFF5EFDB        -- 阴阳术纸色窗口

d.type_79 = {}
d.type_79[code.EGDC_3D_DARK_SHADOW] = 0x206F8CB2  -- 雪松阴影（雪原树木的深蓝投影）
d.type_79[code.EGDC_3D_SHADOW] = 0x4095B8D6      -- 冰湖反光色（柔和立体感）
d.type_79[code.EGDC_3D_FACE] = 0x88D4E6FF        -- 主按钮色（轰隆轰隆毛皮斗篷的浅蓝白）
d.type_79[code.EGDC_3D_HIGH_LIGHT] = 0x55E74C3C  -- 图腾红色高光（萨满彩绘色）
d.type_79[code.EGDC_3D_LIGHT] = 0xA0ECF0F1      -- 极地雪光（超灵体发动时的冷白光）

-- 基础界面
d.type_79[code.EGDC_APP_WORKSPACE] = 0xFFE6F7FF  -- 雪原天空色（带蓝调的极地白）
d.type_79[code.EGDC_BUTTON_TEXT] = 0xFF2C3E50    -- 深靛青文字（驯鹿皮绳染色）
d.type_79[code.EGDC_GRAY_TEXT] = 0xFF95A5A6     -- 灰雪色非活跃文字
d.type_79[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFE74C3C -- 朱砂红高亮文字（巫力爆发色）
d.type_79[code.EGDC_HIGH_LIGHT] = 0x223498DB     -- 北极光蓝高亮（灵体微光）

-- 窗口元素
d.type_79[code.EGDC_ACTIVE_BORDER] = 0xFFE74C3C  -- 活性红边（图腾雕刻色）
d.type_79[code.EGDC_ACTIVE_CAPTION] = 0xFF8E44AD -- 紫莓色标题（萨满灵药色）
d.type_79[code.EGDC_INACTIVE_BORDER] = 0x206D9DBC -- 冻湖蓝非活动边
d.type_79[code.EGDC_INACTIVE_CAPTION] = 0xFF7F8C8D -- 雪云灰非活动标题

-- 辅助元素
d.type_79[code.EGDC_TOOLTIP] = 0xFFC0392B       -- 深红工具提示（血符文字色）
d.type_79[code.EGDC_TOOLTIP_BACKGROUND] = 0xD8ECF0F1 -- 雪雾背景（极地雾气）
d.type_79[code.EGDC_SCROLLBAR] = 0x40E74C3C     -- 朱砂红滚动条（巫力流动）

-- 输入控件
d.type_79[code.EGDC_EDITABLE] = 0xA0FFFFFF       -- 雪堆白输入框
d.type_79[code.EGDC_GRAY_EDITABLE] = 0x60BDC3C7  -- 冰封状态（灰蓝调）
d.type_79[code.EGDC_FOCUSED_EDITABLE] = 0x553498DB -- 极光蓝输入框（灵视激活）

-- 萨满元素
d.type_79[code.EGDC_ICON] = 0xFFE74C3C          -- 朱砂红图标（图腾标记）
d.type_79[code.EGDC_ICON_HIGH_LIGHT] = 0xFFF39C12 -- 琥珀黄高亮（篝火之色）
d.type_79[code.EGDC_WINDOW_SYMBOL] = 0xFF3498DB  -- 极光蓝复选框
d.type_79[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFAAB7B8 -- 灰雪符号
d.type_79[code.EGDC_WINDOW] = 0xFFDFEBED        -- 驯鹿皮色窗口


d.type_80 = {}

-- 基础背景色
d.type_80[code.EGDC_APP_WORKSPACE] = 0xFFF5F9FA -- 浅米白色背景，温馨而纯净

-- 阴影与深度
d.type_80[code.EGDC_3D_DARK_SHADOW] = 0xFFD3D3D3 -- 浅灰色阴影，增加细微层次感
d.type_80[code.EGDC_3D_SHADOW] = 0xFFE0E0E0 -- 更浅的灰色阴影，过渡自然

-- 按钮与窗口背景
d.type_80[code.EGDC_3D_FACE] = 0xFFFFFFFF -- 白色背景，干净利落
d.type_80[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF -- 白色高光，保持简洁
d.type_80[code.EGDC_3D_LIGHT] = 0xFFFEFEFE -- 近乎白色，营造平滑过渡效果

-- 文本颜色
d.type_80[code.EGDC_BUTTON_TEXT] = 0xFF000000 -- 黑色文本，确保高对比度和清晰的阅读感
d.type_80[code.EGDC_GRAY_TEXT] = 0xFF888888 -- 浅灰色文本，用于次要信息，保持柔和
d.type_80[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000 -- 高亮文本保持黑色，确保在任何背景下都易读

-- 边框与标题
d.type_80[code.EGDC_ACTIVE_BORDER] = 0xFF4CAF50 -- 鲜绿色边框，象征活力与成长
d.type_80[code.EGDC_ACTIVE_CAPTION] = 0xFF000000 -- 黑色标题文本，与背景形成对比，易于阅读
d.type_80[code.EGDC_INACTIVE_BORDER] = 0xFFCCCCCC -- 浅灰色边框，非活跃状态，保持低调
d.type_80[code.EGDC_INACTIVE_CAPTION] = 0xFF888888 -- 浅灰色标题文本，非活跃状态下保持柔和

-- 特殊元素与工具提示
d.type_80[code.EGDC_TOOLTIP] = 0xFF000000 -- 工具提示文本为黑色，确保清晰可读
d.type_80[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFF0F8FF -- 浅天蓝色背景，为工具提示增加一丝清新
d.type_80[code.EGDC_SCROLLBAR] = 0xFFD3D3D3 -- 浅灰色滚动条，与整体色调和谐统一

-- 编辑框与激活状态
d.type_80[code.EGDC_EDITABLE] = 0xFFFEFEFE -- 近乎白色编辑框，简洁而明亮
d.type_80[code.EGDC_GRAY_EDITABLE] = 0xFFE0E0E0 -- 禁用状态编辑框，浅灰色，低调不突兀
d.type_80[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFD700 -- 激活状态编辑框，亮黄色，吸引注意且不失温馨

-- 图标与符号
d.type_80[code.EGDC_ICON] = 0xFF00796B -- 亮绿色图标，象征生机与纯真
d.type_80[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFA07A -- 粉色高亮图标，增加活泼感
d.type_80[code.EGDC_WINDOW_SYMBOL] = 0xFF4CAF50 -- 窗口符号与活跃边框同色，保持统一
d.type_80[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFCCCCCC -- 灰色窗口符号，用于非活跃状态，保持低调和谐

-- 高亮背景
d.type_80[code.EGDC_HIGH_LIGHT] = 0xFFFFD700 -- 高亮项背景，亮黄色，与激活编辑框相呼应，营造温馨氛围

-- 窗口背景
d.type_80[code.EGDC_WINDOW] = 0xFFF5F9FA -- 窗口背景与整体色调保持一致，营造统一而温馨的氛围

d.type_81 = {}
d.type_81[code.EGDC_3D_DARK_SHADOW] = 0xFF2D3747    -- 深蓝灰色阴影，提供温和的深度感
d.type_81[code.EGDC_3D_SHADOW] = 0xFF4A5568        -- 中等蓝灰色阴影，层次过渡自然
d.type_81[code.EGDC_3D_FACE] = 0xFFEDF2F7         -- 极浅灰蓝色背景，柔和护眼
d.type_81[code.EGDC_3D_HIGH_LIGHT] = 0xFFE2E8F0   -- 浅灰蓝色高亮，舒适对比
d.type_81[code.EGDC_3D_LIGHT] = 0xFFCBD5E0        -- 中灰蓝色光线效果

d.type_81[code.EGDC_APP_WORKSPACE] = 0xFFF8FAFC   -- 极浅背景色，减少视觉疲劳
d.type_81[code.EGDC_BUTTON_TEXT] = 0xFF2D3747     -- 深蓝灰色文本，清晰易读
d.type_81[code.EGDC_GRAY_TEXT] = 0xFF718096      -- 中灰蓝色禁用文本，柔和但可辨
d.type_81[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF4299E1 -- 明亮蓝色高亮文本，重点突出
d.type_81[code.EGDC_HIGH_LIGHT] = 0xFFEBF8FF     -- 极浅蓝色高亮背景，舒适醒目

d.type_81[code.EGDC_ACTIVE_BORDER] = 0xFF4299E1  -- 活跃边框使用主题蓝色
d.type_81[code.EGDC_ACTIVE_CAPTION] = 0xFF2D3747 -- 深色标题文本，专业稳重
d.type_81[code.EGDC_INACTIVE_BORDER] = 0xFFCBD5E0 -- 非活跃边框使用中性色
d.type_81[code.EGDC_INACTIVE_CAPTION] = 0xFF718096 -- 非活跃标题文本较浅

d.type_81[code.EGDC_TOOLTIP] = 0xFF2D3747        -- 工具提示使用深色文本
d.type_81[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFEDF2F7 -- 浅色工具提示背景

d.type_81[code.EGDC_SCROLLBAR] = 0xFFCBD5E0      -- 滚动条使用中性色
d.type_81[code.EGDC_EDITABLE] = 0xFFFFFFFF       -- 白色编辑框，标准易读
d.type_81[code.EGDC_GRAY_EDITABLE] = 0xFFEDF2F7  -- 浅灰禁用编辑框
d.type_81[code.EGDC_FOCUSED_EDITABLE] = 0xFFEBF8FF -- 聚焦编辑框浅蓝色背景

d.type_81[code.EGDC_ICON] = 0xFF4299E1           -- 图标使用主题蓝色
d.type_81[code.EGDC_ICON_HIGH_LIGHT] = 0xFF3182CE -- 高亮图标使用深蓝色
d.type_81[code.EGDC_WINDOW_SYMBOL] = 0xFF2D3747  -- 窗口符号深色
d.type_81[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0AEC0 -- 灰色窗口符号
d.type_81[code.EGDC_WINDOW] = 0xFFF8FAFC         -- 窗口背景极浅色


d.type_82 = {}
-- 基础3D元素
d.type_82[code.EGDC_3D_DARK_SHADOW] = 0xFFD1D5DB    -- 柔和的浅灰色阴影
d.type_82[code.EGDC_3D_SHADOW] = 0xFFE5E7EB       -- 更浅的阴影层
d.type_82[code.EGDC_3D_FACE] = 0xFFFFFFFF         -- 纯白按钮/窗口背景
d.type_82[code.EGDC_3D_HIGH_LIGHT] = 0xFFF3F4F6   -- 极浅灰高光
d.type_82[code.EGDC_3D_LIGHT] = 0xFFF9FAFB        -- 几乎白色的光线效果

-- 应用基础色
d.type_82[code.EGDC_APP_WORKSPACE] = 0xFFF9FAFB   -- 非常浅的背景色
d.type_82[code.EGDC_BUTTON_TEXT] = 0xFF111827     -- 深灰蓝文字，不刺眼
d.type_82[code.EGDC_GRAY_TEXT] = 0xFF9CA3AF      -- 中性灰禁用文字
d.type_82[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF2563EB -- 悦目的蓝色高亮文字
d.type_82[code.EGDC_HIGH_LIGHT] = 0xFFDBEAFE     -- 淡蓝色高亮背景

-- 窗口元素
d.type_82[code.EGDC_ACTIVE_BORDER] = 0xFF2563EB  -- 活跃边框用主题蓝
d.type_82[code.EGDC_ACTIVE_CAPTION] = 0xFF111827 -- 深色标题文字
d.type_82[code.EGDC_INACTIVE_BORDER] = 0xFFE5E7EB -- 非活跃边框浅灰
d.type_82[code.EGDC_INACTIVE_CAPTION] = 0xFF6B7280 -- 非活跃标题中灰

-- 辅助元素
d.type_82[code.EGDC_TOOLTIP] = 0xFF111827        -- 工具提示深色文字
d.type_82[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFFFFFFF -- 白色工具提示背景
d.type_82[code.EGDC_SCROLLBAR] = 0xFFE5E7EB      -- 浅灰滚动条

-- 编辑区域
d.type_82[code.EGDC_EDITABLE] = 0xFFFFFFFF       -- 白色编辑框
d.type_82[code.EGDC_GRAY_EDITABLE] = 0xFFF3F4F6  -- 浅灰禁用编辑框
d.type_82[code.EGDC_FOCUSED_EDITABLE] = 0xFFF0F9FF -- 聚焦时淡蓝色背景

-- 图标与符号
d.type_82[code.EGDC_ICON] = 0xFF2563EB           -- 主题蓝色图标
d.type_82[code.EGDC_ICON_HIGH_LIGHT] = 0xFF1D4ED8 -- 深蓝高亮图标
d.type_82[code.EGDC_WINDOW_SYMBOL] = 0xFF374151  -- 深灰窗口符号
d.type_82[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF9CA3AF -- 灰窗口符号
d.type_82[code.EGDC_WINDOW] = 0xFFFFFFFF         -- 纯白窗口背景


d.type_83 = {}

-- &zwnj;**基础背景与层次**&zwnj;
d.type_83[code.EGDC_APP_WORKSPACE] = 0xFFF8F9FA  -- 极浅灰白背景（减少刺眼感）
d.type_83[code.EGDC_WINDOW] = 0xFFFFFFFF        -- 纯白窗口背景（干净利落）
d.type_83[code.EGDC_3D_DARK_SHADOW] = 0xFFE0E3E6 -- 极浅阴影（增加立体感但不突兀）
d.type_83[code.EGDC_3D_SHADOW] = 0xFFECEEF1     -- 更浅的阴影（自然过渡）

-- &zwnj;**核心交互元素**&zwnj;
d.type_83[code.EGDC_3D_FACE] = 0xFFFFFFFF       -- 按钮/面板背景（纯白）
d.type_83[code.EGDC_HIGH_LIGHT] = 0xFFE3F2FD    -- 高亮背景（淡蓝色，柔和聚焦）
d.type_83[code.EGDC_ACTIVE_BORDER] = 0xFF64B5F6 -- 活跃边框（天空蓝，点睛之笔）
d.type_83[code.EGDC_FOCUSED_EDITABLE] = 0xFFE3F2FD -- 输入框聚焦（淡蓝背景）

-- &zwnj;**文字系统（关键！浅色主题的灵魂）**&zwnj;
d.type_83[code.EGDC_BUTTON_TEXT] = 0xFF424242   -- 主文字（深灰，非纯黑更柔和）
d.type_83[code.EGDC_GRAY_TEXT] = 0xFF90A4AE     -- 次要文字（灰蓝色，降低存在感）
d.type_83[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF1565C0 -- 高亮文字（深蓝色，强调用）

-- &zwnj;**点缀色（避免单调）**&zwnj;
d.type_83[code.EGDC_ICON] = 0xFF4DB6AC         -- 图标主色（薄荷绿，清新感）
d.type_83[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE91E63 -- 图标高亮（玫红，小面积提亮）
d.type_83[code.EGDC_SCROLLBAR] = 0xFFB0BEC5    -- 滚动条（浅灰蓝，低调但可见）

-- &zwnj;**特殊状态**&zwnj;
d.type_83[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFCFD8DC -- 工具提示背景（浅灰蓝）
d.type_83[code.EGDC_TOOLTIP] = 0xFF37474F       -- 工具提示文字（深灰蓝）
d.type_83[code.EGDC_GRAY_EDITABLE] = 0xFFECEFF1 -- 禁用状态（极浅灰）


d.type_84 = {}
d.type_84[code.EGDC_3D_DARK_SHADOW] = 0xFF2A0C26    -- 最深的紫色作为基础阴影
d.type_84[code.EGDC_3D_SHADOW] = 0xFF4A1845        -- 中等深度阴影
d.type_84[code.EGDC_3D_FACE] = 0xFFF58220          -- 主橙色作为按钮背景
d.type_84[code.EGDC_3D_HIGH_LIGHT] = 0xFF5A1C55    -- 深紫色作为高亮背景
d.type_84[code.EGDC_3D_LIGHT] = 0xFFFFB347         -- 亮橙色作为高亮边缘

-- 中性色和背景色
d.type_84[code.EGDC_APP_WORKSPACE] = 0xFFF5F5F5    -- 浅灰白工作区
d.type_84[code.EGDC_WINDOW] = 0xFFF0E6EE          -- 极浅紫色窗口背景

-- 文本颜色
d.type_84[code.EGDC_BUTTON_TEXT] = 0xFF2A0C26      -- 深紫色按钮文字
d.type_84[code.EGDC_GRAY_TEXT] = 0xFFA59EAC        -- 灰色禁用文本
d.type_84[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF  -- 白色高亮文本
d.type_84[code.EGDC_ACTIVE_CAPTION] = 0xFF2A0C26   -- 深紫色标题文本

-- 高亮和交互元素
d.type_84[code.EGDC_HIGH_LIGHT] = 0xAAFF8C42       -- 半透明橙色高亮背景
d.type_84[code.EGDC_ACTIVE_BORDER] = 0xFFF58220    -- 橙色活动边框
d.type_84[code.EGDC_INACTIVE_BORDER] = 0x804A1845  -- 半透明非活动边框
d.type_84[code.EGDC_INACTIVE_CAPTION] = 0x805A1C55 -- 半透明非活动标题

-- 工具提示
d.type_84[code.EGDC_TOOLTIP] = 0xFF2A0C26          -- 深紫色工具提示文本
d.type_84[code.EGDC_TOOLTIP_BACKGROUND] = 0xE6FFD699 -- 浅橙色半透明背景

-- 滚动条和编辑框
d.type_84[code.EGDC_SCROLLBAR] = 0xC0F58220        -- 半透明橙色滚动条
d.type_84[code.EGDC_EDITABLE] = 0xFFF0E6EE        -- 浅紫色编辑框
d.type_84[code.EGDC_GRAY_EDITABLE] = 0xFFE0D0DC   -- 灰化编辑框
d.type_84[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFFF -- 白色聚焦编辑框

-- 图标和符号
d.type_84[code.EGDC_ICON] = 0xFFF58220            -- 主橙色图标
d.type_84[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE6007A -- 洋红色高亮图标
d.type_84[code.EGDC_WINDOW_SYMBOL] = 0xFF5A1C55   -- 深紫色复选框
d.type_84[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFC0B8C0 -- 灰色禁用符号


-- 暗色调主题，具有层次感
d.type_85 = {}
d.type_85[code.EGDC_3D_DARK_SHADOW] = 0xFF000000 -- 按钮与窗口的暗阴影，最深的黑色
d.type_85[code.EGDC_3D_SHADOW] = 0xFF333333 -- 按钮与窗口的右下阴影，深灰色
d.type_85[code.EGDC_3D_FACE] = 0xFF404040 -- 按钮与窗口的背景，中等灰色
d.type_85[code.EGDC_3D_HIGH_LIGHT] = 0xFF666666 -- 下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项，深灰色
d.type_85[code.EGDC_3D_LIGHT] = 0xFF808080 -- 浅灰色
d.type_85[code.EGDC_APP_WORKSPACE] = 0xFF303030 -- 应用工作区，深灰色背景
d.type_85[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 按钮文本，白色
d.type_85[code.EGDC_GRAY_TEXT] = 0xFF808080 -- 灰色文本，与浅灰色接近
d.type_85[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 高亮项的文本，白色
d.type_85[code.EGDC_HIGH_LIGHT] = 0xFF5588FF -- 高亮项的背景，蓝色调，与整体暗色调形成对比
d.type_85[code.EGDC_ACTIVE_BORDER] = 0xFF4477AA -- 窗口标题在聚焦时的左边，深蓝色
d.type_85[code.EGDC_ACTIVE_CAPTION] = d.type_85[code.EGDC_HIGH_LIGHT_TEXT] -- 窗口标题的文本，白色
d.type_85[code.EGDC_INACTIVE_BORDER] = 0xFF666666 -- 非活动窗口边框，深灰色
d.type_85[code.EGDC_INACTIVE_CAPTION] = 0xFF808080 -- 非活动窗口标题，浅灰色
d.type_85[code.EGDC_TOOLTIP] = 0xFFFFFFFF -- 工具提示的文本，白色
d.type_85[code.EGDC_TOOLTIP_BACKGROUND] = 0xFF505050 -- 工具提示的背景，深灰色
d.type_85[code.EGDC_SCROLLBAR] = 0xFF505050 -- 滚动条，深灰色
d.type_85[code.EGDC_EDITABLE] = 0xFF666666 -- 普通状态的编辑框，深灰色
d.type_85[code.EGDC_GRAY_EDITABLE] = 0xFF808080 -- 禁用状态的编辑框，浅灰色
d.type_85[code.EGDC_FOCUSED_EDITABLE] = 0xFF5588FF -- 激活状态的编辑框，蓝色调
d.type_85[code.EGDC_ICON] = 0xFFFFFFFF -- 图标，白色
d.type_85[code.EGDC_ICON_HIGH_LIGHT] = 0xFF5588FF -- 图标高亮，蓝色调
d.type_85[code.EGDC_WINDOW_SYMBOL] = 0xFFFFFFFF -- 复选框的文本，白色
d.type_85[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF808080 -- 禁用的复选框文本，浅灰色
d.type_85[code.EGDC_WINDOW] = 0xFF303030 -- 窗口背景，深灰色

-- 青眼白龙主题配色
d.type_86 = {}
d.type_86[code.EGDC_3D_DARK_SHADOW] = 0xFF002A4A -- 按钮与窗口的暗阴影，深邃的海洋蓝
d.type_86[code.EGDC_3D_SHADOW] = 0xFF004A7F -- 按钮与窗口的右下阴影，深蓝色
d.type_86[code.EGDC_3D_FACE] = 0xFF006699 -- 按钮与窗口的背景，中等蓝色
d.type_86[code.EGDC_3D_HIGH_LIGHT] = 0xFF0080B3 -- 下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项，浅蓝色
d.type_86[code.EGDC_3D_LIGHT] = 0xFF0099CC -- 浅蓝色
d.type_86[code.EGDC_APP_WORKSPACE] = 0xFF003366 -- 应用工作区，深蓝色背景
d.type_86[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 按钮文本，白色
d.type_86[code.EGDC_GRAY_TEXT] = 0xFFB3C1CD -- 灰色文本，淡蓝色调
d.type_86[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 高亮项的文本，白色
d.type_86[code.EGDC_HIGH_LIGHT] = 0xFF00BFFF -- 高亮项的背景，亮蓝色
d.type_86[code.EGDC_ACTIVE_BORDER] = 0xFF005588 -- 窗口标题在聚焦时的左边，深蓝色
d.type_86[code.EGDC_ACTIVE_CAPTION] = d.type_86[code.EGDC_HIGH_LIGHT_TEXT] -- 窗口标题的文本，白色
d.type_86[code.EGDC_INACTIVE_BORDER] = 0xFF336699 -- 非活动窗口边框，中等蓝色
d.type_86[code.EGDC_INACTIVE_CAPTION] = 0xFF8099B3 -- 非活动窗口标题，浅蓝色
d.type_86[code.EGDC_TOOLTIP] = 0xFFFFFFFF -- 工具提示的文本，白色
d.type_86[code.EGDC_TOOLTIP_BACKGROUND] = 0xFF004A7F -- 工具提示的背景，深蓝色
d.type_86[code.EGDC_SCROLLBAR] = 0xFF006699 -- 滚动条，中等蓝色
d.type_86[code.EGDC_EDITABLE] = 0xFF0080B3 -- 普通状态的编辑框，浅蓝色
d.type_86[code.EGDC_GRAY_EDITABLE] = 0xFFB3C1CD -- 禁用状态的编辑框，淡蓝色调
d.type_86[code.EGDC_FOCUSED_EDITABLE] = 0xFF00BFFF -- 激活状态的编辑框，亮蓝色
d.type_86[code.EGDC_ICON] = 0xFFFFFFFF -- 图标，白色
d.type_86[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFD700 -- 图标高亮，金色
d.type_86[code.EGDC_WINDOW_SYMBOL] = 0xFFFFFFFF -- 复选框的文本，白色
d.type_86[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB3C1CD -- 禁用的复选框文本，淡蓝色调
d.type_86[code.EGDC_WINDOW] = 0xFF003366 -- 窗口背景，深蓝色


d.type_87 = {}
-- 基础色：江天青蓝（由深至浅模拟远山近水）
d.type_87[code.EGDC_3D_DARK_SHADOW]    = 0xFF1E3A5F  -- 深靛青（如远山轮廓）
d.type_87[code.EGDC_3D_SHADOW]         = 0xFF3A6EA5  -- 江面暗波
d.type_87[code.EGDC_3D_FACE]           = 0xFF5D9BEC  -- 帆布主色（中青蓝）
d.type_87[code.EGDC_3D_HIGH_LIGHT]     = 0xFF87C1FF  -- 浪尖高光
d.type_87[code.EGDC_3D_LIGHT]          = 0xFFB3E0FF  -- 天际线亮色

-- 背景色：云水渐变
d.type_87[code.EGDC_APP_WORKSPACE]     = 0xFFF0F9FF  -- 雾霭白（背景基底）
d.type_87[code.EGDC_WINDOW]            = 0xFFE6F2FF  -- 水天交界处微蓝

-- 点睛色：帆影与阳光（动态元素突出）
d.type_87[code.EGDC_BUTTON_TEXT]       = 0xFF1E3A5F  -- 深靛青文字（如墨书）
d.type_87[code.EGDC_HIGH_LIGHT]        = 0xAAFFD166  -- 帆上日光（半透明琥珀金）
d.type_87[code.EGDC_ICON]              = 0xFFFFB347  -- 船锚/按钮（暖铜色）
d.type_87[code.EGDC_ICON_HIGH_LIGHT]   = 0xFFFF7043  -- 朝阳红（悬帆投影色）

-- 交互状态：风动涟漪效果
d.type_87[code.EGDC_ACTIVE_BORDER]     = 0xFF5D9BEC  -- 帆蓝（活跃边框）
d.type_87[code.EGDC_FOCUSED_EDITABLE]  = 0xFFE1F0FF  -- 水光聚焦（编辑框泛白）
d.type_87[code.EGDC_SCROLLBAR]         = 0x805D9BEC  -- 半透明帆蓝（如缆绳掠过）

-- 文字：云中透光
d.type_87[code.EGDC_HIGH_LIGHT_TEXT]   = 0xFFFFFFFF  -- 纯白（桅顶旗色）
d.type_87[code.EGDC_GRAY_TEXT]         = 0xFFA3C1E0  -- 薄雾灰（禁用文字）
d.type_87[code.EGDC_TOOLTIP]           = 0xFF1E3A5F  -- 深靛青提示文
d.type_87[code.EGDC_TOOLTIP_BACKGROUND]= 0xEEF5FCFF  -- 云母玻璃质感背景


-- 混沌战士主题配色
d.type_88 = {}
d.type_88[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A -- 按钮与窗口的暗阴影，深黑色
d.type_88[code.EGDC_3D_SHADOW] = 0xFF333333 -- 按钮与窗口的右下阴影，深灰色
d.type_88[code.EGDC_3D_FACE] = 0xFF5A2A1F -- 按钮与窗口的背景，深棕色，带有混沌感
d.type_88[code.EGDC_3D_HIGH_LIGHT] = 0xFF8B4513 -- 下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项，棕色
d.type_88[code.EGDC_3D_LIGHT] = 0xFFCD853F -- 浅棕色
d.type_88[code.EGDC_APP_WORKSPACE] = 0xFF2F4F4F -- 应用工作区，深墨绿色背景
d.type_88[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 按钮文本，白色
d.type_88[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9 -- 灰色文本，中等灰色
d.type_88[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 高亮项的文本，白色
d.type_88[code.EGDC_HIGH_LIGHT] = 0xFF8B0000 -- 高亮项的背景，深红色，象征混沌的力量
d.type_88[code.EGDC_ACTIVE_BORDER] = 0xFF483D8B -- 窗口标题在聚焦时的左边，深紫色
d.type_88[code.EGDC_ACTIVE_CAPTION] = d.type_88[code.EGDC_HIGH_LIGHT_TEXT] -- 窗口标题的文本，白色
d.type_88[code.EGDC_INACTIVE_BORDER] = 0xFF696969 -- 非活动窗口边框，深灰色
d.type_88[code.EGDC_INACTIVE_CAPTION] = 0xFF8B0000 -- 非活动窗口标题，深红色
d.type_88[code.EGDC_TOOLTIP] = 0xFFFFFFFF -- 工具提示的文本，白色
d.type_88[code.EGDC_TOOLTIP_BACKGROUND] = 0xFF333333 -- 工具提示的背景，深灰色
d.type_88[code.EGDC_SCROLLBAR] = 0xFF5A2A1F -- 滚动条，深棕色
d.type_88[code.EGDC_EDITABLE] = 0xFF8B4513 -- 普通状态的编辑框，棕色
d.type_88[code.EGDC_GRAY_EDITABLE] = 0xFFA9A9A9 -- 禁用状态的编辑框，中等灰色
d.type_88[code.EGDC_FOCUSED_EDITABLE] = 0xFF8B0000 -- 激活状态的编辑框，深红色
d.type_88[code.EGDC_ICON] = 0xFFFFFFFF -- 图标，白色
d.type_88[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFD700 -- 图标高亮，金色，象征混沌战士的武器或装备
d.type_88[code.EGDC_WINDOW_SYMBOL] = 0xFFFFFFFF -- 复选框的文本，白色
d.type_88[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA9A9A9 -- 禁用的复选框文本，中等灰色
d.type_88[code.EGDC_WINDOW] = 0xFF2F4F4F -- 窗口背景，深墨绿色


d.type_89 = {}
d.type_89[code.EGDC_3D_DARK_SHADOW] = 0xFF1E0A3C  -- 深紫色暗影，象征迦楼罗的神秘力量
d.type_89[code.EGDC_3D_SHADOW] = 0xFF3A1E6B      -- 紫色阴影，魔法能量的暗影
d.type_89[code.EGDC_3D_FACE] = 0xFF5E43BA       -- 主色调，迦楼罗的魔法紫
d.type_89[code.EGDC_3D_HIGH_LIGHT] = 0xFF8A6DEC -- 高亮紫色，魔法能量的闪耀
d.type_89[code.EGDC_3D_LIGHT] = 0xFFB39EFF      -- 浅紫色光晕
d.type_89[code.EGDC_APP_WORKSPACE] = 0xFFF0E6FF -- 非常浅的紫色背景，柔和舒适
d.type_89[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF   -- 白色按钮文字
d.type_89[code.EGDC_GRAY_TEXT] = 0xFFA89CC8     -- 灰色文字，带有紫色调
d.type_89[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF -- 高亮白色文字
d.type_89[code.EGDC_HIGH_LIGHT] = 0xAA7D5BEB    -- 高亮紫色背景，半透明
d.type_89[code.EGDC_ACTIVE_BORDER] = 0xFF4B2C8F -- 活动边框，深紫色
d.type_89[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF -- 活动标题白色文字
d.type_89[code.EGDC_INACTIVE_BORDER] = 0xA03A1E6B -- 非活动边框，半透明紫色
d.type_89[code.EGDC_INACTIVE_CAPTION] = 0xFFB39EFF -- 非活动标题浅紫色
d.type_89[code.EGDC_TOOLTIP] = 0xFF2E1A5A       -- 工具提示深紫色文字
d.type_89[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDE6D6FF -- 工具提示浅紫色背景
d.type_89[code.EGDC_SCROLLBAR] = 0x805E43BA     -- 滚动条主色调半透明
d.type_89[code.EGDC_EDITABLE] = 0xFFE6D6FF      -- 编辑框浅紫色
d.type_89[code.EGDC_GRAY_EDITABLE] = 0xFFD0C0E8 -- 禁用状态编辑框灰紫色
d.type_89[code.EGDC_FOCUSED_EDITABLE] = 0xFFB39EFF -- 聚焦编辑框亮紫色
d.type_89[code.EGDC_ICON] = 0xFF8A6DEC         -- 图标紫色
d.type_89[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFD700 -- 图标高亮金色，象征迦楼罗的魔法光辉
d.type_89[code.EGDC_WINDOW_SYMBOL] = 0xFF4B2C8F  -- 窗口符号深紫色
d.type_89[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB39EFF -- 灰色窗口符号浅紫色
d.type_89[code.EGDC_WINDOW] = 0xFFF5F0FF        -- 窗口背景极浅紫色


d.type_90 = {}
d.type_90[code.EGDC_3D_DARK_SHADOW] = 0xFF0F2A1E       -- 深绿黑色暗影，象征外星装甲的厚重感
d.type_90[code.EGDC_3D_SHADOW] = 0xFF1C4D36           -- 墨绿色阴影，外星装甲的暗部
d.type_90[code.EGDC_3D_FACE] = 0xFF3A7D5B            -- 主色调，外星士兵的装甲绿
d.type_90[code.EGDC_3D_HIGH_LIGHT] = 0xFF5DB37E      -- 高亮荧光绿，外星科技的光效
d.type_90[code.EGDC_3D_LIGHT] = 0xFF8AFFA8           -- 浅荧光绿，能量光晕
d.type_90[code.EGDC_APP_WORKSPACE] = 0xFF0D1F16      -- 深绿黑色背景，外星基地环境
d.type_90[code.EGDC_BUTTON_TEXT] = 0xFFE0FFE8        -- 浅绿色按钮文字
d.type_90[code.EGDC_GRAY_TEXT] = 0xFF5D8973         -- 灰色文字，带有绿色调
d.type_90[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF    -- 高亮白色文字
d.type_90[code.EGDC_HIGH_LIGHT] = 0xAA5DB37E        -- 高亮荧光绿背景，半透明
d.type_90[code.EGDC_ACTIVE_BORDER] = 0xFF2D6B4F     -- 活动边框，深荧光绿
d.type_90[code.EGDC_ACTIVE_CAPTION] = 0xFF8AFFA8    -- 活动标题荧光绿文字
d.type_90[code.EGDC_INACTIVE_BORDER] = 0xA01C4D36   -- 非活动边框，半透明墨绿
d.type_90[code.EGDC_INACTIVE_CAPTION] = 0xFF3A7D5B  -- 非活动标题装甲绿
d.type_90[code.EGDC_TOOLTIP] = 0xFFE0FFE8           -- 工具提示浅绿色文字
d.type_90[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD0F2A1E -- 工具提示深绿黑背景
d.type_90[code.EGDC_SCROLLBAR] = 0x803A7D5B         -- 滚动条主色调半透明
d.type_90[code.EGDC_EDITABLE] = 0xFF1C4D36          -- 编辑框墨绿色
d.type_90[code.EGDC_GRAY_EDITABLE] = 0xFF2D6B4F     -- 禁用状态编辑框深绿
d.type_90[code.EGDC_FOCUSED_EDITABLE] = 0xFF5DB37E  -- 聚焦编辑框荧光绿
d.type_90[code.EGDC_ICON] = 0xFF5DB37E              -- 图标荧光绿
d.type_90[code.EGDC_ICON_HIGH_LIGHT] = 0xFF8AFFA8   -- 图标高亮荧光绿
d.type_90[code.EGDC_WINDOW_SYMBOL] = 0xFF8AFFA8     -- 窗口符号亮荧光绿
d.type_90[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF3A7D5B -- 灰色窗口符号装甲绿
d.type_90[code.EGDC_WINDOW] = 0xFF142E22            -- 窗口背景深绿黑

d.type_91 = {}
d.type_91[code.EGDC_3D_DARK_SHADOW] = 0xFFD6D6D6  -- 柔和的浅灰色边框阴影
d.type_91[code.EGDC_3D_SHADOW] = 0xFFE8E8E8      -- 更浅的边框阴影，形成渐变效果
d.type_91[code.EGDC_3D_FACE] = 0xFFF5F5F5        -- 主背景色，非常柔和的白色
d.type_91[code.EGDC_3D_HIGH_LIGHT] = 0xFFE0F7FA  -- 淡蓝色高亮，清新不刺眼
d.type_91[code.EGDC_3D_LIGHT] = 0xFFFFFFFF       -- 最亮部分使用纯白

-- 工作区颜色
d.type_91[code.EGDC_APP_WORKSPACE] = 0xFFF9F9F9  -- 略带灰色的白，减少眼睛疲劳

-- 文本颜色
d.type_91[code.EGDC_BUTTON_TEXT] = 0xFF333333    -- 深灰文本，保证可读性
d.type_91[code.EGDC_GRAY_TEXT] = 0xFFA0A0A0      -- 禁用状态文本
d.type_91[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF0066CC -- 高亮文本使用蓝色增加对比
d.type_91[code.EGDC_TOOLTIP] = 0xFF444444        -- 工具提示文本，深色保证可读性
d.type_91[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFF0F0F0 -- 工具提示背景

-- 高亮和活动元素
d.type_91[code.EGDC_HIGH_LIGHT] = 0xFFE3F2FD     -- 淡蓝色高亮背景
d.type_91[code.EGDC_ACTIVE_BORDER] = 0xFF64B5F6  -- 活动边框使用较深的蓝色
d.type_91[code.EGDC_ACTIVE_CAPTION] = 0xFF2196F3 -- 活动标题文本
d.type_91[code.EGDC_INACTIVE_BORDER] = 0xFFE0E0E0 -- 非活动边框
d.type_91[code.EGDC_INACTIVE_CAPTION] = 0xFF757575 -- 非活动标题文本

-- 编辑框
d.type_91[code.EGDC_EDITABLE] = 0xFFFFFFFF       -- 白色编辑框
d.type_91[code.EGDC_GRAY_EDITABLE] = 0xFFEEEEEE  -- 禁用状态编辑框
d.type_91[code.EGDC_FOCUSED_EDITABLE] = 0xFFE3F2FD -- 聚焦编辑框使用淡蓝

-- 图标和符号
d.type_91[code.EGDC_ICON] = 0xFF42A5F5          -- 图标使用蓝色
d.type_91[code.EGDC_ICON_HIGH_LIGHT] = 0xFF0D47A1 -- 高亮图标使用深蓝
d.type_91[code.EGDC_WINDOW_SYMBOL] = 0xFF616161  -- 窗口符号使用中灰
d.type_91[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFBDBDBD -- 灰色符号

-- 滚动条
d.type_91[code.EGDC_SCROLLBAR] = 0xFFBBDEFB     -- 淡蓝色滚动条
d.type_91[code.EGDC_WINDOW] = 0xFFF5F5F5        -- 窗口背景


d.type_92 = {}
-- 边框与阴影（像棉花糖般柔软）
d.type_92[code.EGDC_3D_DARK_SHADOW] = 0xFFFFB6C1  -- 樱花粉暗影
d.type_92[code.EGDC_3D_SHADOW] = 0xFFFFD1DC      -- 浅粉渐变
d.type_92[code.EGDC_3D_FACE] = 0xFFFFF0F5        -- 淡粉主背景（少女的腮红）
d.type_92[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFACD  -- 香槟金高光（像少女发丝的光泽）
d.type_92[code.EGDC_3D_LIGHT] = 0xFFFFFFFF       -- 纯白（像少女的连衣裙）

-- 工作区（甜蜜空间）
d.type_92[code.EGDC_APP_WORKSPACE] = 0xFFFFF9FB  -- 带着微微粉色的白

-- 文本颜色（像糖果包装纸）
d.type_92[code.EGDC_BUTTON_TEXT] = 0xFFE75480    -- 草莓红文字
d.type_92[code.EGDC_GRAY_TEXT] = 0xFFFFAEB9      -- 褪色粉（害羞时的颜色）
d.type_92[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFF1493 -- 亮粉色（心动瞬间！）
d.type_92[code.EGDC_TOOLTIP] = 0xFFC71585        -- 玫瑰红提示
d.type_92[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFFFE4E1 -- 贝壳粉背景

-- 高亮元素（kiss重点！）
d.type_92[code.EGDC_HIGH_LIGHT] = 0xFFFF69B4     -- 热恋粉高亮
d.type_92[code.EGDC_ACTIVE_BORDER] = 0xFFFF00FF  -- 品红边框（心跳加速！）
d.type_92[code.EGDC_ACTIVE_CAPTION] = 0xFFFF00AF -- 活泼粉标题
d.type_92[code.EGDC_INACTIVE_BORDER] = 0xFFFFC0CB -- 经典粉
d.type_92[code.EGDC_INACTIVE_CAPTION] = 0xFFFFB6C1 -- 沉睡的粉

-- 编辑框（像情书便签）
d.type_92[code.EGDC_EDITABLE] = 0xFFFFFAFA       -- 雪白信纸
d.type_92[code.EGDC_GRAY_EDITABLE] = 0xFFFFF0F5  -- 被折过的信纸
d.type_92[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFE4E1 -- 被注视时泛红

-- 图标与装饰（少女的小饰品）
d.type_92[code.EGDC_ICON] = 0xFFFF85A2          -- 糖果粉图标
d.type_92[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF10F0 -- 闪亮粉紫（眨眼特效！）
d.type_92[code.EGDC_WINDOW_SYMBOL] = 0xFFFF6EC7  -- 魔法少女粉
d.type_92[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFFFBBFF -- 朦胧的幻想色

-- 其他甜蜜元素
d.type_92[code.EGDC_SCROLLBAR] = 0xFFFFAAD4     -- 棉花糖滚动条
d.type_92[code.EGDC_WINDOW] = 0xFFFFF9FB        -- 轻飘飘的窗纱质感


d.type_93 = {}
-- 主色调与阴影（基于F0F7E6的衍生）
d.type_93[code.EGDC_3D_DARK_SHADOW] = 0xFFD8E8C8  -- 比基础色深20%的阴影
d.type_93[code.EGDC_3D_SHADOW] = 0xFFE0EFD8      -- 比基础色深10%的中间调
d.type_93[code.EGDC_3D_FACE] = 0xFFF0F7E6        -- 您指定的基础色
d.type_93[code.EGDC_3D_HIGH_LIGHT] = 0xFFF5FAEC  -- 比基础色亮5%的高光
d.type_93[code.EGDC_3D_LIGHT] = 0xFFFBFFFA       -- 接近纯白的亮部

-- 工作区与背景
d.type_93[code.EGDC_APP_WORKSPACE] = 0xFFF5FAF0  -- 略带灰调的基础色变体

-- 文本与交互元素
d.type_93[code.EGDC_BUTTON_TEXT] = 0xFF556B2F    -- 橄榄绿文本，与基础色形成优雅对比
d.type_93[code.EGDC_GRAY_TEXT] = 0xFFA0B896      -- 柔和的灰绿色禁用状态文本
d.type_93[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF3A5F0B -- 深绿色高亮文本
d.type_93[code.EGDC_TOOLTIP] = 0xFF4B5320        -- 军绿色工具提示文本
d.type_93[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFE9F3DD -- 浅绿色工具提示背景

-- 高亮与状态指示
d.type_93[code.EGDC_HIGH_LIGHT] = 0xFFD1E7B7     -- 活泼的浅绿色高亮
d.type_93[code.EGDC_ACTIVE_BORDER] = 0xFF8BAE68   -- 自然绿活动边框
d.type_93[code.EGDC_ACTIVE_CAPTION] = 0xFF5A7243 -- 深绿活动标题
d.type_93[code.EGDC_INACTIVE_BORDER] = 0xFFD5E5CC -- 非活动边框
d.type_93[code.EGDC_INACTIVE_CAPTION] = 0xFFA0B896 -- 非活动标题

-- 输入控件
d.type_93[code.EGDC_EDITABLE] = 0xFFFFFFFF       -- 纯白编辑框
d.type_93[code.EGDC_GRAY_EDITABLE] = 0xFFEEF4E7  -- 浅灰绿禁用编辑框
d.type_93[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5FFE8 -- 聚焦时略带黄调

-- 图标与装饰元素
d.type_93[code.EGDC_ICON] = 0xFF7A9F5B          -- 自然绿图标
d.type_93[code.EGDC_ICON_HIGH_LIGHT] = 0xFF3D5A1F -- 深绿高亮图标
d.type_93[code.EGDC_WINDOW_SYMBOL] = 0xFF6B8E23  -- 橄榄绿窗口符号
d.type_93[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFC1D9A9 -- 浅灰绿符号
-- 其他界面元素
d.type_93[code.EGDC_SCROLLBAR] = 0xFFC8DCB0     -- 柔和的绿色滚动条
d.type_93[code.EGDC_WINDOW] = 0xFFF0F7E6        -- 与基础色一致的窗口背景


d.type_94 = {}
-- 主色调与阴影（夏日光线层次）
d.type_94[code.EGDC_3D_DARK_SHADOW] = 0xFF3A5F0B    -- 树荫深处的墨绿
d.type_94[code.EGDC_3D_SHADOW] = 0xFF8BAE68        -- 阳光斑驳的叶影
d.type_94[code.EGDC_3D_FACE] = 0xFFF5F5DC          -- 亚麻窗帘的米白
d.type_94[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFACD    -- 老电扇金属反光
d.type_94[code.EGDC_3D_LIGHT] = 0xFFFFF8E1         -- 阳光直射的墙面

-- 工作区（午休空间）
d.type_94[code.EGDC_APP_WORKSPACE] = 0xFFF0F0E0    -- 竹席的浅黄色

-- 文本颜色（夏日记忆）
d.type_94[code.EGDC_BUTTON_TEXT] = 0xFF556B2F      -- 西瓜皮绿文字
d.type_94[code.EGDC_GRAY_TEXT] = 0xFFC0C0A0        -- 褪色老时钟数字
d.type_94[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF8B4513  -- 木制家具的深棕
d.type_94[code.EGDC_TOOLTIP] = 0xFF5F4B32          -- 藤编家具纹理
d.type_94[code.EGDC_TOOLTIP_BACKGROUND] = 0xFFE8E0C9 -- 旧书页的泛黄

-- 高亮元素（午后闪光）
d.type_94[code.EGDC_HIGH_LIGHT] = 0xFFD4B483       -- 竹帘缝隙透光
d.type_94[code.EGDC_ACTIVE_BORDER] = 0xFFCD853F    -- 醒目的陶土红
d.type_94[code.EGDC_ACTIVE_CAPTION] = 0xFFA0522D   -- 深棕标题
d.type_94[code.EGDC_INACTIVE_BORDER] = 0xFFC0D6B3  -- 打盹时的朦胧绿
d.type_94[code.EGDC_INACTIVE_CAPTION] = 0xFF909A7B -- 半梦半醒的灰绿

-- 编辑框（午间笔记）
d.type_94[code.EGDC_EDITABLE] = 0xFFFFFDD0         -- 便签纸的奶油黄
d.type_94[code.EGDC_GRAY_EDITABLE] = 0xFFE8E8D8    -- 被遗忘的旧笔记
d.type_94[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFE0 -- 突然清醒的亮黄

-- 图标与装饰（夏日物件）
d.type_94[code.EGDC_ICON] = 0xFF708238            -- 电扇按钮的氧化绿
d.type_94[code.EGDC_ICON_HIGH_LIGHT] = 0xFFD2691E -- 突然响起的闹钟橙
d.type_94[code.EGDC_WINDOW_SYMBOL] = 0xFF6B8E23    -- 窗外的树影
d.type_94[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB0B0A0 -- 朦胧睡眼的灰

-- 其他元素（夏日声响）
d.type_94[code.EGDC_SCROLLBAR] = 0xFFC0B080       -- 老式电扇转轴色
d.type_94[code.EGDC_WINDOW] = 0xFFFAF0E6          -- 亚麻床单的温暖白


d.current_skin = "my_2"
d.my = {}
d.my[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A --按钮暗阴影
d.my[code.EGDC_3D_FACE] = 0xFFF58220 --按钮与窗口的背景
d.my[code.EGDC_3D_SHADOW] = 0xFF333333 --按钮与窗口的右下阴影，卡名框的左上角
d.my[code.EGDC_3D_HIGH_LIGHT] = 0xFF3A0C37 --下拉框的背景，卡名的右下角，窗口的左边，tab页的高亮项
d.my[code.EGDC_3D_LIGHT] = 0xFFFFA500
d.my[code.EGDC_APP_WORKSPACE] = 0xFFffffff
d.my[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF --按钮文本，窗口文本
d.my[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9
d.my[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF --高亮项的文本
d.my[code.EGDC_HIGH_LIGHT] = 0xaaFF6600 --高亮项的背景
d.my[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 --窗口标题在聚焦时的左边
d.my[code.EGDC_ACTIVE_CAPTION] = d.my[code.EGDC_HIGH_LIGHT_TEXT] --窗口标题的文本
d.my[code.EGDC_INACTIVE_BORDER] = 0xa0FFFFFF
d.my[code.EGDC_INACTIVE_CAPTION] = 0xFF222222
d.my[code.EGDC_TOOLTIP] = 0xFFFFFACD --工具提示的文本，卡名
d.my[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F --工具提示的背景
d.my[code.EGDC_SCROLLBAR] = 0x80F58220 --滚动条
d.my[code.EGDC_EDITABLE] = d.my[code.EGDC_3D_HIGH_LIGHT] --普通状态的编辑框
d.my[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 --禁用状态的编辑框
d.my[code.EGDC_FOCUSED_EDITABLE] = d.my[code.EGDC_HIGH_LIGHT] --激活状态的编辑框
d.my[code.EGDC_ICON] = 0xFFFFA500 --图标的颜色
d.my[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 --图标高亮时的文本色
d.my[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 --复选框的文本
d.my[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFffffff
d.my[code.EGDC_WINDOW] = 0xFFffffff
--~ cc.rs :type_1 'my'



d.my_3 = {}
-- 斩魄刀风格的3D效果
d.my_3[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A -- 虚化黑（类似死霸装阴影）
d.my_3[code.EGDC_3D_SHADOW] = 0xFF333333 -- 浅虚黑
d.my_3[code.EGDC_3D_FACE] = 0xFFF58220 -- 斩月橙（主色调）
d.my_3[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFD700 -- 卍解金（高光点缀）
d.my_3[code.EGDC_3D_LIGHT] = 0xFFFFA500 -- 普通橙

-- 虚夜宫风格的窗口元素
d.my_3[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 -- 血战红（活跃边框）
d.my_3[code.EGDC_ACTIVE_CAPTION] = 0xFF450000 -- 暗血红标题栏
d.my_3[code.EGDC_INACTIVE_BORDER] = 0xFF413839 -- 灰黑（非活动状态）
d.my_3[code.EGDC_INACTIVE_CAPTION] = 0xFF222222 -- 死霸装黑
d.my_3[code.EGDC_APP_WORKSPACE] = 0xFF000000 -- 纯黑背景

-- 灵压波动的文本色
d.my_3[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF -- 白色（像魂的文字）
d.my_3[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9 -- 灰色（类似浅打未激活）
d.my_3[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFF4500 -- 高亮橙红

-- 月牙天冲特效色
d.my_3[code.EGDC_HIGH_LIGHT] = 0xFF0066CC -- 蓝色（类似破道特效）
d.my_3[code.EGDC_FOCUSED_EDITABLE] = 0x20FFFF00 -- 聚焦黄（灵压感应）

-- 义魂丸提示风格
d.my_3[code.EGDC_TOOLTIP] = 0xFFFFFACD -- 米白（类似魂的对话框）
d.my_3[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F -- 半透黑底

-- 瞬步残影滚动条
d.my_3[code.EGDC_SCROLLBAR] = 0x80F58220 -- 半透斩月橙

-- 断界风格的窗口
d.my_3[code.EGDC_WINDOW] = 0xFF111111 -- 深空黑
d.my_3[code.EGDC_EDITABLE] = 0xFF222222 -- 可编辑区灰黑
d.my_3[code.EGDC_GRAY_EDITABLE] = 0xFF1A1A1A -- 禁用编辑区

-- 斩魄刀图标
d.my_3[code.EGDC_ICON] = 0xFFFFA500 -- 橙色图标
d.my_3[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000 -- 高亮红（虚化状态）

-- 鬼道符咒符号
d.my_3[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700 -- 金色符号
d.my_3[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF555555 -- 禁用符号灰

d.my_1 = {}
d.my_1[code.EGDC_3D_DARK_SHADOW] = 0xFFD7CCC8 --按钮暗阴影
d.my_1[code.EGDC_3D_FACE] = 0xFFffffff
d.my_1[code.EGDC_3D_SHADOW] = d.my_1[code.EGDC_3D_FACE]
d.my_1[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFF3E0
d.my_1[code.EGDC_3D_LIGHT] = 0xFFFFA500
d.my_1[code.EGDC_APP_WORKSPACE] = 0xFFffffff
d.my_1[code.EGDC_BUTTON_TEXT] = 0xFF242326
d.my_1[code.EGDC_GRAY_TEXT] = 0xFFA9A9A9
d.my_1[code.EGDC_HIGH_LIGHT_TEXT] = 0xF0FFFFFF --高亮项的文本
d.my_1[code.EGDC_HIGH_LIGHT] = 0xaaFF6600 --高亮项的背景
d.my_1[code.EGDC_ACTIVE_BORDER] = 0xFF8B0000 --窗口标题在聚焦时的左边
d.my_1[code.EGDC_ACTIVE_CAPTION] = d.my_1[code.EGDC_HIGH_LIGHT_TEXT] --窗口标题的文本
d.my_1[code.EGDC_INACTIVE_BORDER] = 0xa0FFFFFF
d.my_1[code.EGDC_INACTIVE_CAPTION] = 0xFF222222
d.my_1[code.EGDC_TOOLTIP] = 0xFF0184bc
d.my_1[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2F2F2F --工具提示的背景
d.my_1[code.EGDC_SCROLLBAR] = 0x80F58220 --滚动条
d.my_1[code.EGDC_EDITABLE] = d.my_1[code.EGDC_3D_HIGH_LIGHT] --普通状态的编辑框
d.my_1[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3 --禁用状态的编辑框
d.my_1[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5F5F5
d.my_1[code.EGDC_ICON] = 0xFFFFA500
d.my_1[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF0000
d.my_1[code.EGDC_WINDOW_SYMBOL] = d.my_1[code.EGDC_BUTTON_TEXT]
d.my_1[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFffffff
d.my_1[code.EGDC_WINDOW] = 0xFFffffff

return d
