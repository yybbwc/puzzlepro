local code = require("gui/skin/code")  
local d = {}  
  
-- 深夜天空层次（3D基础结构）  
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1A237E    -- 深夜蓝阴影  
d[code.EGDC_3D_SHADOW] = 0xFF303F9F        -- 中夜蓝阴影    
d[code.EGDC_3D_FACE] = 0xFF3F51B5          -- 主夜空蓝  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF5C6BC0    -- 月光蓝高光  
d[code.EGDC_3D_LIGHT] = 0xFF9FA8DA         -- 星光淡蓝  
  
-- 核心工作区（夜空背景）  
d[code.EGDC_APP_WORKSPACE] = 0xFF1A237E    -- 深夜蓝背景  
d[code.EGDC_WINDOW] = 0xFF283593           -- 窗口夜蓝  
  
-- 文字系统（星月光芒）  
d[code.EGDC_BUTTON_TEXT] = 0xFFFFF9C4       -- 月光白文字  
d[code.EGDC_GRAY_TEXT] = 0xFF9FA8DA         -- 星光灰文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文字  
  
-- 交互高亮（星星闪烁效果）  
d[code.EGDC_HIGH_LIGHT] = 0xAAFFD700        -- 半透明星光黄  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFEB3B  -- 聚焦时的星光黄  
  
-- 边框系统（柏树轮廓）  
d[code.EGDC_ACTIVE_BORDER] = 0xFF2E7D32     -- 柏树绿活动边框  
d[code.EGDC_INACTIVE_BORDER] = 0x80558B2F   -- 半透明橄榄绿  
  
-- 标题栏（月亮与星星）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFF9C4    -- 月光白标题  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF9FA8DA  -- 星光灰标题  
  
-- 工具提示（村庄灯光）  
d[code.EGDC_TOOLTIP] = 0xFF1A237E           -- 深蓝提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEFFB74D -- 温暖橙黄背景  
  
-- 滚动条与编辑框  
d[code.EGDC_SCROLLBAR] = 0x80FFD700         -- 星光黄滚动条  
d[code.EGDC_EDITABLE] = 0xFF3F51B5          -- 夜蓝编辑框  
d[code.EGDC_GRAY_EDITABLE] = 0xFF5C6BC0     -- 月光蓝禁用状态  
  
-- 图标系统（星星点缀）  
d[code.EGDC_ICON] = 0xFFFFD700              -- 星光黄图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF8F00   -- 橙色高亮图标  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFFFF9C4     -- 月光白符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF9FA8DA -- 星光灰符号  
  
return d
