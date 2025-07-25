local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（熔岩金属质感）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF4A1400    -- 深熔岩黑（极暗阴影）
d[code.EGDC_3D_FACE] = 0xFFFF6B00           -- 炽热橙（主体表面）
d[code.EGDC_3D_SHADOW] = 0xFFFF5500         -- 暗橙阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFD700     -- 金黄高光（如太阳耀斑）
d[code.EGDC_3D_LIGHT] = 0xFFFFE4B5          -- 浅金光

-- 界面基础色（烈日背景）
d[code.EGDC_APP_WORKSPACE] = 0xFFFF8C00     -- 烈焰橙背景
d[code.EGDC_WINDOW] = 0xFFFFA500            -- 窗口背景（金橙色）

-- 文本颜色（确保在亮色背景下的可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFF4A1400       -- 深褐黑文字（高对比度）
d[code.EGDC_GRAY_TEXT] = 0xFF8B4513         -- 棕色次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白高亮文本

-- 交互元素（使用烈焰金作为强调色）
d[code.EGDC_HIGH_LIGHT] = 0xAAFFD700        -- 半透明金黄高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFFFFEC8B     -- 活跃边框（淡金）
d[code.EGDC_ACTIVE_CAPTION] = 0xFF4A1400    -- 深褐黑标题
d[code.EGDC_INACTIVE_BORDER] = 0x80FF8C00   -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFFB8860B  -- 古铜金非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFFFEFD5          -- 编辑框背景（象牙白）
d[code.EGDC_GRAY_EDITABLE] = 0xFFFFDAB9     -- 禁用状态（桃色）
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFF8DC  -- 聚焦状态（玉米丝白）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF4A1400           -- 工具提示文字（深褐黑）
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEFFE4B5 -- 工具提示背景（半透明金）
d[code.EGDC_SCROLLBAR] = 0xFFDAA520         -- 滚动条（金色）
d[code.EGDC_ICON] = 0xFF8B4513              -- 图标色（ saddle brown）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF4500   -- 高亮图标（橙红）
d[code.EGDC_WINDOW_SYMBOL] = 0xFFFFD700     -- 窗口符号（金黄）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFD2B48C -- 灰色窗口符号（tan）

return d
