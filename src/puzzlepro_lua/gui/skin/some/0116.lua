
local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（金属质感与深空阴影）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF0A0A14    -- 深空黑
d[code.EGDC_3D_FACE] = 0xFF1E1E2F           -- 深蓝灰金属表面
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF4B4B6A     -- 高光金属蓝灰
d[code.EGDC_3D_LIGHT] = 0xFF333350          -- 轻微高光

-- 界面基础色（冷色调背景）
d[code.EGDC_APP_WORKSPACE] = 0xFF121220     -- 深空背景
d[code.EGDC_WINDOW] = 0xFF1B1B2D            -- 窗口背景

-- 文本颜色（高对比度，确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFFD0D0F0       -- 柔和蓝白文本
d[code.EGDC_GRAY_TEXT] = 0xFF777799         -- 灰蓝次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文本

-- 交互元素（使用霓虹蓝作为强调色）
d[code.EGDC_HIGH_LIGHT] = 0xAA00BFFF        -- 半透明霓虹蓝高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFF00AAFF     -- 活跃边框（霓虹蓝）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFD0D0F0    -- 标题文字
d[code.EGDC_INACTIVE_BORDER] = 0x802A2A4A   -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF666699  -- 非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF222238          -- 编辑框背景
d[code.EGDC_GRAY_EDITABLE] = 0xFF33334D     -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF334466  -- 聚焦状态（轻微蓝光）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFE0E0FF           -- 工具提示文字
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD101028 -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF444477         -- 滚动条
d[code.EGDC_ICON] = 0xFF8888BB             -- 图标色
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF00FFFF   -- 高亮图标（青色）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF5555AA     -- 窗口符号
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF666688 -- 灰色窗口符号

return d
