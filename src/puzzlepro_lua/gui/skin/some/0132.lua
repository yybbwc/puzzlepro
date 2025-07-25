local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（使用中性灰调，打造立体层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1C1C1C     -- 深炭黑，营造强烈阴影  
d[code.EGDC_3D_FACE] = 0xFFE0E0E0            -- 柔和灰面  
d[code.EGDC_3D_SHADOW] = 0xFFCCCCCC          -- 浅阴影  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF      -- 纯白高光  
d[code.EGDC_3D_LIGHT] = 0xFFF5F5F5           -- 柔光灰  

-- 界面基础色（现代简约风格）
d[code.EGDC_APP_WORKSPACE] = 0xFFEAEAEA      -- 轻灰背景  
d[code.EGDC_WINDOW] = 0xFFFFFFFF             -- 纯净窗口背景  

-- 文本颜色（高对比度，确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFF1C1C1C        -- 深灰正文  
d[code.EGDC_GRAY_TEXT] = 0xFF888888          -- 灰色次要文本  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF    -- 白色高亮文本  

-- 交互元素（使用 Pantone 2024 年度色 “Peach Fuzz” 作为强调色）
d[code.EGDC_HIGH_LIGHT] = 0xAAFFA88C         -- 半透 Peach Fuzz 高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFFFF7F50      -- 活跃边框：珊瑚橙  
d[code.EGDC_ACTIVE_CAPTION] = 0xFF1C1C1C     -- 深灰标题  
d[code.EGDC_INACTIVE_BORDER] = 0x80CCCCCC    -- 半透明非活跃边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFFAAAAAA   -- 灰色非活跃标题  

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFFFFFFF           -- 编辑框背景  
d[code.EGDC_GRAY_EDITABLE] = 0xFFE0E0E0      -- 禁用状态  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFF5F5F5   -- 聚焦状态  

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFFFFFFF            -- 白色提示文本  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xFF1C1C1C -- 深灰提示背景  
d[code.EGDC_SCROLLBAR] = 0xFFAAAAAA          -- 滚动条灰色  
d[code.EGDC_ICON] = 0xFF4A4A4A               -- 图标基础色  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF7F50    -- 图标高亮：珊瑚橙  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF4A4A4A      -- 窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFAAAAAA -- 灰色窗口符号  

return d
