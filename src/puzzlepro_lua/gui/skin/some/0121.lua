local code = require("gui/skin/code")
local d = {}

-- 3D效果层（科技感冷色调）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF0A1A2B    -- 深蓝黑阴影
d[code.EGDC_3D_FACE] = 0xFF1E3A5F          -- 主表面色
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF7FBFFF    -- 霓虹蓝高光
d[code.EGDC_3D_LIGHT] = 0xFF3A6EA5         -- 次级高光

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFF0F2035    -- 深蓝背景
d[code.EGDC_WINDOW] = 0xFF162947           -- 窗口背景

-- 文本颜色（高对比度）
d[code.EGDC_BUTTON_TEXT] = 0xFFE0F2FF      -- 浅蓝白文本
d[code.EGDC_GRAY_TEXT] = 0xFF8CA8C7        -- 灰蓝次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF  -- 纯白高亮文本

-- 交互元素（使用霓虹蓝作为强调）
d[code.EGDC_HIGH_LIGHT] = 0xAA00A8FF       -- 半透明霓虹蓝高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFF0078D7    -- 活跃边框（微软蓝）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFA4D8FF   -- 浅蓝标题
d[code.EGDC_INACTIVE_BORDER] = 0x802D517D  -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF6D8CB3 -- 灰蓝非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF1A3150         -- 编辑框背景
d[code.EGDC_GRAY_EDITABLE] = 0xFF0F2540    -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF23456B -- 聚焦状态（带蓝调）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFE0F2FF          -- 工具提示文本
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEE1E3A5F -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF4D7CB5        -- 滚动条
d[code.EGDC_ICON] = 0xFF00A8FF             -- 图标色（霓虹蓝）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF7FBFFF  -- 高亮图标
d[code.EGDC_WINDOW_SYMBOL] = 0xFF0078D7    -- 窗口符号
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF5D8AC2 -- 灰色窗口符号

return d
