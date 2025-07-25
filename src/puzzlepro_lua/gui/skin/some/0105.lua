local code = require("gui/skin/code")  
local d = {}  
  
-- 深色阴影组（画作背景的深邃黑褐）  
d[code.EGDC_3D_DARK_SHADOW] = 0xEE1A0F0A      -- 深褐黑阴影  
d[code.EGDC_3D_SHADOW] = 0xEEE8D4C0
d[code.EGDC_EDITABLE] = 0xEE3A2418            -- 编辑框暗褐  
  
-- 主色调组（少女肌肤的温润色调）  
d[code.EGDC_3D_FACE] = 0xEEE8D4C0             -- 温润肌肤色  
d[code.EGDC_APP_WORKSPACE] = 0xFFF2E6D8        -- 工作区米色  
d[code.EGDC_WINDOW] = 0xFFF5EDE2              -- 窗口象牙白  
  
-- 高光组（珍珠与光线反射）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFF8F6F0       -- 珍珠高光  
d[code.EGDC_3D_LIGHT] = 0xFFFFFFFF            -- 纯白反光  
d[code.EGDC_FOCUSED_EDITABLE] = d[code.EGDC_3D_HIGH_LIGHT]  
  
-- 蓝色系组（头巾与背景的神秘蓝）  
d[code.EGDC_HIGH_LIGHT] = 0xFF4A6B8A          -- 头巾蓝  
d[code.EGDC_SCROLLBAR] = d[code.EGDC_HIGH_LIGHT]  
d[code.EGDC_INACTIVE_BORDER] = 0x804A6B8A     -- 半透明蓝边框  
d[code.EGDC_ACTIVE_BORDER] = 0xFF4A6B8A       -- 活动蓝边框  
  
-- 文字组（确保可读性）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2D1B12         -- 深褐文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFF8F6F0     -- 高亮白文字  
d[code.EGDC_GRAY_TEXT] = 0xFF8B7355           -- 灰褐辅助文字  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFF8F6F0      -- 活动标题白字  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8B7355    -- 非活动标题  
  
-- 金色点缀组（耳环的温暖金光）  
d[code.EGDC_TOOLTIP] = 0xFFD4AF37             -- 金色提示文字  
d[code.EGDC_ICON] = 0xFFD4AF37                -- 金色图标  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFD4AF37       -- 金色符号  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE6C229     -- 亮金高光  
  
-- 背景与辅助色  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEE1A0F0A  -- 深色提示背景  
d[code.EGDC_GRAY_EDITABLE] = 0xFFB8A082       -- 灰色编辑框  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8B7355  -- 灰色符号  
  
return d
