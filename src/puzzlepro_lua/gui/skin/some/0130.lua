local code = require("gui/skin/code")
local d = {}

-- 3D效果层（以洋红为基调的明暗层次）
d[code.EGDC_3D_DARK_SHADOW] = 0xEE6D1A36    -- 潘通 Black 6 C (深紫红阴影)
d[code.EGDC_3D_FACE] = 0xEEF0E6EC           -- 潘通 11-0601 TCX (极地白)
d[code.EGDC_3D_SHADOW] = d[code.EGDC_3D_FACE]
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFF0F5     -- 潘通 12-4303 TCX (粉白高光)
d[code.EGDC_3D_LIGHT] = 0xFFF8D7E7          -- 潘通 12-2103 TCX (柔和粉红)

-- 界面基础色
d[code.EGDC_APP_WORKSPACE] = 0xFFEDE5E8     -- 潘通 13-4102 TCX (灰紫背景)
d[code.EGDC_WINDOW] = 0xFFF5F0F5            -- 潘通 11-0601 TCX (霜白窗口)

-- 文本颜色
d[code.EGDC_BUTTON_TEXT] = 0xFF3D1E2F       -- 潘通 19-1614 TCX (黑醋栗色)
d[code.EGDC_GRAY_TEXT] = 0xFF7D6B77         -- 潘通 18-1705 TCX (灰紫文本)
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFFFF   -- 纯白文本

-- 交互元素（使用非凡洋红作为强调色）
d[code.EGDC_HIGH_LIGHT] = 0xAA9B2D5A        -- 半透明洋红高亮 (潘通 18-1750 TCX)
d[code.EGDC_ACTIVE_BORDER] = 0xFFBB2649     -- 潘通 19-1862 TCX (活跃洋红边框)
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFFFF    -- 白色标题
d[code.EGDC_INACTIVE_BORDER] = 0x806D5B6B   -- 潘通 19-3908 TCX (灰紫非活跃边框)
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8C7D88  -- 潘通 17-1502 TCX (灰紫标题)

-- 编辑框状态
d[code.EGDC_EDITABLE] = 0xFFFFF0F5          -- 粉白编辑背景
d[code.EGDC_GRAY_EDITABLE] = 0xFFE0D5DE     -- 潘通 14-3906 TCX (淡灰紫禁用状态)
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFF0D5E5  -- 潘通 12-2903 TCX (聚焦淡粉)

-- 辅助元素
d[code.EGDC_TOOLTIP] = 0xFF2F1D2B           -- 潘通 19-1611 TCX (深紫黑文本)
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEECE5E8 -- 半透明灰紫背景
d[code.EGDC_SCROLLBAR] = 0xFFA87CA0         -- 潘通 17-2624 TCX (紫丁香色)
d[code.EGDC_ICON] = 0xFFBB2649              -- 与活跃边框同色
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFD95788   -- 潘通 17-1937 TCX (亮洋红)
d[code.EGDC_WINDOW_SYMBOL] = 0xFF6D1A36     -- 潘通 19-1860 TCX (深洋红)
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF9E8E9B -- 潘通 16-3801 TCX (灰紫)

return d
