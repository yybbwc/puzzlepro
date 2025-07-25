local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（画面的明暗层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1B1425    -- 深紫黑阴影（增强立体感）
d[code.EGDC_3D_FACE] = 0xFF2E273D           -- 主体面颜色（深蓝紫色）
d[code.EGDC_3D_SHADOW] = 0xFF241F33         -- 轻微阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF6A5ACD     -- 高光蓝紫色
d[code.EGDC_3D_LIGHT] = 0xFF4B4265          -- 浅紫色高亮

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFF1C162D     -- 深色工作区背景
d[code.EGDC_WINDOW] = 0xFF2A2438            -- 窗口背景（略浅于工作区）

-- 文本颜色（确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFFE0D7FF       -- 柔和淡紫色文本
d[code.EGDC_GRAY_TEXT] = 0xFFA99BB3         -- 灰紫色次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 白色高亮文本

-- 交互元素（使用魔法蓝紫色调作为强调）
d[code.EGDC_HIGH_LIGHT] = 0xAA6A5ACD        -- 半透明高亮蓝紫
d[code.EGDC_ACTIVE_BORDER] = 0xFF5D4BB3     -- 活跃边框（明亮蓝紫）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFD8C9FF    -- 标题文字淡紫色
d[code.EGDC_INACTIVE_BORDER] = 0x803A3252   -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF7B6FA5  -- 灰紫色非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF362F4A          -- 编辑框背景
d[code.EGDC_GRAY_EDITABLE] = 0xFF2B253B     -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF4B4265  -- 聚焦状态（蓝紫色）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFE0D7FF           -- 工具提示文字
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2E273D -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF5D4BB3         -- 滚动条颜色
d[code.EGDC_ICON] = 0xFF8A7DB3              -- 图标颜色（柔和紫色）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFBDAEFF   -- 高亮图标（淡蓝紫）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF7B6FA5     -- 窗口符号颜色
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF5A506E -- 灰色窗口符号

return d
