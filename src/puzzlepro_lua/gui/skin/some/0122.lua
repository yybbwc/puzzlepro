local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（增强立体感）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF0A0614     -- 深蓝黑阴影
d[code.EGDC_3D_FACE] = 0xFF1E1A2E            -- 暗紫蓝主面
d[code.EGDC_3D_SHADOW] = 0xFF151224          -- 暗部阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF4A447A      -- 高光蓝紫色
d[code.EGDC_3D_LIGHT] = 0xFF352F5A           -- 浅一层高光

-- 界面基础色（深色背景 + 对比窗口）
d[code.EGDC_APP_WORKSPACE] = 0xFF0D0A1A      -- 深空背景
d[code.EGDC_WINDOW] = 0xFF1B1732             -- 窗口背景

-- 文本颜色（高对比，确保清晰）
d[code.EGDC_BUTTON_TEXT] = 0xFFE0E0FF        -- 柔光白文本
d[code.EGDC_GRAY_TEXT] = 0xFF8A85B3          -- 灰蓝次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF    -- 纯白高亮文字

-- 交互元素（使用霓虹蓝紫色强调）
d[code.EGDC_HIGH_LIGHT] = 0xAA6A5AC8         -- 半透明霓虹紫
d[code.EGDC_ACTIVE_BORDER] = 0xFF5D52E0      -- 活跃边框（霓虹蓝）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFD0C8FF     -- 活跃标题（淡紫白）
d[code.EGDC_INACTIVE_BORDER] = 0x803A347A    -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF6A649C   -- 非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF221E3A           -- 编辑框背景
d[code.EGDC_GRAY_EDITABLE] = 0xFF1A172E      -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF3A346A   -- 聚焦状态（高亮）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFE0E0FF            -- 工具提示文字
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD1E1A32 -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF4A447A          -- 滚动条
d[code.EGDC_ICON] = 0xFF7A72C8              -- 图标色（柔和紫）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFA098FF   -- 高亮图标（亮紫）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF5D52E0     -- 窗口符号
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF554F80 -- 灰色窗口符号

return d
