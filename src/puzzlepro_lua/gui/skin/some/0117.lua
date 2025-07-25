local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（仿古金属与丝绸质感）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF2D1B14    -- 深红棕阴影（仿古铜锈色）
d[code.EGDC_3D_FACE] = 0xFFF0F0F0           -- 象牙白表面
d[code.EGDC_3D_SHADOW] = 0xFFE0E0E0         -- 浅灰阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFFFFF     -- 纯白高光
d[code.EGDC_3D_LIGHT] = 0xFFFFF8F0          -- 柔和白光

-- 界面基础色（古典与现代结合）
d[code.EGDC_APP_WORKSPACE] = 0xFFE8E8E8     -- 珍珠白背景
d[code.EGDC_WINDOW] = 0xFFF8F8F8            -- 窗口背景（丝绸质感白）

-- 文本颜色（高对比度，确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFF2D1B14       -- 深红棕文字（古典墨色）
d[code.EGDC_GRAY_TEXT] = 0xFF8B7366         -- 灰红棕次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000   -- 纯黑高亮文本

-- 交互元素（使用中国红作为强调色）
d[code.EGDC_HIGH_LIGHT] = 0xAAE30B0B        -- 半透明中国红高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFFD90000     -- 活跃边框（朱砂红）
d[code.EGDC_ACTIVE_CAPTION] = 0xFF2D1B14    -- 深红棕标题
d[code.EGDC_INACTIVE_BORDER] = 0x808B7366   -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFFA08272  -- 灰红棕非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFFFFAF8          -- 编辑框背景（雪白色）
d[code.EGDC_GRAY_EDITABLE] = 0xFFE6D7D0     -- 禁用状态（淡米色）
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFE8E0  -- 聚焦状态（浅粉红）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF2D1B14           -- 工具提示文字（深红棕）
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEED9D9D9 -- 工具提示背景（半透明白）
d[code.EGDC_SCROLLBAR] = 0xFFB8860B         -- 滚动条（古铜金）
d[code.EGDC_ICON] = 0xFF8B4513              -- 图标色（深棕）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFE30B0B   -- 高亮图标（中国红）
d[code.EGDC_WINDOW_SYMBOL] = 0xFFB8860B     -- 窗口符号（古铜金）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0826D -- 灰色窗口符号

return d
