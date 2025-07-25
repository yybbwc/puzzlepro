local code = require("gui/skin/code")  
local d = {}  
  
-- 基于蒙娜丽莎的配色方案  
-- 主色调：温暖的大地色系与柔和的蓝绿色  
  
-- 3D效果组（画作的明暗层次）  
d[code.EGDC_3D_DARK_SHADOW] = 0xFF2D1B0F    -- 深褐色阴影（头发暗部）  
d[code.EGDC_3D_SHADOW] = 0xFF4A3426         -- 中褐色（面部阴影）  
d[code.EGDC_3D_FACE] = 0xFFD4C4A8           -- 肌肤色（主背景）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFF2E6D3     -- 高光肌肤色  
d[code.EGDC_3D_LIGHT] = 0xFFE8DCC6          -- 柔和高光  
  
-- 背景与工作区（远山与天空）  
d[code.EGDC_APP_WORKSPACE] = 0xFF8FA68E     -- 远山绿灰色  
d[code.EGDC_WINDOW] = 0xFFB8C5B1            -- 淡雅背景绿  
  
-- 文本系统（清晰可读）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2D1B0F       -- 深褐色文字  
d[code.EGDC_GRAY_TEXT] = 0xFF6B5B4F         -- 灰褐色次要文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFF2E6D3   -- 高亮文字  
  
-- 交互元素（神秘微笑的魅力）  
d[code.EGDC_HIGH_LIGHT] = 0xAAC4A484        -- 半透明橄榄绿高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFF8B7355     -- 活跃边框（衣服色）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFF2E6D3    -- 活跃标题  
d[code.EGDC_INACTIVE_BORDER] = 0x80A68E7A   -- 非活跃边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF6B5B4F  -- 非活跃标题  
  
-- 编辑框系统  
d[code.EGDC_EDITABLE] = 0xFFF8F4E8          -- 象牙白编辑框  
d[code.EGDC_GRAY_EDITABLE] = 0xFFE0D4C0     -- 禁用编辑框  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFF2E6D3  -- 聚焦编辑框  
  
-- 工具提示（画作细节）  
d[code.EGDC_TOOLTIP] = 0xFF2D1B0F           -- 深褐色提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF8F4E8 -- 半透明象牙白背景  
  
-- 滚动条与图标  
d[code.EGDC_SCROLLBAR] = 0xFF8B7355         -- 衣服色滚动条  
d[code.EGDC_ICON] = 0xFF6B5B4F              -- 标准图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFD4A574   -- 高亮图标（金色调）  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF8B7355     -- 窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA68E7A -- 灰色符号  
  
return d
