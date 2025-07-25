local code = require("gui/skin/code")  
local d = {}

-- 3D效果层（画面的明暗层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xFF1A1224     -- 深紫黑色阴影
d[code.EGDC_3D_FACE] = 0xFF2E273D            -- 暗紫色表面
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]
d[code.EGDC_3D_HIGH_LIGHT] = 0xFF5D4C7A      -- 紫灰高光
d[code.EGDC_3D_LIGHT] = 0xFF7A6599           -- 柔和亮紫光

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFF1B1428       -- 深蓝黑背景
d[code.EGDC_WINDOW] = 0xFF2A233D              -- 窗口背景（略亮）

-- 文本颜色（确保可读性）
d[code.EGDC_BUTTON_TEXT] = 0xFFE0D6F0         -- 浅紫色文字
d[code.EGDC_GRAY_TEXT] = 0xFF998BA8           -- 灰紫色次要文本
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF     -- 白色高亮文本

-- 交互元素（使用魔法蓝紫作为强调）
d[code.EGDC_HIGH_LIGHT] = 0xAA6A5AC8          -- 半透明魔幻蓝紫色高亮
d[code.EGDC_ACTIVE_BORDER] = 0xFF5D4C7A       -- 活跃边框（深紫）
d[code.EGDC_ACTIVE_CAPTION] = 0xFFD8C8FF     -- 活跃标题（浅紫白）
d[code.EGDC_INACTIVE_BORDER] = 0x803A2E4E    -- 半透明非活跃边框
d[code.EGDC_INACTIVE_CAPTION] = 0xFF7A6599   -- 非活跃标题（柔和紫）

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFF352E4A            -- 编辑框背景
d[code.EGDC_GRAY_EDITABLE] = 0xFF262036       -- 禁用状态
d[code.EGDC_FOCUSED_EDITABLE] = 0xFF4A3F66   -- 聚焦状态（更深一点）

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFFE0D6F0             -- 工具提示文字
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xDD2E273D -- 工具提示背景
d[code.EGDC_SCROLLBAR] = 0xFF5D4C7A           -- 滚动条
d[code.EGDC_ICON] = 0xFF9B87C4                -- 图标色（淡紫）
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFC8B8FF    -- 高亮图标
d[code.EGDC_WINDOW_SYMBOL] = 0xFF7A6599       -- 窗口符号
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF5D4C7A -- 灰色窗口符号

return d
