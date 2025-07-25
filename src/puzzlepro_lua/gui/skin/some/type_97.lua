local code = require("gui/skin/code")  
local d = {}  
  
-- 深夜蓝系（主背景和阴影）  
d[code.EGDC_3D_DARK_SHADOW] = 0xee1A237E    -- 深靛蓝阴影  
d[code.EGDC_3D_SHADOW] = 0xee2E3A8C         -- 中等夜蓝阴影  
d[code.EGDC_APP_WORKSPACE] = 0xFF0F1B3C     -- 深夜蓝工作区  
d[code.EGDC_WINDOW] = 0xFF1A237E            -- 窗口背景夜蓝  
  
-- 金黄星光系（高亮和重点元素）  
d[code.EGDC_TOOLTIP] = 0xFFFFD700           -- 金黄工具提示  
d[code.EGDC_ICON] = 0xFFFFA500              -- 琥珀金图标  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700     -- 金色窗口符号  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFE55C   -- 亮金高亮图标  
  
-- 青绿旋涡系（3D元素和高亮）  
d[code.EGDC_3D_FACE] = 0xee4A90E2          -- 天蓝色按钮面  
d[code.EGDC_3D_HIGH_LIGHT] = 0xff87CEEB    -- 天空蓝高光  
d[code.EGDC_3D_LIGHT] = 0xFFB0E0E6         -- 粉蓝光效  
d[code.EGDC_HIGH_LIGHT] = 0xAA4169E1       -- 半透明皇家蓝高亮  
d[code.EGDC_SCROLLBAR] = 0xFF4169E1        -- 皇家蓝滚动条  
  
-- 文本系统（对比度优化）  
d[code.EGDC_BUTTON_TEXT] = 0xFFFFFFFF       -- 纯白按钮文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 白色高亮文字  
d[code.EGDC_GRAY_TEXT] = 0xFFB0C4DE        -- 淡钢蓝灰色文字  
  
-- 边框和标题（星光点缀）  
d[code.EGDC_ACTIVE_BORDER] = 0xFFFFD700     -- 金色活动边框  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色活动标题  
d[code.EGDC_INACTIVE_BORDER] = 0x804169E1   -- 半透明蓝色非活动边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFFB0C4DE  -- 淡蓝非活动标题  
  
-- 编辑框系统（夜空层次）  
d[code.EGDC_EDITABLE] = 0xee2E3A8C         -- 中夜蓝编辑框  
d[code.EGDC_GRAY_EDITABLE] = 0xFF483D8B     -- 深蓝紫禁用状态  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF4A90E2 -- 天蓝聚焦状态  
  
-- 工具提示背景  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xee1A237E -- 深靛蓝半透明背景  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFB0C4DE -- 淡蓝灰符号  
  
return d
