local code = require("gui/skin/code")  
local d = {}  

-- 3D 效果层（霓虹光影）  
d[code.EGDC_3D_DARK_SHADOW] = 0xFF000000    -- 纯黑阴影  
d[code.EGDC_3D_FACE] = 0xFF111111           -- 深灰主面  
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF333333     -- 灰白高光  
d[code.EGDC_3D_LIGHT] = 0xFF444444          -- 浅灰亮面  

-- 界面基础色  
d[code.EGDC_APP_WORKSPACE] = 0xFF0A0A0A     -- 深黑背景  
d[code.EGDC_WINDOW] = 0xFF151515            -- 窗口背景  

-- 文本颜色  
d[code.EGDC_BUTTON_TEXT] = 0xFFF0E6FF       -- 淡紫文字  
d[code.EGDC_GRAY_TEXT] = 0xFF8888AA         -- 灰紫副文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文字  

-- 交互元素（霓虹紫粉 + 青绿）  
d[code.EGDC_HIGH_LIGHT] = 0xCCD357FF        -- 半透霓虹紫高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFFD357FF     -- 活跃边框（霓虹紫）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题  
d[code.EGDC_INACTIVE_BORDER] = 0x8000FFCC   -- 半透青绿边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8888AA  -- 灰紫标题  

-- 编辑框状态  
d[code.EGDC_EDITABLE] = 0xFF1A1A1A          -- 编辑框背景  
d[code.EGDC_GRAY_EDITABLE] = 0xFF111111     -- 禁用状态  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF00FFCC  -- 聚焦状态（青绿发光）  

-- 辅助元素  
d[code.EGDC_TOOLTIP] = 0xFFF0E6FF           -- 工具提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xE6111111 -- 工具提示背景  
d[code.EGDC_SCROLLBAR] = 0xFFD357FF         -- 滚动条（霓虹紫）  
d[code.EGDC_ICON] = 0xFF00FFCC              -- 图标色（青绿）  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF00FF   -- 高亮图标色（亮紫）  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFD357FF     -- 窗口符号（霓虹紫）  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF555577 -- 灰窗口符号  

return d
