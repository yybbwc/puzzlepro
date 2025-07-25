local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（画面的明暗层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF0A1F29     -- 深蓝绿色阴影
d[code.EGDC_3D_FACE] = 0xFFD6ECEB            -- 淡水鸭蓝底面
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF      -- 纯白高光
d[code.EGDC_3D_LIGHT] = 0xFFB0D9D6           -- 浅水鸭蓝高光

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFFE0F2F1      -- 清爽背景色
d[code.EGDC_WINDOW] = 0xFFF5FFFE             -- 窗口背景（近白）

-- 文本颜色（确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFF0A1F29        -- 深蓝绿文本
d[code.EGDC_GRAY_TEXT] = 0xFF5F7D7D          -- 灰蓝次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF    -- 白色高亮文本

-- 交互元素（强调使用水鸭蓝）
d[code.EGDC_HIGH_LIGHT] = 0xAA26A69A         -- 半透水鸭蓝高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFF26A69A      -- 活跃边框（纯水鸭蓝）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF     -- 白色标题
d[code.EGDC_INACTIVE_BORDER] = 0x802E5C5C    -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF5F7D7D   -- 灰蓝非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFFFFAF9           -- 编辑框背景（微白）
d[code.EGDC_GRAY_EDITABLE] = 0xFFD0E8E6      -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFB2DFDB   -- 聚焦状态（淡水鸭蓝）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF0A1F29            -- 工具提示文本
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEED6ECEB -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF5F7D7D          -- 滚动条
d[code.EGDC_ICON] = 0xFF2E5C5C               -- 图标色
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF4DB6AC    -- 高亮图标
d[code.EGDC_WINDOW_SYMBOL] = 0xFF26A69A      -- 窗口符号
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF7FA8A8 -- 灰色窗口符号

return d
