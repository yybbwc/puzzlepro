local code = require("gui/skin/code")  
local d = {}  
  
-- 向日葵花瓣层次（主色调系统）  
d[code.EGDC_3D_DARK_SHADOW] = 0xEE8B4513    -- 深土棕色（花茎暗部）  
d[code.EGDC_3D_SHADOW] = 0xEECD853F         -- 秋叶金（中间阴影）  
d[code.EGDC_3D_FACE] = 0xEEFFD700          -- 向日葵黄（主按钮背景）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xFFFFF8DC     -- 奶油黄（高光区域）  
d[code.EGDC_3D_LIGHT] = 0xFFFFFFE0          -- 象牙白（最亮高光）  
  
-- 背景与工作区（画布质感）  
d[code.EGDC_APP_WORKSPACE] = 0xFFF5F5DC     -- 米色画布背景  
d[code.EGDC_WINDOW] = 0xFFFAF0E6            -- 暖白色窗口  
  
-- 文本系统（墨色层次）  
d[code.EGDC_BUTTON_TEXT] = 0xFF2F4F4F       -- 深石板灰（主文本）  
d[code.EGDC_GRAY_TEXT] = 0xFF8B7D6B         -- 褐灰色（禁用文本）  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFF000000   -- 纯黑（高对比度文本）  
  
-- 交互元素（向日葵核心色）  
d[code.EGDC_HIGH_LIGHT] = 0xAAFF8C00        -- 半透明橙黄（高亮背景）  
d[code.EGDC_ACTIVE_BORDER] = 0xFFFF6347     -- 珊瑚橙（活动边框）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFF2F4F4F    -- 深灰（标题文本）  
  
-- 非活动状态（褪色效果）  
d[code.EGDC_INACTIVE_BORDER] = 0x80DEB887   -- 半透明浅卡其（非活动边框）  
d[code.EGDC_INACTIVE_CAPTION] = 0xFF8B7D6B  -- 褐灰（非活动标题）  
  
-- 工具提示（阳光效果）  
d[code.EGDC_TOOLTIP] = 0xFF2F4F4F           -- 深灰文本  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xEEFFFACD -- 柠檬绸背景  
  
-- 滚动条与编辑框  
d[code.EGDC_SCROLLBAR] = 0x80FFD700         -- 半透明金黄滚动条  
d[code.EGDC_EDITABLE] = 0xEEFFF8DC          -- 奶油色编辑框  
d[code.EGDC_GRAY_EDITABLE] = 0xFFF0E68C     -- 卡其色禁用编辑框  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFFE0  -- 象牙白聚焦状态  
  
-- 图标系统（花朵细节色）  
d[code.EGDC_ICON] = 0xFFFF8C00              -- 橙黄图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFFF4500   -- 橙红高亮图标  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFDAA520     -- 金棒黄符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFF8B7D6B -- 褐灰禁用符号  
  
return d
