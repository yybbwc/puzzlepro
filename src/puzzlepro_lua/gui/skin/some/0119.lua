local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（竹节纹理质感）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1A3D1A    -- 深竹绿阴影（竹节深处）
d[code.EGDC_3D_FACE] = 0xFF8FBC8F           -- 竹叶绿表面（青竹本色）
d[code.EGDC_3D_SHADOW] = 0xFF66AA66         -- 暗竹绿阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFC1ECC1     -- 浅竹绿高光（阳光透过竹叶）
d[code.EGDC_3D_LIGHT] = 0xFFD8F5D8          -- 柔和绿光

-- 界面基础色（清雅竹林背景）
d[code.EGDC_APP_WORKSPACE] = 0xFFE0F0E0     -- 淡竹青背景
d[code.EGDC_WINDOW] = 0xFFF0FFF0            -- 窗口背景（如竹纸般洁白）

-- 文本颜色（确保在绿色背景下的可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFF1A3D1A       -- 深竹绿文字
d[code.EGDC_GRAY_TEXT] = 0xFF556B2F         -- 暗橄榄绿次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000   -- 纯黑高亮文本

-- 交互元素（使用翠绿作为强调色）
d[code.EGDC_HIGH_LIGHT] = 0xAA3CB371        -- 半透明翠绿高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFF228B22     -- 活跃边框（森林绿）
d[code.EGDC_ACTIVE_CAPTION] = 0xFF1A3D1A    -- 深竹绿标题
d[code.EGDC_INACTIVE_BORDER] = 0x808FBC8F   -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF6B8E23  -- 草绿色非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFF5FFF5          -- 编辑框背景（如竹纸般洁白）
d[code.EGDC_GRAY_EDITABLE] = 0xFFE6F0E6     -- 禁用状态（淡竹青）
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFECF9EC  -- 聚焦状态（清绿色）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF1A3D1A           -- 工具提示文字（深竹绿）
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEED8F5D8 -- 工具提示背景（半透明浅绿）
d[code.EGDC_SCROLLBAR] = 0xFF556B2F         -- 滚动条（暗橄榄绿）
d[code.EGDC_ICON] = 0xFF2E8B57              -- 图标色（海洋绿）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF00FA9A   -- 高亮图标（中春绿色）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF228B22     -- 窗口符号（森林绿）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8FBC8F -- 灰色窗口符号（竹叶绿）

return d
