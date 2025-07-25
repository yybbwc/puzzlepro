local code = require("gui/skin/code")  
local d = {}  

-- 3D 效果层（深海光影）  
d[code.EGDC_3D_DARK_SHADOW] = 0xFF0A0F1F    -- 深海黑影  
d[code.EGDC_3D_FACE] = 0xFF1A2A40           -- 深蓝主面  
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF2D4A6B     -- 浅蓝高光  
d[code.EGDC_3D_LIGHT] = 0xFF3A5A7A          -- 蓝白亮面  

-- 界面基础色  
d[code.EGDC_APP_WORKSPACE] = 0xFF121E30     -- 深海背景  
d[code.EGDC_WINDOW] = 0xFF1E2E45            -- 窗口背景  

-- 文本颜色  
d[code.EGDC_BUTTON_TEXT] = 0xFFE0F0FF       -- 淡蓝文字  
d[code.EGDC_GRAY_TEXT] = 0xFF8BA4B8         -- 灰蓝副文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文字  

-- 交互元素（珊瑚红点缀）  
d[code.EGDC_HIGH_LIGHT] = 0xCCF7667A        -- 半透珊瑚红高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFFF7667A     -- 活跃边框（珊瑚红）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题  
d[code.EGDC_INACTIVE_BORDER] = 0x802D4A6B   -- 半透非活跃边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8BA4B8  -- 灰蓝标题  

-- 编辑框状态  
d[code.EGDC_EDITABLE] = 0xFF253550          -- 编辑框背景  
d[code.EGDC_GRAY_EDITABLE] = 0xFF1C2A40     -- 禁用状态  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF3A5A7A  -- 聚焦状态  

-- 辅助元素  
d[code.EGDC_TOOLTIP] = 0xFFE0F0FF           -- 工具提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xE61A2A40 -- 工具提示背景  
d[code.EGDC_SCROLLBAR] = 0xFF5A7A9A         -- 滚动条  
d[code.EGDC_ICON] = 0xFF7A9AB8              -- 图标色  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFF7667A   -- 高亮图标色  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF5A7A9A     -- 窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF4A6A8A -- 灰窗口符号  

return d
