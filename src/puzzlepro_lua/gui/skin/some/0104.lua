local code = require("gui/skin/code")  
local d = {}  
  
-- 基础3D结构（建筑层次感）  
d[code.EGDC_3D_DARK_SHADOW] = 0xDD5D4037    -- 深褐色阴影（古建筑暗部）  
d[code.EGDC_3D_SHADOW] = 0xFFD4B896
d[code.EGDC_3D_FACE] = 0xFFD4B896           -- 土黄色主面（墙体色）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFE8F0F5     -- 天空色高光  
d[code.EGDC_3D_LIGHT] = 0xFFF5E6D3          -- 暖白色亮部  
  
-- 背景与工作区（天空与远景）  
d[code.EGDC_APP_WORKSPACE] = 0xFFE8F0F5     -- 天空淡青色  
d[code.EGDC_WINDOW] = 0xFFF0F5F8            -- 更浅的天空色  
  
-- 文本系统（墨色与朱砂）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2F1B14       -- 深墨褐色  
d[code.EGDC_GRAY_TEXT] = 0xFF9BB5C4         -- 远山青灰色  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF8B4513   -- 朱砂褐色  
  
-- 交互高亮（水面波光）  
d[code.EGDC_HIGH_LIGHT] = 0x886B8E7A        -- 半透明青绿色  
d[code.EGDC_SCROLLBAR] = 0xAA6B8E7A         -- 水面色滚动条  
  
-- 边框系统（建筑轮廓）  
d[code.EGDC_ACTIVE_BORDER] = 0xFF8B4513     -- 活跃边框（朱砂色）  
d[code.EGDC_INACTIVE_BORDER] = 0x809BB5C4   -- 非活跃边框（远山色）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFD4B896
d[code.EGDC_INACTIVE_CAPTION] = 0xFF9BB5C4  -- 非活跃标题  
  
-- 工具提示（古纸质感）  
d[code.EGDC_TOOLTIP] = 0xFF2F1B14           -- 墨色文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEF5E6D3 -- 古纸背景  
  
-- 编辑框状态（纸张书写区）  
d[code.EGDC_EDITABLE] = 0xFFFFFBF0          -- 宣纸白  
d[code.EGDC_GRAY_EDITABLE] = 0xFFE8E0D6     -- 旧纸色  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5E6D3  -- 聚焦时暖白  
  
-- 图标系统（点缀色彩）  
d[code.EGDC_ICON] = 0xFF6B8E7A              -- 青绿色图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFCD853F   -- 金黄色高亮  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF8B4513     -- 朱砂色符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF9BB5C4 -- 灰化符号  
  
return d
