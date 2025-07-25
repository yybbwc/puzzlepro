local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（模拟像素风格的明暗层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF222028    -- 深灰色阴影（像素黑）
d[code.EGDC_3D_FACE] = 0xFF4A4A5A           -- 像素灰蓝色主体面
d[code.EGDC_3D_SHADOW] = 0xFF3A3A4A         -- 阴影色
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFA0A0B0     -- 高亮灰白
d[code.EGDC_3D_LIGHT] = 0xFF808090          -- 浅灰色高光

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFF181820     -- 深蓝黑色背景（CRT显示器感）
d[code.EGDC_WINDOW] = 0xFF2A2A38            -- 窗口背景（深灰蓝）

-- 文本颜色（确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFFE0E0E0       -- 亮灰色文本
d[code.EGDC_GRAY_TEXT] = 0xFF808080         -- 灰色次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白色高亮文本

-- 交互元素（使用像素游戏经典亮色作为强调）
d[code.EGDC_HIGH_LIGHT] = 0xAA00FFFF        -- 半透明青色高亮（经典像素色）
d[code.EGDC_ACTIVE_BORDER] = 0xFF00FF00     -- 活跃边框（亮绿色）
d[code.EGDC_ACTIVE_CAPTION] = 0xFF00FF00    -- 标题文字（亮绿色）
d[code.EGDC_INACTIVE_BORDER] = 0x80404040   -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF808080  -- 灰色非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF303040          -- 编辑框背景
d[code.EGDC_GRAY_EDITABLE] = 0xFF252530     -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF404050  -- 聚焦状态（稍亮）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF000000           -- 黑色工具提示文字
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xFF00FFFF -- 青色工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF0080FF         -- 滚动条（蓝色）
d[code.EGDC_ICON] = 0xFFC0C0C0              -- 图标颜色（银灰色）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFFF00   -- 高亮图标（黄色）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF00FF00     -- 窗口符号（绿色）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF808080 -- 灰色窗口符号

return d
