local code = require("gui/skin/code")  
local d = {}  
  
-- 3D效果层（画面的明暗层次）  
d[code.EGDC_3D_DARK_SHADOW] = 0xEE2D1B0F    -- 深棕色阴影（老新郎外套色）  
d[code.EGDC_3D_SHADOW] = 0xccF5E6D3
d[code.EGDC_3D_FACE] = 0xddF5E6D3
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFAF0     -- 纯白高光  
d[code.EGDC_3D_LIGHT] = 0xFFF8E8D0          -- 温暖白光  
  
-- 界面基础色  
d[code.EGDC_APP_WORKSPACE] = 0xFFF0E6D8      -- 温暖的背景色  
d[code.EGDC_WINDOW] = 0xFFFAF5F0             -- 窗口背景  
  
-- 文本颜色（确保可读性）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2D1B0F       -- 深棕色文本  
d[code.EGDC_GRAY_TEXT] = 0xFF8B7355         -- 灰棕色次要文本  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 白色高亮文本  
  
-- 交互元素（使用画中的红色调作为强调）  
d[code.EGDC_HIGH_LIGHT] = 0xAAB8860B        -- 半透明金棕色高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFF8B4513     -- 活跃边框（深棕）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题  
d[code.EGDC_INACTIVE_BORDER] = 0x804A3426   -- 半透明非活跃边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8B7355  -- 灰棕色非活跃标题  
  
-- 编辑框状态  
d[code.EGDC_EDITABLE] = 0xFFFFFAF0          -- 编辑框背景  
d[code.EGDC_GRAY_EDITABLE] = 0xFFE6D7C3     -- 禁用状态  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFF8E8D0  -- 聚焦状态  
  
-- 辅助元素  
d[code.EGDC_TOOLTIP] = 0xFF2D1B0F          -- 工具提示文本  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF5E6D3 -- 工具提示背景  
d[code.EGDC_SCROLLBAR] = 0xFF8B7355        -- 滚动条  
d[code.EGDC_ICON] = 0xFF654321             -- 图标色  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFCD853F  -- 高亮图标  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF8B4513    -- 窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0826D -- 灰色窗口符号  
  
return d
