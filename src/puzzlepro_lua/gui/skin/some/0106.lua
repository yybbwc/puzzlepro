local code = require("gui/skin/code")  
local d = {}  
  
-- 深色基底组（画作背景的神秘深色）  
d[code.EGDC_3D_DARK_SHADOW] = 0xEE2C4A3A    -- 深翡翠绿阴影  
d[code.EGDC_3D_SHADOW] = 0xEEE8D4B8
d[code.EGDC_APP_WORKSPACE] = 0xFF1A2F26     -- 深绿背景  
  
-- 主体色调组（温暖肌肤色调）  
d[code.EGDC_3D_FACE] = 0xEEE8D4B8          -- 珍珠肌肤色  
d[code.EGDC_WINDOW] = 0xFFF5E6D3            -- 象牙白窗口  
d[code.EGDC_EDITABLE] = 0xEEF0E2D0          -- 温暖米色输入框  
  
-- 高光组（丝绸光泽）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFF8E8A0     -- 金丝高光  
d[code.EGDC_3D_LIGHT] = 0xFFFFF4E6         -- 丝绸反光  
d[code.EGDC_FOCUSED_EDITABLE] = d[code.EGDC_3D_HIGH_LIGHT]  
  
-- 文字组（保证可读性）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2A1810       -- 深棕色文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文字  
d[code.EGDC_GRAY_TEXT] = 0xFF8B7355         -- 古铜色灰文字  
  
-- 强调色组（珠宝色彩）  
d[code.EGDC_HIGH_LIGHT] = 0xAA4A90E2        -- 半透明宝石蓝  
d[code.EGDC_ACTIVE_BORDER] = 0xFF2E8B57     -- 翡翠绿边框  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题  
d[code.EGDC_INACTIVE_BORDER] = 0x804A6B5A   -- 半透明绿边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8B7355  -- 古铜色非活动标题  
  
-- 辅助元素组  
d[code.EGDC_TOOLTIP] = 0xFFD4AF37          -- 金色提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEE2C4A3A -- 深绿提示背景  
d[code.EGDC_SCROLLBAR] = d[code.EGDC_HIGH_LIGHT]  
d[code.EGDC_GRAY_EDITABLE] = 0xFFD0C0A8     -- 灰米色禁用框  
  
-- 图标组（装饰元素）  
d[code.EGDC_ICON] = 0xFFD4AF37             -- 金色图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF4A90E2  -- 宝石蓝高亮图标  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFD4AF37    -- 金色窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8B7355 -- 古铜色灰符号  
  
return d
