local code = require("gui/skin/code")  
local d = {}  
  
-- 基础3D元素（画作的光影层次）  
d[code.EGDC_3D_DARK_SHADOW] = 0xee2D1B0F    -- 深褐色阴影（头发暗部）  
d[code.EGDC_3D_SHADOW] = 0xee5D4037         -- 中褐色阴影（面部轮廓）  
d[code.EGDC_3D_FACE] = 0xeeD2B48C           -- 肌肤色调（主背景）  
d[code.EGDC_3D_HIGH_LIGHT] = 0xffF5DEB3     -- 小麦色高光（面部亮部）  
d[code.EGDC_3D_LIGHT] = 0xFFFFFAF0          -- 象牙白（最亮反光）  
  
-- 背景与工作区（远山朦胧感）  
d[code.EGDC_APP_WORKSPACE] = 0xFF8FBC8F      -- 橄榄绿（背景山色）  
d[code.EGDC_WINDOW] = 0xFF2F4F4F             -- 深石板灰（神秘背景）  
  
-- 文字系统（清晰可读）  
d[code.EGDC_BUTTON_TEXT] = 0xFF8B4513        -- 马鞍棕（主要文字）  
d[code.EGDC_GRAY_TEXT] = 0xFFA0522D          -- 赭石色（次要文字）  
d[code.EGDC_HIGH_LIGHT_TEXT] = 0xFFFFFAF0    -- 象牙白（高亮文字）  
  
-- 交互元素（微笑的温暖）  
d[code.EGDC_HIGH_LIGHT] = 0xaaCD853F         -- 半透明金褐色（选中项）  
d[code.EGDC_ACTIVE_BORDER] = 0xFF8B4513      -- 马鞍棕（活动边框）  
d[code.EGDC_ACTIVE_CAPTION] = 0xFFFFFAF0     -- 象牙白（活动标题）  
d[code.EGDC_INACTIVE_BORDER] = 0x80A0522D    -- 半透明赭石（非活动边框）  
d[code.EGDC_INACTIVE_CAPTION] = 0xFFA0522D   -- 赭石色（非活动标题）  
  
-- 编辑与输入区域  
d[code.EGDC_EDITABLE] = 0xFFF5DEB3           -- 小麦色（编辑框）  
d[code.EGDC_GRAY_EDITABLE] = 0xFFDEB887      -- 浅褐色（禁用状态）  
d[code.EGDC_FOCUSED_EDITABLE] = 0xFFFFFAF0   -- 象牙白（聚焦状态）  
  
-- 辅助元素  
d[code.EGDC_TOOLTIP] = 0xFF8B4513            -- 马鞍棕（提示文字）  
d[code.EGDC_TOOLTIP_BACKGROUND] = 0xeeF5DEB3 -- 半透明小麦色（提示背景）  
d[code.EGDC_SCROLLBAR] = 0xaaCD853F          -- 金褐色滚动条  
d[code.EGDC_ICON] = 0xFFCD853F               -- 金褐色图标  
d[code.EGDC_ICON_HIGH_LIGHT] = 0xFFDAA520    -- 金棒色（高亮图标）  
d[code.EGDC_WINDOW_SYMBOL] = 0xFFCD853F      -- 金褐色窗口符号  
d[code.EGDC_GRAY_WINDOW_SYMBOL] = 0xFFA0522D -- 赭石色（灰色符号）  
  
return d
