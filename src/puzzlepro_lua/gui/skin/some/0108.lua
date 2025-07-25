local code = require("gui/skin/code")  
local d = {}  
  
-- 深蓝夜空系（界面基底）  
d[code.EGDC_3D_DARK_SHADOW] = 0xEE1A2B4D    -- 最深夜空蓝  
d[code.EGDC_3D_SHADOW] = 0xEE2D4A7A        -- 中等夜空蓝    
d[code.EGDC_APP_WORKSPACE] = 0xFF0F1B3A     -- 工作区深蓝背景  
d[code.EGDC_WINDOW] = 0xFF1A2B4D           -- 窗口背景  
  
-- 金黄旗帜系（重点元素）  
d[code.EGDC_3D_FACE] = 0xFFD4AF37          -- 按钮主色（旗帜金）  
d[code.EGDC_TOOLTIP] = 0xFFFFD700          -- 工具提示文字（纯金色）  
d[code.EGDC_ICON] = 0xFFD4AF37             -- 图标颜色  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700    -- 窗口符号  
  
-- 深红血色系（激活状态）  
d[code.EGDC_ACTIVE_BORDER] = 0xFFB22222     -- 活动边框（革命红）  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFDC143C  -- 高亮图标（深红）  
d[code.EGDC_HIGH_LIGHT] = 0xAAB22222       -- 高亮背景（半透明红）  
  
-- 象牙白光系（文本与高光）  
d[code.EGDC_BUTTON_TEXT] = 0xFFFFF8DC       -- 按钮文字（象牙白）  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 高亮文字（纯白）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFF8DC    -- 活动标题  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFF5F5DC    -- 3D高光  
d[code.EGDC_3D_LIGHT] = 0xFFFFFFFF         -- 最亮高光  
  
-- 大地棕褐系（辅助元素）  
d[code.EGDC_GRAY_TEXT] = 0xFFCD853F         -- 灰色文字（沙褐色）  
d[code.EGDC_INACTIVE_BORDER] = 0x80A0522D   -- 非活动边框（半透明棕）  
d[code.EGDC_INACTIVE_CAPTION] = 0xFFCD853F  -- 非活动标题  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0522D -- 灰色窗口符号  
  
-- 编辑框状态（渐进层次）  
d[code.EGDC_EDITABLE] = 0xEE2D4A7A          -- 普通编辑框（夜空蓝）  
d[code.EGDC_GRAY_EDITABLE] = 0xFF4A6B8D     -- 禁用编辑框  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFD4AF37  -- 聚焦编辑框（金黄）  
  
-- 动态元素  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEE1A2B4D -- 工具提示背景  
d[code.EGDC_SCROLLBAR] = 0xFFB22222         -- 滚动条（革命红）  
  
return d
