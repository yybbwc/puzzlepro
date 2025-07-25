local code = require("gui/skin/code")  
local d = {}  

-- 3D 效果层（柔和光影）  
d[code.EGDC_3D_DARK_SHADOW] = 0xAA8B6F5B    -- 桃灰深阴影  
d[code.EGDC_3D_FACE] = 0xFFF5E4DA           -- 桃雾主面  
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFF9F5     -- 柔白高光  
d[code.EGDC_3D_LIGHT] = 0xFFFFEDE3          -- 桃白亮面  

-- 界面基础色  
d[code.EGDC_APP_WORKSPACE] = 0xFFF2E1D7     -- 桃雾背景  
d[code.EGDC_WINDOW] = 0xFFFFFBF8            -- 窗口背景  

-- 文本颜色  
d[code.EGDC_BUTTON_TEXT] = 0xFF5B3D2E       -- 深桃棕文字  
d[code.EGDC_GRAY_TEXT] = 0xFFA0826D         -- 灰桃副文字  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文字  

-- 交互元素（强调色使用珊瑚红）  
d[code.EGDC_HIGH_LIGHT] = 0xCCF4A39A        -- 半透珊瑚红高亮  
d[code.EGDC_ACTIVE_BORDER] = 0xFFF4A39A     -- 活跃边框（珊瑚红）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题  
d[code.EGDC_INACTIVE_BORDER] = 0x80D1B4A3   -- 半透非活跃边框  
d[code.EGDC_INACTIVE_CAPTION] = 0xFFA0826D  -- 灰桃标题  

-- 编辑框状态  
d[code.EGDC_EDITABLE] = 0xFFFFF9F5          -- 编辑框背景  
d[code.EGDC_GRAY_EDITABLE] = 0xFFEADDD3     -- 灰桃禁用  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFEDE3  -- 聚焦状态  

-- 辅助元素  
d[code.EGDC_TOOLTIP] = 0xFF5B3D2E           -- 工具提示文字  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xE6F5E4DA -- 工具提示背景  
d[code.EGDC_SCROLLBAR] = 0xFFA0826D         -- 滚动条  
d[code.EGDC_ICON] = 0xFF8B6F5B              -- 图标色  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFF4A39A   -- 高亮图标色  
d[code.EGDC_WINDOW_SYMBOL] = 0xFF8B6F5B     -- 窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFC8B5A3 -- 灰窗口符号  

return d
