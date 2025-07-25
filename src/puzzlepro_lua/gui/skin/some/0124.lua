local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（模拟纸张和墨迹的层次感）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1A1A     -- 深墨色阴影
d[code.EGDC_3D_FACE] = 0xFFE8E0D0            -- 米白色纸面
d[code.EGDC_3D_SHADOW] = 0xFFD0C8B8          -- 浅阴影
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFF8F4E8      -- 纸张高光
d[code.EGDC_3D_LIGHT] = 0xFFF0E8D8           -- 柔和光晕

-- 界面基础色（仿古纸张质感）
d[code.EGDC_APP_WORKSPACE] = 0xFFE0D8C8      -- 温暖米黄背景
d[code.EGDC_WINDOW] = 0xFFF5F0E5             -- 窗口背景（宣纸白）

-- 文本颜色（传统墨色层次）
d[code.EGDC_BUTTON_TEXT] = 0xFF2A2A2A        -- 浓墨正文
d[code.EGDC_GRAY_TEXT] = 0xFF6A6A6A          -- 淡墨次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF151515    -- 重墨高亮文字

-- 交互元素（使用朱砂红作为点缀）
d[code.EGDC_HIGH_LIGHT] = 0xAA8B3426         -- 半透明朱砂红
d[code.EGDC_ACTIVE_BORDER] = 0xFF8B3426      -- 活跃边框（朱砂红）
d[code.EGDC_ACTIVE_CAPTION] = 0xFF2A2A2A     -- 浓墨标题
d[code.EGDC_INACTIVE_BORDER] = 0x805A4A3A    -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF6A6A6A   -- 淡墨非活跃标题

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFF8F4E8           -- 编辑框背景（宣纸质感）
d[code.EGDC_GRAY_EDITABLE] = 0xFFE0D8C8      -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFF8E8   -- 聚焦状态（微光）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF151515            -- 工具提示文字（重墨）
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xDDE8E0D0 -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF5A4A3A          -- 滚动条（棕褐色）
d[code.EGDC_ICON] = 0xFF4A3A2A               -- 图标色（淡墨）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFF8B3426    -- 高亮图标（朱砂）
d[code.EGDC_WINDOW_SYMBOL] = 0xFF3A3A3A      -- 窗口符号（中墨）
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF7A7A7A -- 灰色窗口符号（淡墨）

return d
