local code = require("gui/skin/code")
local d = {}

-- 3D效果层（水墨质感）
d[code.EGDC_3D_DARK_SHADOW] = 0xEE2E222F    -- 黛紫（远山阴影）
d[code.EGDC_3D_FACE]         = 0xEEF0EDE5    -- 牙白（宣纸底色）
d[code.EGDC_3D_SHADOW]       = 0xEEB7A99B    -- 驼色（丝绸暗纹）
d[code.EGDC_3D_HIGH_LIGHT]   = 0xFFF9F7F3    -- 雪纱（高光）
d[code.EGDC_3D_LIGHT]        = 0xFFE8DBCE    -- 米汤（柔光）

-- 界面基础色
d[code.EGDC_APP_WORKSPACE]   = 0xFFE6DFD6    -- 素绢（背景）
d[code.EGDC_WINDOW]          = 0xFFF5F1EB    -- 云母（窗口）

-- 文本颜色（书法墨韵）
d[code.EGDC_BUTTON_TEXT]     = 0xFF4A3C31    -- 乌棕（老墨）
d[code.EGDC_GRAY_TEXT]       = 0xFF8A7B6F    -- 灰茶（褪色字）
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFE84C3D    -- 朱砂（批注色）

-- 交互元素（西域珍宝色）
d[code.EGDC_HIGH_LIGHT]      = 0xAAE84C3D    -- 半透明朱砂
d[code.EGDC_ACTIVE_BORDER]   = 0xFFC27C38    -- 琥珀（活跃边框）
d[code.EGDC_ACTIVE_CAPTION]  = 0xFF8E44AD    -- 紫晶（标题）
d[code.EGDC_INACTIVE_BORDER] = 0x80695C50    -- 青灰（非活跃）
d[code.EGDC_INACTIVE_CAPTION]= 0xFFA87CA0    -- 藕荷（副标题）

-- 编辑框状态（江南瓷色）
d[code.EGDC_EDITABLE]        = 0xFFF0EDE5    -- 白瓷
d[code.EGDC_GRAY_EDITABLE]   = 0xFFD5CDC1    -- 灰瓷
d[code.EGDC_FOCUSED_EDITABLE]= 0xFFE1D4C7    -- 青瓷（聚焦）

-- 辅助元素（细节点缀）
d[code.EGDC_TOOLTIP]         = 0xFF4A3C31    -- 老墨（提示文字）
d[code.EGDC_TOOLTIP_BACKGROUND]=0xEEF0EDE5   -- 宣纸背景
d[code.EGDC_SCROLLBAR]       = 0xFFB7A99B    -- 驼色滚轴
d[code.EGDC_ICON]            = 0xFF8E44AD    -- 紫晶图标
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFC27C38    -- 琥珀高亮
d[code.EGDC_WINDOW_SYMBOL]   = 0xFF4A3C31    -- 乌棕符号
d[code.EGDC_GRAY_WINDOW_SYMBOL]=0xFF8A7B6F   -- 灰茶符号

return d
