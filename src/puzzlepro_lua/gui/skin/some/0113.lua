local code = require("gui/skin/code")  
local d = {}

-- 3D 效果层（增强立体感）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A2E     -- 深蓝黑色阴影
d[code.EGDC_3D_FACE] = 0xFF16213E            -- 深蓝主面
d[code.EGDC_3D_SHADOW] = 0xFF0F3460          -- 中蓝阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFE94560      -- 红色高光（强调）
d[code.EGDC_3D_LIGHT] = 0xFF533483           -- 紫蓝色亮部

-- 界面基础色（营造神秘氛围）
d[code.EGDC_APP_WORKSPACE] = 0xFF0D1B2A      -- 深夜空背景
d[code.EGDC_WINDOW] = 0xFF1B263B             -- 窗口背景（深蓝灰）

-- 文本颜色（确保在深色背景下清晰可读）
d[code.EGDC_BUTTON_TEXT] = 0xFFF1FAFF        -- 冰蓝白文本
d[code.EGDC_GRAY_TEXT] = 0xFF8D99AE          -- 灰蓝次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFD166    -- 黄金高亮文本

-- 交互元素（使用亮色作为焦点）
d[code.EGDC_HIGH_LIGHT] = 0xAAE94560         -- 半透明红色高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFFE94560      -- 活跃边框（亮红）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFD166     -- 活跃标题（金色）
d[code.EGDC_INACTIVE_BORDER] = 0x80533483    -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8D99AE   -- 非活跃标题（灰蓝）

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF222831           -- 编辑框背景（深灰）
d[code.EGDC_GRAY_EDITABLE] = 0xFF393E46      -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF30475E   -- 聚焦状态（偏蓝灰）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFF1FAFF            -- 工具提示文字（冰蓝白）
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xCC16213E -- 半透明工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF533483          -- 滚动条（紫蓝）
d[code.EGDC_ICON] = 0xFF8D99AE               -- 图标色（灰蓝）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFD166    -- 高亮图标（金黄）
d[code.EGDC_WINDOW_SYMBOL] = 0xFFE94560      -- 窗口符号（红）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF4A5773 -- 灰色窗口符号

return d
