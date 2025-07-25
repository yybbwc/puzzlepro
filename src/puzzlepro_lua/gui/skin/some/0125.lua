local code = require("gui/skin/code")
local d = {}

-- 3D效果层（花田光影）
d[code.EGDC_3D_DARK_SHADOW] = 0xEE5D7B3E    -- 油菜叶绿（深影）
d[code.EGDC_3D_FACE]         = 0xEEFFF9C4    -- 菜花黄（主色）
d[code.EGDC_3D_SHADOW]       = 0xEEEEDD82    -- 蜜糖黄（过渡）
d[code.EGDC_3D_HIGH_LIGHT]   = 0xFFFFFFE0    -- 花瓣白（高光）
d[code.EGDC_3D_LIGHT]        = 0xFFFEF4A8    -- 阳光黄（亮部）

-- 界面基础色
d[code.EGDC_APP_WORKSPACE]   = 0xFFF5F8E1    -- 春麦（浅绿背景）
d[code.EGDC_WINDOW]          = 0xFFFFFDE7    -- 宣纸（窗口色）

-- 文本颜色（田园意象）
d[code.EGDC_BUTTON_TEXT]     = 0xFF6B8E23    -- 橄榄绿（叶脉字）
d[code.EGDC_GRAY_TEXT]       = 0xFFB8B88D    -- 芦苇灰（辅助字）
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFD2691E    -- 土橙（重点标注）

-- 交互元素（民居元素）
d[code.EGDC_HIGH_LIGHT]      = 0xAAFFD700    -- 金黄花（半透明高亮）
d[code.EGDC_ACTIVE_BORDER]   = 0xFF8B864E    -- 青瓦（活动边框）
d[code.EGDC_ACTIVE_CAPTION]  = 0xFF556B2F    -- 深松绿（标题）
d[code.EGDC_INACTIVE_BORDER] = 0x80C0C090    -- 篱笆灰（非活跃）
d[code.EGDC_INACTIVE_CAPTION]= 0xFFA2A580    -- 苔藓（副标题）

-- 编辑框状态（天空层次）
d[code.EGDC_EDITABLE]        = 0xFFF8F8FF    -- 天青（输入区）
d[code.EGDC_GRAY_EDITABLE]   = 0xFFE0EEDD    -- 雨云灰（禁用）
d[code.EGDC_FOCUSED_EDITABLE]= 0xFFD4E6F4    -- 晴空蓝（聚焦）

-- 辅助元素（自然点缀）
d[code.EGDC_TOOLTIP]         = 0xFF556B2F    -- 深松绿（提示字）
d[code.EGDC_TOOLTIP_BACKGROUND]=0xEEFFF9C4   -- 菜花黄背景
d[code.EGDC_SCROLLBAR]       = 0xFFC0C090    -- 篱笆灰滚轴
d[code.EGDC_ICON]            = 0xFFD2691E    -- 土橙图标
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFFA500    -- 蜜橘高亮
d[code.EGDC_WINDOW_SYMBOL]   = 0xFF6B8E23    -- 橄榄绿符号
d[code.EGDC_GRAY_WINDOW_SYMBOL]=0xFFB8B88D   -- 芦苇灰符号

return d
