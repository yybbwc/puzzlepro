local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（明暗层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF2F4F2F     -- 深绿色阴影（类似植物茎干）
d[code.EGDC_3D_FACE] = 0xFF90EE90            -- 浅绿色面（草坪色）
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF      -- 白色高光
d[code.EGDC_3D_LIGHT] = 0xFFE0FFE0           -- 柔和浅绿高光

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFFE6F3E6      -- 清新背景色（类似草坪背景）
d[code.EGDC_WINDOW] = 0xFFF5FFF5             -- 窗口背景（浅绿色）

-- 文本颜色（确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFF006400        -- 深绿色按钮文字（植物主色）
d[code.EGDC_GRAY_TEXT] = 0xFF556B2F          -- 灰绿色次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF    -- 白色高亮文本

-- 交互元素（强调色使用阳光黄和僵尸灰）
d[code.EGDC_HIGH_LIGHT] = 0xAAFFD700         -- 半透明阳光黄高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFF228B22      -- 活跃边框（森林绿）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF     -- 白色标题
d[code.EGDC_INACTIVE_BORDER] = 0x80696969    -- 半透明灰色非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8FBC8F   -- 灰绿色非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFFFFFE0           -- 编辑框背景（浅黄绿色）
d[code.EGDC_GRAY_EDITABLE] = 0xFFD3D3D3      -- 禁用状态（灰色）
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFAFAD2   -- 聚焦状态（淡金黄）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF006400            -- 工具提示文本（深绿）
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xE6F5FFF5 -- 工具提示背景（浅绿白）
d[code.EGDC_SCROLLBAR] = 0xFF556B2F          -- 滚动条（深橄榄绿）
d[code.EGDC_ICON] = 0xFF2F4F4F               -- 图标色（深青灰）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF32CD32    -- 高亮图标（酸橙绿）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF228B22      -- 窗口符号（森林绿）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8FBC8F -- 灰色窗口符号（浅灰绿）

return d
