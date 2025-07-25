local code = require("gui/skin/code")  
local d = {}  
  
-- 天空渐变层（界面基础）  
d[code.EGDC_3D_DARK_SHADOW] = 0xee2B4A6B    -- 深天空蓝（阴影）  
d[code.EGDC_3D_SHADOW] = 0xee4A7BA8         -- 中天空蓝  
d[code.EGDC_3D_FACE] = 0xee87CEEB           -- 主天空蓝（按钮背景）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xffB0E0E6     -- 浅天空蓝（高光）  
d[code.EGDC_3D_LIGHT] = 0xFFE0F6FF          -- 最浅天空蓝  
  
-- 草地绿系（工作区域）  
d[code.EGDC_APP_WORKSPACE] = 0xFF9ACD32     -- 黄绿草地色  
d[code.EGDC_WINDOW] = 0xFFF0FFF0            -- 淡绿窗口背景  
  
-- 文字系统（对比度优化）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2F4F4F       -- 深石板灰（高对比度）  
d[code.EGDC_GRAY_TEXT] = 0xFF708090         -- 中灰文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文字  
  
-- 交互元素（暖橙系）  
d[code.EGDC_HIGH_LIGHT] = 0xFFDDA0DD        -- 温暖紫色高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFFCD853F     -- 暖橙边框  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题文字  
  
-- 非活跃状态（柔和处理）  
d[code.EGDC_INACTIVE_BORDER] = 0x80B0C4DE   -- 半透明浅钢蓝  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF778899  -- 浅石板灰  
  
-- 提示系统（金黄系）  
d[code.EGDC_TOOLTIP] = 0xFF2F4F4F           -- 深色提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xeeFFE4B5 -- 半透明米黄背景  
  
-- 滚动条与编辑框  
d[code.EGDC_SCROLLBAR] = d[code.EGDC_HIGH_LIGHT]  
d[code.EGDC_EDITABLE] = 0xeeF0F8FF          -- 淡蓝编辑框  
d[code.EGDC_GRAY_EDITABLE] = 0xFFE6E6FA     -- 淡紫灰禁用状态  
d[code.EGDC_FOCUSED_EDITABLE] = d[code.EGDC_3D_HIGH_LIGHT]  
  
-- 图标系统  
d[code.EGDC_ICON] = 0xFFDAA520              -- 金棒色图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF6347   -- 番茄红高亮  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFDAA520     -- 金色符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF778899 -- 灰色符号  
  
return d
