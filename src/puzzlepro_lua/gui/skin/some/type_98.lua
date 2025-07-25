local code = require("gui/skin/code")  
local d = {}  
  
-- 深层结构（画作的深邃背景）  
d[code.EGDC_3D_DARK_SHADOW] = 0xFF3C2415    -- 暗褐阴影  
d[code.EGDC_3D_SHADOW] = 0xFF6B4423         -- 温暖棕影  
d[code.EGDC_3D_FACE] = 0xFFD4B896           -- 温润肌色主调  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFF5E6D3     -- 珍珠白高光  
d[code.EGDC_3D_LIGHT] = 0xFFE6C078          -- 金黄辅助光  
  
-- 工作区域（画布质感）  
d[code.EGDC_APP_WORKSPACE] = 0xFFF8F4E8      -- 画布米白  
d[code.EGDC_WINDOW] = 0xFFF0E6D8             -- 画框内侧  
  
-- 文字系统（墨色层次）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2A1810        -- 深邃棕黑  
d[code.EGDC_GRAY_TEXT] = 0xFF8B6B47          -- 褪色棕  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFF5E6D3    -- 珍珠白文字  
  
-- 交互元素（神秘感与温暖感平衡）  
d[code.EGDC_HIGH_LIGHT] = 0xAA4A6B5C         -- 半透明神秘蓝绿  
d[code.EGDC_ACTIVE_BORDER] = 0xFF6B4423      -- 温暖棕边框  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFE6C078     -- 金黄标题  
d[code.EGDC_INACTIVE_BORDER] = 0x80A68B73    -- 半透明灰棕  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8B6B47   -- 褪色棕标题  
  
-- 工具提示（古典书卷感）  
d[code.EGDC_TOOLTIP] = 0xFF2A1810            -- 深棕文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF8F4E8 -- 半透明画布色  
  
-- 编辑与滚动元素  
d[code.EGDC_SCROLLBAR] = 0xFF4A6B5C          -- 神秘蓝绿滚动条  
d[code.EGDC_EDITABLE] = 0xFFF5E6D3           -- 珍珠白编辑框  
d[code.EGDC_GRAY_EDITABLE] = 0xFFE0D0C0      -- 灰化编辑框  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFE6C078   -- 金黄聚焦框  
  
-- 图标系统（古典装饰感）  
d[code.EGDC_ICON] = 0xFFE6C078               -- 金黄图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF4A6B5C    -- 神秘蓝绿高亮  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF6B4423      -- 温暖棕符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8B6B47 -- 褪色棕符号  
  
return d
