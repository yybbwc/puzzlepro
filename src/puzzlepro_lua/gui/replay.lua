local d = {}

d.MSG_NEW_TURN = true
d.MSG_NEW_PHASE = true
d.MSG_MOVE = true
d.MSG_DRAW = true
d.MSG_CHAINING = true
d.MSG_POS_CHANGE = true
d.MSG_BECOME_TARGET = true
d.MSG_ATTACK = true

d.POS_FACEUP_ATTACK = 0x1
d.POS_FACEUP_DEFENSE = 0x4
d.POS_FACEDOWN_DEFENSE = 0x8
d.POS_FACEUP = 0x5
d.POS_FACEDOWN = 0xa

d[101] = "* "

d[201] = "我方"
d[202] = "对方"

d[301] = "发动"
d[302] = "变成"

d[401] = "「"
d[402] = "」"

d[501] = "进入"

d[601] = "抽卡阶段"
d[602] = "准备阶段"
d[603] = "主要阶段1"
d[604] = "战斗阶段"
d[605] = "主要阶段2"
d[606] = "结束阶段"

d[701] = "手卡区域"
d[702] = "墓地区域"
d[703] = "额外卡组区域"
d[704] = "卡组区域"
d[705] = "除外区域"
d[706] = "怪兽区域"
d[707] = "场地区域"
d[708] = "灵摆区域"
d[709] = "魔法与陷阱区域"
d[710] = "未命名区域"

d[801] = "号格"

d[900 + d.POS_FACEUP_ATTACK] = "表侧攻击表示"
d[900 + d.POS_FACEUP_DEFENSE] = "表侧守备表示"
d[900 + d.POS_FACEDOWN_DEFENSE] = "里侧守备表示"
d[900 + d.POS_FACEUP] = "表侧表示"
d[900 + d.POS_FACEDOWN] = "里侧表示"

return d
