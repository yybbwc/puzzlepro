Auxiliary = {}
aux = Auxiliary
POS_FACEUP_DEFENCE = POS_FACEUP_DEFENSE
POS_FACEDOWN_DEFENCE = POS_FACEDOWN_DEFENSE
RACE_CYBERS = RACE_CYBERSE
NULL_VALUE = -10

function GetID()
  local offset = self_code < 100000000 and 1 or 100
  return self_table, self_code, offset
end

--the lua version of the bit32 lib, which is deprecated in lua 5.3
bit = {}
function bit.band(a, b)
  return a & b
end
function bit.bor(a, b)
  return a | b
end
function bit.bxor(a, b)
  return a ~ b
end
function bit.lshift(a, b)
  return a << b
end
function bit.rshift(a, b)
  return a >> b
end
function bit.bnot(a)
  return ~a
end
local function fieldargs(f, width)
  local w = width or 1
  assert(f >= 0, "field cannot be negative")
  assert(w > 0, "width must be positive")
  assert(f + w <= 32, "trying to access non-existent bits")
  return f, ~(-1 << w)
end
function bit.extract(r, field, width)
  width = width or 1
  local f, m = fieldargs(field, width)
  return (r >> f) & m
end
function bit.replace(r, v, field, width)
  width = width or 1
  local f, m = fieldargs(field, width)
  return (r & ~(m << f)) | ((v & m) << f)
end

---Subgroup check function
---@param sg Group
---@param c Card|nil
---@param g Group
---@return boolean
Auxiliary.GCheckAdditional = function(sg, c, g)
  return true
end

--the table of xyz number
Auxiliary.xyz_number = {}
function Auxiliary.GetXyzNumber(v)
  local id
  if Auxiliary.GetValueType(v) == "Card" then
    id = v:GetCode()
  end
  if Auxiliary.GetValueType(v) == "number" then
    id = v
  end
  return Auxiliary.xyz_number[id]
end

--iterator for getting playerid of current turn player and the other player
function Auxiliary.TurnPlayers()
  local i = 0
  return function()
    i = i + 1
    if i == 1 then
      return Duel.GetTurnPlayer()
    end
    if i == 2 then
      return 1 - Duel.GetTurnPlayer()
    end
  end
end

Auxiliary.idx_table = table.pack(1, 2, 3, 4, 5, 6, 7, 8)

function Auxiliary.Stringid(code, id)
  return code * 16 + id
end
function Auxiliary.Next(g)
  local first = true
  return function()
    if first then
      first = false
      return g:GetFirst()
    else
      return g:GetNext()
    end
  end
end
function Auxiliary.NULL() end
function Auxiliary.TRUE()
  return true
end
function Auxiliary.FALSE()
  return false
end
function Auxiliary.AND(...)
  local function_list = { ... }
  return function(...)
    local res = false
    for i, f in ipairs(function_list) do
      res = f(...)
      if not res then
        return res
      end
    end
    return res
  end
end
function Auxiliary.OR(...)
  local function_list = { ... }
  return function(...)
    local res = false
    for i, f in ipairs(function_list) do
      res = f(...)
      if res then
        return res
      end
    end
    return res
  end
end
function Auxiliary.NOT(f)
  return function(...)
    return not f(...)
  end
end
function Auxiliary.BeginPuzzle(effect)
  local e1 = Effect.GlobalEffect()
  e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(EVENT_TURN_END)
  e1:SetCountLimit(1)
  e1:SetOperation(Auxiliary.PuzzleOp)
  Duel.RegisterEffect(e1, 0)
  local e2 = Effect.GlobalEffect()
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e2:SetCode(EFFECT_SKIP_DP)
  e2:SetTargetRange(1, 0)
  Duel.RegisterEffect(e2, 0)
  local e3 = Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e3:SetCode(EFFECT_SKIP_SP)
  e3:SetTargetRange(1, 0)
  Duel.RegisterEffect(e3, 0)
end
function Auxiliary.PuzzleOp(e, tp)
  Duel.SetLP(0, 0)
end
---Duel.SelectOption with option condition
---Return value starts from 1, different from Duel.SelectOption
---@param tp integer
---@param ... table {condition, option[, value]}
---@return integer
function Auxiliary.SelectFromOptions(tp, ...)
  local options = { ... }
  local ops = {}
  local opvals = {}
  for i = 1, #options do
    if options[i][1] then
      table.insert(ops, options[i][2])
      table.insert(opvals, options[i][3] or i)
    end
  end
  if #ops == 0 then
    return nil
  end
  local select = Duel.SelectOption(tp, table.unpack(ops))
  return opvals[select + 1]
end
--register effect of return to hand for Spirit monsters
function Auxiliary.EnableSpiritReturn(c, event1, ...)
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(event1)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e1:SetOperation(Auxiliary.SpiritReturnReg)
  c:RegisterEffect(e1)
  for i, event in ipairs({ ... }) do
    local e2 = e1:Clone()
    e2:SetCode(event)
    c:RegisterEffect(e2)
  end
end
function Auxiliary.SpiritReturnReg(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
  e1:SetDescription(1104)
  e1:SetCategory(CATEGORY_TOHAND)
  e1:SetCode(EVENT_PHASE + PHASE_END)
  e1:SetRange(LOCATION_MZONE)
  e1:SetCountLimit(1)
  e1:SetReset(RESET_EVENT + 0xd7e0000 + RESET_PHASE + PHASE_END)
  e1:SetCondition(Auxiliary.SpiritReturnConditionForced)
  e1:SetTarget(Auxiliary.SpiritReturnTargetForced)
  e1:SetOperation(Auxiliary.SpiritReturnOperation)
  c:RegisterEffect(e1)
  local e2 = e1:Clone()
  e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
  e2:SetCondition(Auxiliary.SpiritReturnConditionOptional)
  e2:SetTarget(Auxiliary.SpiritReturnTargetOptional)
  c:RegisterEffect(e2)
end
function Auxiliary.SpiritReturnConditionForced(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return not c:IsHasEffect(EFFECT_SPIRIT_DONOT_RETURN) and not c:IsHasEffect(EFFECT_SPIRIT_MAYNOT_RETURN)
end
function Auxiliary.SpiritReturnTargetForced(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return true
  end
  Duel.SetOperationInfo(0, CATEGORY_TOHAND, e:GetHandler(), 1, 0, 0)
end
function Auxiliary.SpiritReturnConditionOptional(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return not c:IsHasEffect(EFFECT_SPIRIT_DONOT_RETURN) and c:IsHasEffect(EFFECT_SPIRIT_MAYNOT_RETURN)
end
function Auxiliary.SpiritReturnTargetOptional(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return e:GetHandler():IsAbleToHand()
  end
  Duel.SetOperationInfo(0, CATEGORY_TOHAND, e:GetHandler(), 1, 0, 0)
end
function Auxiliary.SpiritReturnOperation(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  if c:IsRelateToEffect(e) then
    Duel.SendtoHand(c, nil, REASON_EFFECT)
  end
end
function Auxiliary.EnableNeosReturn(c, operation, set_category)
  --return
  local e1 = Effect.CreateEffect(c)
  e1:SetDescription(1193)
  e1:SetCategory(CATEGORY_TODECK)
  e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_PHASE + PHASE_END)
  e1:SetRange(LOCATION_MZONE)
  e1:SetCountLimit(1)
  e1:SetCondition(Auxiliary.NeosReturnConditionForced)
  e1:SetTarget(Auxiliary.NeosReturnTargetForced(set_category))
  e1:SetOperation(operation)
  c:RegisterEffect(e1)
  local e2 = e1:Clone()
  e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
  e2:SetCondition(Auxiliary.NeosReturnConditionOptional)
  e2:SetTarget(Auxiliary.NeosReturnTargetOptional(set_category))
  c:RegisterEffect(e2)
  return e1, e2
end
function Auxiliary.NeosReturnConditionForced(e, tp, eg, ep, ev, re, r, rp)
  return not e:GetHandler():IsHasEffect(42015635)
end
function Auxiliary.NeosReturnTargetForced(set_category)
  return function(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
      return true
    end
    Duel.SetOperationInfo(0, CATEGORY_TODECK, e:GetHandler(), 1, 0, 0)
    if set_category then
      set_category(e, tp, eg, ep, ev, re, r, rp)
    end
  end
end
function Auxiliary.NeosReturnConditionOptional(e, tp, eg, ep, ev, re, r, rp)
  return e:GetHandler():IsHasEffect(42015635)
end
function Auxiliary.NeosReturnTargetOptional(set_category)
  return function(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
      return e:GetHandler():IsAbleToExtra()
    end
    Duel.SetOperationInfo(0, CATEGORY_TODECK, e:GetHandler(), 1, 0, 0)
    if set_category then
      set_category(e, tp, eg, ep, ev, re, r, rp)
    end
  end
end
---add "Toss a coin and get the following effects" effect to Arcana Force monsters
---@param c Card
---@param event1 integer
---@param ... integer
function Auxiliary.EnableArcanaCoin(c, event1, ...)
  local e1 = Effect.CreateEffect(c)
  e1:SetDescription(1623)
  e1:SetCategory(CATEGORY_COIN)
  e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(event1)
  e1:SetTarget(Auxiliary.ArcanaCoinTarget)
  e1:SetOperation(Auxiliary.ArcanaCoinOperation)
  c:RegisterEffect(e1)
  for _, event in ipairs({ ... }) do
    local e2 = e1:Clone()
    e2:SetCode(event)
    c:RegisterEffect(e2)
  end
end
function Auxiliary.ArcanaCoinTarget(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return true
  end
  Duel.SetOperationInfo(0, CATEGORY_COIN, nil, 0, tp, 1)
end
function Auxiliary.ArcanaCoinOperation(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local res = 0
  local toss = false
  if Duel.IsPlayerAffectedByEffect(tp, 73206827) then
    res = 1 - Duel.SelectOption(tp, 60, 61)
  else
    res = Duel.TossCoin(tp, 1)
    toss = true
  end
  if not c:IsRelateToEffect(e) or c:IsFacedown() then
    return
  end
  if toss then
    c:RegisterFlagEffect(FLAG_ID_REVERSAL_OF_FATE, RESET_EVENT + RESETS_STANDARD, 0, 1)
  end
  c:RegisterFlagEffect(FLAG_ID_ARCANA_COIN, RESET_EVENT + RESETS_STANDARD, EFFECT_FLAG_CLIENT_HINT, 1, res, 63 - res)
end
---condition of Arcana Force monster effect from coin toss
---@param e Effect
---@return boolean
function Auxiliary.ArcanaCondition(e)
  return e:GetHandler():GetFlagEffect(FLAG_ID_ARCANA_COIN) > 0
end
function Auxiliary.IsUnionState(effect)
  local c = effect:GetHandler()
  return c:IsHasEffect(EFFECT_UNION_STATUS) and c:GetEquipTarget()
end
--set EFFECT_EQUIP_LIMIT after equipping
function Auxiliary.SetUnionState(c)
  local eset = { c:IsHasEffect(EFFECT_UNION_LIMIT) }
  if #eset == 0 then
    return
  end
  local e0 = Effect.CreateEffect(c)
  e0:SetType(EFFECT_TYPE_SINGLE)
  e0:SetCode(EFFECT_EQUIP_LIMIT)
  e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e0:SetValue(eset[1]:GetValue())
  e0:SetReset(RESET_EVENT + RESETS_STANDARD)
  c:RegisterEffect(e0)
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_UNION_STATUS)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e1:SetReset(RESET_EVENT + RESETS_STANDARD)
  c:RegisterEffect(e1)
  if c.old_union then
    local e2 = e1:Clone()
    e2:SetCode(EFFECT_OLDUNION_STATUS)
    c:RegisterEffect(e2)
  end
end
--uc: the union monster to be equipped, tc: the target monster
function Auxiliary.CheckUnionEquip(uc, tc, exclude_modern_count)
  local modern_count, old_count = tc:GetUnionCount()
  if exclude_modern_count then
    modern_count = modern_count - exclude_modern_count
  end
  if uc.old_union then
    return modern_count == 0
  else
    return old_count == 0
  end
end
--EFFECT_DESTROY_SUBSTITUTE filter for modern union monsters
function Auxiliary.UnionReplaceFilter(e, re, r, rp)
  return r & (REASON_BATTLE + REASON_EFFECT) ~= 0
end
---add effect to modern union monsters
---@param c Card
---@param filter function
function Auxiliary.EnableUnionAttribute(c, filter)
  local equip_limit = Auxiliary.UnionEquipLimit(filter)
  --destroy sub
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_EQUIP)
  e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
  e1:SetCode(EFFECT_DESTROY_SUBSTITUTE)
  e1:SetValue(Auxiliary.UnionReplaceFilter)
  c:RegisterEffect(e1)
  --limit
  local e2 = Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_UNION_LIMIT)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetValue(equip_limit)
  c:RegisterEffect(e2)
  --equip
  local equip_filter = Auxiliary.UnionEquipFilter(filter)
  local e3 = Effect.CreateEffect(c)
  e3:SetDescription(1068)
  e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e3:SetCategory(CATEGORY_EQUIP)
  e3:SetType(EFFECT_TYPE_IGNITION)
  e3:SetRange(LOCATION_MZONE)
  e3:SetTarget(Auxiliary.UnionEquipTarget(equip_filter))
  e3:SetOperation(Auxiliary.UnionEquipOperation(equip_filter))
  c:RegisterEffect(e3)
  --unequip
  local e4 = Effect.CreateEffect(c)
  e4:SetDescription(1152)
  e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e4:SetType(EFFECT_TYPE_IGNITION)
  e4:SetRange(LOCATION_SZONE)
  e4:SetTarget(Auxiliary.UnionUnequipTarget)
  e4:SetOperation(Auxiliary.UnionUnequipOperation)
  c:RegisterEffect(e4)
end
function Auxiliary.UnionEquipFilter(filter)
  return function(c, tp)
    local ct1, ct2 = c:GetUnionCount()
    return c:IsFaceup() and ct2 == 0 and c:IsControler(tp) and filter(c)
  end
end
function Auxiliary.UnionEquipLimit(filter)
  return function(e, c)
    return (c:IsControler(e:GetHandlerPlayer()) and filter(c)) or e:GetHandler():GetEquipTarget() == c
  end
end
function Auxiliary.UnionEquipTarget(equip_filter)
  return function(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local c = e:GetHandler()
    if chkc then
      return chkc:IsLocation(LOCATION_MZONE) and equip_filter(chkc, tp)
    end
    if chk == 0 then
      return c:GetFlagEffect(FLAG_ID_UNION) == 0 and Duel.GetLocationCount(tp, LOCATION_SZONE) > 0 and Duel.IsExistingTarget(equip_filter, tp, LOCATION_MZONE, 0, 1, c, tp)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_EQUIP)
    local g = Duel.SelectTarget(tp, equip_filter, tp, LOCATION_MZONE, 0, 1, 1, c, tp)
    Duel.SetOperationInfo(0, CATEGORY_EQUIP, g, 1, 0, 0)
    c:RegisterFlagEffect(FLAG_ID_UNION, RESET_EVENT + 0x7e0000 + RESET_PHASE + PHASE_END, 0, 1)
  end
end
function Auxiliary.UnionEquipOperation(equip_filter)
  return function(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local tc = Duel.GetFirstTarget()
    if not c:IsRelateToEffect(e) or c:IsFacedown() then
      return
    end
    if not tc:IsRelateToEffect(e) or not equip_filter(tc, tp) then
      Duel.SendtoGrave(c, REASON_RULE)
      return
    end
    if not Duel.Equip(tp, c, tc, false) then
      return
    end
    Auxiliary.SetUnionState(c)
  end
end
function Auxiliary.UnionUnequipTarget(e, tp, eg, ep, ev, re, r, rp, chk)
  local c = e:GetHandler()
  if chk == 0 then
    return c:GetFlagEffect(FLAG_ID_UNION) == 0 and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0 and c:GetEquipTarget() and c:IsCanBeSpecialSummoned(e, 0, tp, true, false)
  end
  Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, c, 1, 0, 0)
  c:RegisterFlagEffect(FLAG_ID_UNION, RESET_EVENT + 0x7e0000 + RESET_PHASE + PHASE_END, 0, 1)
end
function Auxiliary.UnionUnequipOperation(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  if not c:IsRelateToEffect(e) then
    return
  end
  Duel.SpecialSummon(c, 0, tp, tp, true, false, POS_FACEUP)
end
function Auxiliary.EnableChangeCode(c, code, location, condition)
  Auxiliary.AddCodeList(c, code)
  local loc = c:GetOriginalType() & TYPE_MONSTER ~= 0 and LOCATION_MZONE or LOCATION_SZONE
  loc = location or loc
  if condition == nil then
    condition = Auxiliary.TRUE
  end
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
  e1:SetCode(EFFECT_CHANGE_CODE)
  e1:SetRange(loc)
  e1:SetCondition(condition)
  e1:SetValue(code)
  c:RegisterEffect(e1)
  return e1
end
function Auxiliary.TargetEqualFunction(f, value, ...)
  local ext_params = { ... }
  return function(effect, target)
    return f(target, table.unpack(ext_params)) == value
  end
end
function Auxiliary.TargetBoolFunction(f, ...)
  local ext_params = { ... }
  return function(effect, target)
    return f(target, table.unpack(ext_params))
  end
end
function Auxiliary.FilterEqualFunction(f, value, ...)
  local ext_params = { ... }
  return function(target)
    return f(target, table.unpack(ext_params)) == value
  end
end
function Auxiliary.FilterBoolFunction(f, ...)
  local ext_params = { ... }
  return function(target)
    return f(target, table.unpack(ext_params))
  end
end
function Auxiliary.GetValueType(v)
  local t = type(v)
  if t == "userdata" then
    local mt = getmetatable(v)
    if mt == Group then
      return "Group"
    elseif mt == Effect then
      return "Effect"
    else
      return "Card"
    end
  else
    return t
  end
end
--Extra Deck summon count
function Auxiliary.EnableExtraDeckSummonCountLimit()
  if Auxiliary.ExtraDeckSummonCountLimit ~= nil then
    return
  end
  Auxiliary.ExtraDeckSummonCountLimit = {}
  Auxiliary.ExtraDeckSummonCountLimit[0] = 1
  Auxiliary.ExtraDeckSummonCountLimit[1] = 1
  local ge1 = Effect.GlobalEffect()
  ge1:SetType(EFFECT_TYPE_CONTINUOUS + EFFECT_TYPE_FIELD)
  ge1:SetCode(EVENT_PHASE_START + PHASE_DRAW)
  ge1:SetOperation(Auxiliary.ExtraDeckSummonCountLimitReset)
  Duel.RegisterEffect(ge1, 0)
end
function Auxiliary.ExtraDeckSummonCountLimitReset()
  Auxiliary.ExtraDeckSummonCountLimit[0] = 1
  Auxiliary.ExtraDeckSummonCountLimit[1] = 1
end
--Fusion Monster is unnecessary to use this
function Auxiliary.AddMaterialCodeList(c, ...)
  if c:IsStatus(STATUS_COPYING_EFFECT) then
    return
  end
  local mat = {}
  for _, code in ipairs({ ... }) do
    mat[code] = true
  end
  if c.material == nil then
    local mt = getmetatable(c)
    mt.material = mat
  end
  for index, _ in pairs(mat) do
    Auxiliary.AddCodeList(c, index)
  end
end
function Auxiliary.IsMaterialListCode(c, code)
  return c.material and c.material[code]
end
function Auxiliary.IsMaterialListSetCard(c, setcode)
  if not c.material_setcode then
    return false
  end
  if type(c.material_setcode) == "table" then
    for i, scode in ipairs(c.material_setcode) do
      if setcode & 0xfff == scode & 0xfff and setcode & scode == setcode then
        return true
      end
    end
  else
    return setcode & 0xfff == c.material_setcode & 0xfff and setcode & c.material_setcode == setcode
  end
  return false
end
function Auxiliary.IsMaterialListType(c, type)
  return c.material_type and type & c.material_type == type
end
function Auxiliary.GetMaterialListCount(c)
  if not c.material_count then
    return 0, 0
  end
  return c.material_count[1], c.material_count[2]
end
function Auxiliary.AddCodeList(c, ...)
  if c:IsStatus(STATUS_COPYING_EFFECT) then
    return
  end
  if c.card_code_list == nil then
    local mt = getmetatable(c)
    mt.card_code_list = {}
    for _, code in ipairs({ ... }) do
      mt.card_code_list[code] = true
    end
  else
    for _, code in ipairs({ ... }) do
      c.card_code_list[code] = true
    end
  end
end
function Auxiliary.IsCodeListed(c, code)
  return c.card_code_list and c.card_code_list[code]
end
function Auxiliary.IsCodeOrListed(c, code)
  return c:IsCode(code) or Auxiliary.IsCodeListed(c, code)
end
function Auxiliary.AddSetNameMonsterList(c, ...)
  if c:IsStatus(STATUS_COPYING_EFFECT) then
    return
  end
  if c.setcode_monster_list == nil then
    local mt = getmetatable(c)
    mt.setcode_monster_list = {}
    for i, scode in ipairs({ ... }) do
      mt.setcode_monster_list[i] = scode
    end
  else
    for i, scode in ipairs({ ... }) do
      c.setcode_monster_list[i] = scode
    end
  end
end
function Auxiliary.IsSetNameMonsterListed(c, setcode)
  if not c.setcode_monster_list then
    return false
  end
  for i, scode in ipairs(c.setcode_monster_list) do
    if setcode & 0xfff == scode & 0xfff and setcode & scode == setcode then
      return true
    end
  end
  return false
end
function Auxiliary.IsCounterAdded(c, counter)
  if not c.counter_add_list then
    return false
  end
  for i, ccounter in ipairs(c.counter_add_list) do
    if counter == ccounter then
      return true
    end
  end
  return false
end
function Auxiliary.IsTypeInText(c, type)
  return c.has_text_type and type & c.has_text_type == type
end
function Auxiliary.GetAttributeCount(g)
  if #g == 0 then
    return 0
  end
  local att = 0
  for tc in Auxiliary.Next(g) do
    att = att | tc:GetAttribute()
  end
  local ct = 0
  while att ~= 0 do
    if att & 0x1 ~= 0 then
      ct = ct + 1
    end
    att = att >> 1
  end
  return ct
end
function Auxiliary.IsInGroup(c, g)
  return g:IsContains(c)
end
--Get the row index (from the viewpoint of controller)
function Auxiliary.GetLocalRow(location, sequence)
  if location == LOCATION_SZONE then
    if 0 <= sequence and sequence <= 4 then
      return 0
    else
      return NULL_VALUE
    end
  elseif location == LOCATION_MZONE then
    if 0 <= sequence and sequence <= 4 then
      return 1
    elseif 5 <= sequence and sequence <= 6 then
      return 2
    else
      return NULL_VALUE
    end
  else
    return NULL_VALUE
  end
end
--Get the global row index (from the viewpoint of 0)
function Auxiliary.GetGlobalRow(p, location, sequence)
  local row = Auxiliary.GetLocalRow(location, sequence)
  if row < 0 then
    return NULL_VALUE
  end
  if p == 0 then
    return row
  else
    return 4 - row
  end
end
--Get the column index (from the viewpoint of controller)
function Auxiliary.GetLocalColumn(location, sequence)
  if location == LOCATION_SZONE then
    if 0 <= sequence and sequence <= 4 then
      return sequence
    else
      return NULL_VALUE
    end
  elseif location == LOCATION_MZONE then
    if 0 <= sequence and sequence <= 4 then
      return sequence
    elseif sequence == 5 then
      return 1
    elseif sequence == 6 then
      return 3
    else
      return NULL_VALUE
    end
  else
    return NULL_VALUE
  end
end
--Get the global column index (from the viewpoint of 0)
function Auxiliary.GetGlobalColumn(p, location, sequence)
  local column = Auxiliary.GetLocalColumn(location, sequence)
  if column < 0 then
    return NULL_VALUE
  end
  if p == 0 then
    return column
  else
    return 4 - column
  end
end
---Get the global row and column index of c
---@param c Card
---@return integer
---@return integer
function Auxiliary.GetFieldIndex(c)
  local cp = c:GetControler()
  local loc = c:GetLocation()
  local seq = c:GetSequence()
  return Auxiliary.GetGlobalRow(cp, loc, seq), Auxiliary.GetGlobalColumn(cp, loc, seq)
end
---Check if c is adjacent to (i,j)
---@param c Card
---@param i integer
---@param j integer
---@return boolean
function Auxiliary.AdjacentFilter(c, i, j)
  local row, column = Auxiliary.GetFieldIndex(c)
  if row < 0 or column < 0 then
    return false
  end
  return (row == i and math.abs(column - j) == 1) or (math.abs(row - i) == 1 and column == j)
end
---Get the card group adjacent to (i,j)
---@param tp integer
---@param location1 integer
---@param location2 integer
---@param i integer
---@param j integer
---@return Group
function Auxiliary.GetAdjacentGroup(tp, location1, location2, i, j)
  return Duel.GetMatchingGroup(Auxiliary.AdjacentFilter, tp, location1, location2, nil, i, j)
end
---Get the column index of card c (from the viewpoint of p)
---@param c Card
---@param p? integer default: 0
---@return integer
function Auxiliary.GetColumn(c, p)
  p = p or 0
  local cp = c:GetControler()
  local loc = c:GetLocation()
  local seq = c:GetSequence()
  local column = Auxiliary.GetGlobalColumn(cp, loc, seq)
  if column < 0 then
    return NULL_VALUE
  end
  if p == 0 then
    return column
  else
    return 4 - column
  end
end
--return the column of monster zone seq (from the viewpoint of controller)
function Auxiliary.MZoneSequence(seq)
  return Auxiliary.GetLocalColumn(LOCATION_MZONE, seq)
end
--return the column of spell/trap zone seq (from the viewpoint of controller)
function Auxiliary.SZoneSequence(seq)
  return Auxiliary.GetLocalColumn(LOCATION_SZONE, seq)
end
--generate the value function of EFFECT_CHANGE_BATTLE_DAMAGE on monsters
function Auxiliary.ChangeBattleDamage(player, value)
  return function(e, damp)
    if player == 0 then
      if e:GetOwnerPlayer() == damp then
        return value
      else
        return -1
      end
    elseif player == 1 then
      if e:GetOwnerPlayer() == 1 - damp then
        return value
      else
        return -1
      end
    end
  end
end
--filter for "negate the effects of a face-up monster" (無限泡影/Infinite Impermanence)
function Auxiliary.NegateMonsterFilter(c)
  return c:IsFaceup() and not c:IsDisabled() and (c:IsType(TYPE_EFFECT) or c:GetOriginalType() & TYPE_EFFECT ~= 0)
end
--filter for "negate the effects of an Effect Monster" (エフェクト・ヴェーラー/Effect Veiler)
function Auxiliary.NegateEffectMonsterFilter(c)
  return c:IsFaceup() and not c:IsDisabled() and c:IsType(TYPE_EFFECT)
end
--filter for "negate the effects of a face-up card"
function Auxiliary.NegateAnyFilter(c)
  if c:IsType(TYPE_TRAPMONSTER) then
    return c:IsFaceup()
  elseif c:IsType(TYPE_SPELL + TYPE_TRAP) then
    return c:IsFaceup() and not c:IsDisabled()
  else
    return Auxiliary.NegateMonsterFilter(c)
  end
end
--alias for compatibility
Auxiliary.disfilter1 = Auxiliary.NegateAnyFilter
--condition of EVENT_BATTLE_DESTROYING
function Auxiliary.bdcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return c:IsRelateToBattle()
end
--condition of EVENT_BATTLE_DESTROYING + opponent monster
function Auxiliary.bdocon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE)
end
--condition of EVENT_BATTLE_DESTROYING + to_grave
function Auxiliary.bdgcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local bc = c:GetBattleTarget()
  return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
--condition of EVENT_BATTLE_DESTROYING + opponent monster + to_grave
function Auxiliary.bdogcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local bc = c:GetBattleTarget()
  return c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE) and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
--condition of EVENT_DAMAGE_STEP_END + this monster is releate to battle
function Auxiliary.dsercon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return c:IsRelateToBattle() or c:IsStatus(STATUS_BATTLE_DESTROYED)
end
--condition of EVENT_TO_GRAVE + destroyed by opponent
function Auxiliary.dogcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return c:IsPreviousControler(tp) and c:IsReason(REASON_DESTROY) and rp == 1 - tp
end
--condition of EVENT_TO_GRAVE + destroyed by opponent + from field
function Auxiliary.dogfcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp) and c:IsReason(REASON_DESTROY) and rp == 1 - tp
end
--condition of "except the turn this card was sent to the Graveyard"
function Auxiliary.exccon(e)
  return Duel.GetTurnCount() ~= e:GetHandler():GetTurnID() or e:GetHandler():IsReason(REASON_RETURN)
end
--condition of checking battle phase availability
function Auxiliary.bpcon(e, tp, eg, ep, ev, re, r, rp)
  return Duel.IsAbleToEnterBP() or (Duel.GetCurrentPhase() >= PHASE_BATTLE_START and Duel.GetCurrentPhase() <= PHASE_BATTLE)
end
--condition of free chain effects changing ATK/DEF
function Auxiliary.dscon(e, tp, eg, ep, ev, re, r, rp)
  return Duel.GetCurrentPhase() ~= PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
--flag effect for spell counter
function Auxiliary.chainreg(e, tp, eg, ep, ev, re, r, rp)
  if e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING) == 0 then
    e:GetHandler():RegisterFlagEffect(FLAG_ID_CHAINING, RESET_EVENT + RESETS_STANDARD - RESET_TURN_SET + RESET_CHAIN, 0, 1)
  end
end
--default filter for EFFECT_CANNOT_BE_BATTLE_TARGET
function Auxiliary.imval1(e, c)
  return not c:IsImmuneToEffect(e)
end
--filter for EFFECT_INDESTRUCTABLE_EFFECT + self
function Auxiliary.indsval(e, re, rp)
  return rp == e:GetHandlerPlayer()
end
--filter for EFFECT_INDESTRUCTABLE_EFFECT + opponent
function Auxiliary.indoval(e, re, rp)
  return rp == 1 - e:GetHandlerPlayer()
end
--filter for EFFECT_CANNOT_BE_EFFECT_TARGET + self
function Auxiliary.tgsval(e, re, rp)
  return rp == e:GetHandlerPlayer()
end
--filter for EFFECT_CANNOT_BE_EFFECT_TARGET + opponent
function Auxiliary.tgoval(e, re, rp)
  return rp == 1 - e:GetHandlerPlayer()
end
--filter for non-zero ATK
function Auxiliary.nzatk(c)
  return c:IsFaceup() and c:GetAttack() > 0
end
--filter for non-zero DEF
function Auxiliary.nzdef(c)
  return c:IsFaceup() and c:GetDefense() > 0
end
--flag effect for summon/sp_summon turn
function Auxiliary.sumreg(e, tp, eg, ep, ev, re, r, rp)
  local tc = eg:GetFirst()
  local code = e:GetLabel()
  while tc do
    if tc:GetOriginalCode() == code then
      tc:RegisterFlagEffect(code, RESET_EVENT + RESETS_STANDARD + RESET_PHASE + PHASE_END, 0, 1)
    end
    tc = eg:GetNext()
  end
end
--for EVENT_BE_MATERIAL effect releated to the summoned monster
function Auxiliary.CreateMaterialReasonCardRelation(c, te)
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(EVENT_BE_MATERIAL)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e1:SetOperation(Auxiliary.MaterialReasonCardReg)
  e1:SetLabelObject(te)
  c:RegisterEffect(e1)
end
function Auxiliary.MaterialReasonCardReg(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local te = e:GetLabelObject()
  c:GetReasonCard():CreateEffectRelation(te)
end
--the player tp has token on the field
function Auxiliary.tkfcon(e, tp)
  if tp == nil and e ~= nil then
    tp = e:GetHandlerPlayer()
  end
  return Duel.IsExistingMatchingCard(Card.IsType, tp, LOCATION_ONFIELD, 0, 1, nil, TYPE_TOKEN)
end
--effects inflicting damage to tp
function Auxiliary.damcon1(e, tp, eg, ep, ev, re, r, rp)
  local e1 = Duel.IsPlayerAffectedByEffect(tp, EFFECT_REVERSE_DAMAGE)
  local e2 = Duel.IsPlayerAffectedByEffect(tp, EFFECT_REVERSE_RECOVER)
  local rd = e1 and not e2
  local rr = not e1 and e2
  local ex, cg, ct, cp, cv = Duel.GetOperationInfo(ev, CATEGORY_DAMAGE)
  if ex and (cp == tp or cp == PLAYER_ALL) and not rd and not Duel.IsPlayerAffectedByEffect(tp, EFFECT_NO_EFFECT_DAMAGE) then
    return true
  end
  ex, cg, ct, cp, cv = Duel.GetOperationInfo(ev, CATEGORY_RECOVER)
  return ex and (cp == tp or cp == PLAYER_ALL) and rr and not Duel.IsPlayerAffectedByEffect(tp, EFFECT_NO_EFFECT_DAMAGE)
end
--filter for the immune effect of qli monsters
function Auxiliary.qlifilter(e, te)
  if te:IsActiveType(TYPE_MONSTER) and te:IsActivated() then
    local lv = e:GetHandler():GetLevel()
    local ec = te:GetOwner()
    if ec:IsType(TYPE_LINK) then
      return false
    elseif ec:IsType(TYPE_XYZ) then
      return ec:GetOriginalRank() < lv
    else
      return ec:GetOriginalLevel() < lv
    end
  else
    return false
  end
end
--sp_summon condition for gladiator beast monsters
function Auxiliary.gbspcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local typ = c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)
  return c:IsSummonType(SUMMON_VALUE_GLADIATOR) or (typ & TYPE_MONSTER ~= 0 and c:IsSpecialSummonSetCard(0x1019))
end
--sp_summon condition for evolsaur monsters
function Auxiliary.evospcon(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  local typ = c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)
  return c:IsSummonType(SUMMON_VALUE_EVOLTILE) or (typ & TYPE_MONSTER ~= 0 and c:IsSpecialSummonSetCard(0x304e))
end
--filter for necro_valley test
function Auxiliary.NecroValleyFilter(f)
  return function(target, ...)
    return (not f or f(target, ...)) and not target:IsHasEffect(EFFECT_NECRO_VALLEY)
  end
end
--Necrovalley test for effect with not certain target or not certain action
function Auxiliary.NecroValleyNegateCheck(v)
  if not Duel.IsChainDisablable(0) then
    return false
  end
  local g = Group.CreateGroup()
  if Auxiliary.GetValueType(v) == "Card" then
    g:AddCard(v)
  end
  if Auxiliary.GetValueType(v) == "Group" then
    g:Merge(v)
  end
  if g:IsExists(Card.IsHasEffect, 1, nil, EFFECT_NECRO_VALLEY) then
    Duel.NegateEffect(0)
    return true
  end
  return false
end
--Ursarctic common summon from hand effect
function Auxiliary.AddUrsarcticSpSummonEffect(c)
  local e1 = Effect.CreateEffect(c)
  e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
  e1:SetType(EFFECT_TYPE_QUICK_O)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetRange(LOCATION_HAND)
  e1:SetHintTiming(0, TIMINGS_CHECK_MONSTER + TIMING_MAIN_END)
  e1:SetCondition(Auxiliary.UrsarcticSpSummonCondition)
  e1:SetCost(Auxiliary.UrsarcticSpSummonCost)
  e1:SetTarget(Auxiliary.UrsarcticSpSummonTarget)
  e1:SetOperation(Auxiliary.UrsarcticSpSummonOperation)
  c:RegisterEffect(e1)
  return e1
end
function Auxiliary.UrsarcticSpSummonCondition(e, tp, eg, ep, ev, re, r, rp)
  return Duel.GetCurrentPhase() == PHASE_MAIN1 or Duel.GetCurrentPhase() == PHASE_MAIN2
end
function Auxiliary.UrsarcticReleaseFilter(c)
  return c:IsLevelAbove(7) and c:IsLocation(LOCATION_HAND)
end
function Auxiliary.UrsarcticExCostFilter(c, tp)
  return c:IsAbleToRemoveAsCost() and (c:IsHasEffect(16471775, tp) or c:IsHasEffect(89264428, tp))
end
function Auxiliary.UrsarcticSpSummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
  local g1 = Duel.GetReleaseGroup(tp, true):Filter(Auxiliary.UrsarcticReleaseFilter, e:GetHandler())
  local g2 = Duel.GetMatchingGroup(Auxiliary.UrsarcticExCostFilter, tp, LOCATION_GRAVE, 0, nil, tp)
  g1:Merge(g2)
  if chk == 0 then
    return g1:GetCount() > 0
  end
  Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_RELEASE)
  local tc = g1:Select(tp, 1, 1, nil):GetFirst()
  local te = tc:IsHasEffect(16471775, tp) or tc:IsHasEffect(89264428, tp)
  if te then
    te:UseCountLimit(tp)
    Duel.Remove(tc, POS_FACEUP, REASON_EFFECT + REASON_REPLACE)
  else
    Duel.Release(tc, REASON_COST)
  end
end
function Auxiliary.UrsarcticSpSummonTarget(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return Duel.GetLocationCount(tp, LOCATION_MZONE) > 0 and e:GetHandler():IsCanBeSpecialSummoned(e, 0, tp, false, false)
  end
  Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, e:GetHandler(), 1, 0, 0)
end
function Auxiliary.UrsarcticSpSummonOperation(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  if c:IsRelateToEffect(e) then
    Duel.SpecialSummon(c, 0, tp, tp, false, false, POS_FACEUP)
  end
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
  e1:SetTargetRange(1, 0)
  e1:SetTarget(Auxiliary.UrsarcticSpSummonLimit)
  e1:SetReset(RESET_PHASE + PHASE_END)
  Duel.RegisterEffect(e1, tp)
end
function Auxiliary.UrsarcticSpSummonLimit(e, c)
  return c:IsLevel(0)
end
--Drytron common summon effect
function Auxiliary.AddDrytronSpSummonEffect(c, func)
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_IGNITION)
  e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
  e1:SetCost(Auxiliary.DrytronSpSummonCost)
  e1:SetTarget(Auxiliary.DrytronSpSummonTarget)
  e1:SetOperation(Auxiliary.DrytronSpSummonOperation(func))
  c:RegisterEffect(e1)
  Duel.AddCustomActivityCounter(97148796, ACTIVITY_SPSUMMON, Auxiliary.DrytronCounterFilter)
  return e1
end
function Auxiliary.DrytronCounterFilter(c)
  return not c:IsSummonableCard()
end
function Auxiliary.DrytronCostFilter(c, tp)
  return (c:IsSetCard(0x154) or c:IsType(TYPE_RITUAL)) and c:IsType(TYPE_MONSTER) and Duel.GetMZoneCount(tp, c) > 0 and (c:IsControler(tp) or c:IsFaceup())
end
function Auxiliary.DrytronExtraCostFilter(c, tp)
  return c:IsAbleToRemove() and c:IsHasEffect(89771220, tp)
end
function Auxiliary.DrytronSpSummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
  e:SetLabel(100)
  local g1 = Duel.GetReleaseGroup(tp, true):Filter(Auxiliary.DrytronCostFilter, e:GetHandler(), tp)
  local g2 = Duel.GetMatchingGroup(Auxiliary.DrytronExtraCostFilter, tp, LOCATION_GRAVE, 0, nil, tp)
  g1:Merge(g2)
  if chk == 0 then
    return #g1 > 0 and Duel.GetCustomActivityCount(97148796, tp, ACTIVITY_SPSUMMON) == 0
  end
  local e1 = Effect.CreateEffect(e:GetHandler())
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_OATH)
  e1:SetTargetRange(1, 0)
  e1:SetTarget(Auxiliary.DrytronSpSummonLimit)
  e1:SetReset(RESET_PHASE + PHASE_END)
  Duel.RegisterEffect(e1, tp)
  --cant special summon summonable card check
  local e2 = Effect.CreateEffect(e:GetHandler())
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetCode(97148796)
  e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_OATH)
  e2:SetTargetRange(1, 0)
  e2:SetReset(RESET_PHASE + PHASE_END)
  Duel.RegisterEffect(e2, tp)
  Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_RELEASE)
  local rg = g1:Select(tp, 1, 1, nil)
  local tc = rg:GetFirst()
  local te = tc:IsHasEffect(89771220, tp)
  if te then
    te:UseCountLimit(tp)
    Duel.Remove(tc, POS_FACEUP, REASON_EFFECT + REASON_REPLACE)
  else
    Auxiliary.UseExtraReleaseCount(rg, tp)
    Duel.Release(tc, REASON_COST)
  end
end
function Auxiliary.DrytronSpSummonLimit(e, c, sump, sumtype, sumpos, targetp, se)
  return c:IsSummonableCard() and c:GetOriginalType() & (TYPE_SPELL | TYPE_TRAP | TYPE_TRAPMONSTER) == 0
end
function Auxiliary.DrytronSpSummonTarget(e, tp, eg, ep, ev, re, r, rp, chk)
  local res = e:GetLabel() == 100 or Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
  if chk == 0 then
    e:SetLabel(0)
    return res and e:GetHandler():IsCanBeSpecialSummoned(e, 0, tp, false, true, POS_FACEUP_DEFENSE)
  end
  e:SetLabel(0)
  Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, e:GetHandler(), 1, 0, 0)
end
function Auxiliary.DrytronSpSummonOperation(func)
  return function(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if not c:IsRelateToEffect(e) then
      return
    end
    if Duel.SpecialSummon(c, 0, tp, tp, false, true, POS_FACEUP_DEFENSE) ~= 0 then
      c:CompleteProcedure()
      func(e, tp)
    end
  end
end
---The `nolimit` parameter for Special Summon effects of Drytron cards
---@param c Card
---@return boolean
function Auxiliary.DrytronSpSummonType(c)
  return c:IsType(TYPE_SPSUMMON)
end
---The `nolimit` parameter for Special Summon effects of Dragon, Xyz monsters where Soul Drain Dragon is available
---(Soul Drain Dragon, Level 8/LIGHT/Dragon/4000/0)
---@param c Card
---@return boolean
function Auxiliary.DragonXyzSpSummonType(c)
  return c:GetOriginalCode() == 55735315
end
---The `nolimit` parameter for Special Summon effects of Triamid cards
---@param c Card
---@return boolean
function Auxiliary.TriamidSpSummonType(c)
  return c:IsType(TYPE_SPSUMMON)
end
--additional destroy effect for the Labrynth field
function Auxiliary.LabrynthDestroyOp(e, tp, res)
  local c = e:GetHandler()
  local chk = not c:IsStatus(STATUS_ACT_FROM_HAND) and c:IsSetCard(0x117e) and c:GetType() == TYPE_TRAP and e:IsHasType(EFFECT_TYPE_ACTIVATE)
  local exc = nil
  if c:IsStatus(STATUS_LEAVE_CONFIRMED) then
    exc = c
  end
  local te = Duel.IsPlayerAffectedByEffect(tp, 33407125)
  if chk and te and Duel.IsExistingMatchingCard(nil, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, exc) and Duel.SelectYesNo(tp, Auxiliary.Stringid(33407125, 0)) then
    if res > 0 then
      Duel.BreakEffect()
    end
    Duel.Hint(HINT_CARD, 0, 33407125)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_DESTROY)
    local dg = Duel.SelectMatchingCard(tp, nil, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, 1, exc)
    Duel.HintSelection(dg)
    Duel.Destroy(dg, REASON_EFFECT)
    te:UseCountLimit(tp)
  end
end
--shortcut for Gizmek cards
function Auxiliary.AtkEqualsDef(c)
  if not c:IsType(TYPE_MONSTER) or c:IsType(TYPE_LINK) then
    return false
  end
  if c:GetAttack() ~= c:GetDefense() then
    return false
  end
  return c:IsLocation(LOCATION_MZONE) or c:GetTextAttack() >= 0 and c:GetTextDefense() >= 0
end
--shortcut for self-banish costs
function Auxiliary.bfgcost(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return e:GetHandler():IsAbleToRemoveAsCost()
  end
  Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_COST)
end
--check for cards with different names
function Auxiliary.dncheck(g)
  return g:GetClassCount(Card.GetCode) == #g
end
--check for cards with different levels
function Auxiliary.dlvcheck(g)
  return g:GetClassCount(Card.GetLevel) == #g
end
--check for cards with different ranks
function Auxiliary.drkcheck(g)
  return g:GetClassCount(Card.GetRank) == #g
end
--check for cards with different links
function Auxiliary.dlkcheck(g)
  return g:GetClassCount(Card.GetLink) == #g
end
--check for cards with different attributes
function Auxiliary.dabcheck(g)
  return g:GetClassCount(Card.GetAttribute) == #g
end
--check for cards with different races
function Auxiliary.drccheck(g)
  return g:GetClassCount(Card.GetRace) == #g
end
--check for group with 2 cards, each card match f with a1/a2 as argument
function Auxiliary.gfcheck(g, f, a1, a2)
  if #g ~= 2 then
    return false
  end
  local c1 = g:GetFirst()
  local c2 = g:GetNext()
  return f(c1, a1) and f(c2, a2) or f(c2, a1) and f(c1, a2)
end
--check for group with 2 cards, each card match f1 with a1, f2 with a2 as argument
function Auxiliary.gffcheck(g, f1, a1, f2, a2)
  if #g ~= 2 then
    return false
  end
  local c1 = g:GetFirst()
  local c2 = g:GetNext()
  return f1(c1, a1) and f2(c2, a2) or f1(c2, a1) and f2(c1, a2)
end
function Auxiliary.mzctcheck(g, tp)
  return Duel.GetMZoneCount(tp, g) > 0
end
---Check if there is space in mzone after tp releases g by reason
---@param g Group
---@param tp integer
---@param reason? integer
---@return boolean
function Auxiliary.mzctcheckrel(g, tp, reason)
  reason = reason or REASON_COST
  return Duel.GetMZoneCount(tp, g) > 0 and Duel.CheckReleaseGroupEx(tp, Auxiliary.IsInGroup, #g, reason, false, nil, g)
end
--used for "except this card"
function Auxiliary.ExceptThisCard(e)
  local c = e:GetHandler()
  if c:IsRelateToChain() then
    return c
  else
    return nil
  end
end
--used for multi-linked zone(zone linked by two or more link monsters)
function Auxiliary.GetMultiLinkedZone(tp)
  local f = function(c)
    return c:IsFaceup() and c:IsType(TYPE_LINK)
  end
  local lg = Duel.GetMatchingGroup(f, tp, LOCATION_MZONE, LOCATION_MZONE, nil)
  local multi_linked_zone = 0
  local single_linked_zone = 0
  for tc in Auxiliary.Next(lg) do
    local zone = tc:GetLinkedZone(tp) & 0x7f
    multi_linked_zone = single_linked_zone & zone | multi_linked_zone
    single_linked_zone = single_linked_zone ~ zone
  end
  return multi_linked_zone
end
Auxiliary.SubGroupCaptured = nil
function Auxiliary.CheckGroupRecursive(c, sg, g, f, min, max, ext_params)
  sg:AddCard(c)
  if Auxiliary.GCheckAdditional and not Auxiliary.GCheckAdditional(sg, c, g) then
    sg:RemoveCard(c)
    return false
  end
  local res = (#sg >= min and #sg <= max and f(sg, table.unpack(ext_params))) or (#sg < max and g:IsExists(Auxiliary.CheckGroupRecursive, 1, sg, sg, g, f, min, max, ext_params))
  sg:RemoveCard(c)
  return res
end
function Auxiliary.CheckGroupRecursiveCapture(c, sg, g, f, min, max, ext_params)
  sg:AddCard(c)
  if Auxiliary.GCheckAdditional and not Auxiliary.GCheckAdditional(sg, c, g) then
    sg:RemoveCard(c)
    return false
  end
  local res = #sg >= min and #sg <= max and f(sg, table.unpack(ext_params))
  if res then
    Auxiliary.SubGroupCaptured:Clear()
    Auxiliary.SubGroupCaptured:Merge(sg)
  else
    res = #sg < max and g:IsExists(Auxiliary.CheckGroupRecursiveCapture, 1, sg, sg, g, f, min, max, ext_params)
  end
  sg:RemoveCard(c)
  return res
end
---
---@param g Group
---@param f function
---@param min? integer
---@param max? integer
---@param ... any
---@return boolean
function Group.CheckSubGroup(g, f, min, max, ...)
  min = min or 1
  max = max or #g
  if min > max then
    return false
  end
  local ext_params = { ... }
  local sg = Duel.GrabSelectedCard()
  if #sg > max or #(g + sg) < min then
    return false
  end
  if #sg == max and (not f(sg, ...) or Auxiliary.GCheckAdditional and not Auxiliary.GCheckAdditional(sg, nil, g)) then
    return false
  end
  if #sg >= min and #sg <= max and f(sg, ...) and (not Auxiliary.GCheckAdditional or Auxiliary.GCheckAdditional(sg, nil, g)) then
    return true
  end
  local eg = g:Clone()
  for c in Auxiliary.Next(g - sg) do
    if Auxiliary.CheckGroupRecursive(c, sg, eg, f, min, max, ext_params) then
      return true
    end
    eg:RemoveCard(c)
  end
  return false
end
---
---@param g Group
---@param tp integer
---@param f function
---@param cancelable boolean
---@param min? integer
---@param max? integer
---@param ... any
---@return Group
function Group.SelectSubGroup(g, tp, f, cancelable, min, max, ...)
  Auxiliary.SubGroupCaptured = Group.CreateGroup()
  min = min or 1
  max = max or #g
  local ext_params = { ... }
  local sg = Group.CreateGroup()
  local fg = Duel.GrabSelectedCard()
  if #fg > max or min > max or #(g + fg) < min then
    return nil
  end
  for tc in Auxiliary.Next(fg) do
    fg:SelectUnselect(sg, tp, false, false, min, max)
  end
  sg:Merge(fg)
  local finish = (#sg >= min and #sg <= max and f(sg, ...))
  while #sg < max do
    local cg = Group.CreateGroup()
    local eg = g:Clone()
    for c in Auxiliary.Next(g - sg) do
      if not cg:IsContains(c) then
        if Auxiliary.CheckGroupRecursiveCapture(c, sg, eg, f, min, max, ext_params) then
          cg:Merge(Auxiliary.SubGroupCaptured)
        else
          eg:RemoveCard(c)
        end
      end
    end
    cg:Sub(sg)
    finish = (#sg >= min and #sg <= max and f(sg, ...))
    if #cg == 0 then
      break
    end
    local cancel = not finish and cancelable
    local tc = cg:SelectUnselect(sg, tp, finish, cancel, min, max)
    if not tc then
      break
    end
    if not fg:IsContains(tc) then
      if not sg:IsContains(tc) then
        sg:AddCard(tc)
        if #sg == max then
          finish = true
        end
      else
        sg:RemoveCard(tc)
      end
    elseif cancelable then
      return nil
    end
  end
  if finish then
    return sg
  else
    return nil
  end
end
---Create a table of filter functions
---@param f function
---@param list table
---@return table
function Auxiliary.CreateChecks(f, list)
  local checks = {}
  for i = 1, #list do
    checks[i] = function(c)
      return f(c, list[i])
    end
  end
  return checks
end
function Auxiliary.CheckGroupRecursiveEach(c, sg, g, f, checks, ext_params)
  if not checks[1 + #sg](c) then
    return false
  end
  sg:AddCard(c)
  if Auxiliary.GCheckAdditional and not Auxiliary.GCheckAdditional(sg, c, g) then
    sg:RemoveCard(c)
    return false
  end
  local res
  if #sg == #checks then
    res = f(sg, table.unpack(ext_params))
  else
    res = g:IsExists(Auxiliary.CheckGroupRecursiveEach, 1, sg, sg, g, f, checks, ext_params)
  end
  sg:RemoveCard(c)
  return res
end
---
---@param g Group
---@param checks table
---@param f? function
---@param ... any
---@return boolean
function Group.CheckSubGroupEach(g, checks, f, ...)
  if f == nil then
    f = Auxiliary.TRUE
  end
  if #g < #checks then
    return false
  end
  local ext_params = { ... }
  local sg = Group.CreateGroup()
  return g:IsExists(Auxiliary.CheckGroupRecursiveEach, 1, sg, sg, g, f, checks, ext_params)
end
---
---@param g Group
---@param tp integer
---@param checks table
---@param cancelable? boolean
---@param f? function
---@param ... any
---@return Group
function Group.SelectSubGroupEach(g, tp, checks, cancelable, f, ...)
  if cancelable == nil then
    cancelable = false
  end
  if f == nil then
    f = Auxiliary.TRUE
  end
  local ct = #checks
  local ext_params = { ... }
  local sg = Group.CreateGroup()
  local finish = false
  while #sg < ct do
    local cg = g:Filter(Auxiliary.CheckGroupRecursiveEach, sg, sg, g, f, checks, ext_params)
    if #cg == 0 then
      break
    end
    local tc = cg:SelectUnselect(sg, tp, false, cancelable, ct, ct)
    if not tc then
      break
    end
    if not sg:IsContains(tc) then
      sg:AddCard(tc)
      if #sg == ct then
        finish = true
      end
    else
      sg:Clear()
    end
  end
  if finish then
    return sg
  else
    return nil
  end
end
--for effects that player usually select card from field, avoid showing panel
function Auxiliary.SelectCardFromFieldFirst(tp, f, player, s, o, min, max, ex, ...)
  local ext_params = { ... }
  local g = Duel.GetMatchingGroup(f, player, s, o, ex, table.unpack(ext_params))
  local fg = g:Filter(Card.IsOnField, nil)
  g:Sub(fg)
  if #fg >= min and #g > 0 then
    local last_hint = Duel.GetLastSelectHint(tp)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_FIELD_FIRST)
    local sg = fg:CancelableSelect(tp, min, max, nil)
    if sg then
      return sg
    else
      Duel.Hint(HINT_SELECTMSG, tp, last_hint)
    end
  end
  return Duel.SelectMatchingCard(tp, f, player, s, o, min, max, ex, table.unpack(ext_params))
end
function Auxiliary.SelectTargetFromFieldFirst(tp, f, player, s, o, min, max, ex, ...)
  local ext_params = { ... }
  local g = Duel.GetMatchingGroup(f, player, s, o, ex, table.unpack(ext_params)):Filter(Card.IsCanBeEffectTarget, nil)
  local fg = g:Filter(Card.IsOnField, nil)
  g:Sub(fg)
  if #fg >= min and #g > 0 then
    local last_hint = Duel.GetLastSelectHint(tp)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_FIELD_FIRST)
    local sg = fg:CancelableSelect(tp, min, max, nil)
    if sg then
      Duel.SetTargetCard(sg)
      return sg
    else
      Duel.Hint(HINT_SELECTMSG, tp, last_hint)
    end
  end
  return Duel.SelectTarget(tp, f, player, s, o, min, max, ex, table.unpack(ext_params))
end
--condition of "negate activation and banish"
function Auxiliary.nbcon(tp, re)
  local rc = re:GetHandler()
  return Duel.IsPlayerCanRemove(tp) and (not rc:IsRelateToEffect(re) or rc:IsAbleToRemove())
end
function Auxiliary.nbtg(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return Auxiliary.nbcon(tp, re)
  end
  Duel.SetOperationInfo(0, CATEGORY_NEGATE, eg, 1, 0, 0)
  if re:GetHandler():IsRelateToEffect(re) then
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, eg, 1, 0, 0)
  end
  if re:GetActivateLocation() == LOCATION_GRAVE then
    e:SetCategory(e:GetCategory() | CATEGORY_GRAVE_ACTION)
  else
    e:SetCategory(e:GetCategory() & ~CATEGORY_GRAVE_ACTION)
  end
end
--condition of "negate activation and return to deck"
function Auxiliary.ndcon(tp, re)
  local rc = re:GetHandler()
  return re:IsHasType(EFFECT_TYPE_ACTIVATE) or not rc:IsRelateToEffect(re) or rc:IsAbleToDeck()
end
--return the global index of the zone in (p,loc,seq)
function Auxiliary.SequenceToGlobal(p, loc, seq)
  if p ~= 0 and p ~= 1 then
    return 0
  end
  if loc == LOCATION_MZONE then
    if seq <= 6 then
      return 0x0001 << (16 * p + seq)
    else
      return 0
    end
  elseif loc == LOCATION_SZONE then
    if seq <= 4 then
      return 0x0100 << (16 * p + seq)
    else
      return 0
    end
  else
    return 0
  end
end
--use the count limit of Lair of Darkness if the tributes are not selected by Duel.SelectReleaseGroup
function Auxiliary.UseExtraReleaseCount(g, tp)
  local eg = g:Filter(Auxiliary.ExtraReleaseFilter, nil, tp)
  for ec in Auxiliary.Next(eg) do
    local te = ec:IsHasEffect(EFFECT_EXTRA_RELEASE_NONSUM, tp)
    if te then
      te:UseCountLimit(tp)
    end
  end
end
function Auxiliary.ExtraReleaseFilter(c, tp)
  return c:IsControler(1 - tp) and c:IsHasEffect(EFFECT_EXTRA_RELEASE_NONSUM, tp)
end
--
function Auxiliary.GetCappedLevel(c)
  local lv = c:GetLevel()
  if lv > MAX_PARAMETER then
    return MAX_PARAMETER
  else
    return lv
  end
end
--
function Auxiliary.GetCappedXyzLevel(c)
  local lv = c:GetLevel()
  if lv > MAX_XYZ_LEVEL then
    return MAX_XYZ_LEVEL
  else
    return lv
  end
end
--
function Auxiliary.GetCappedAttack(c)
  local x = c:GetAttack()
  if x > MAX_PARAMETER then
    return MAX_PARAMETER
  else
    return x
  end
end
--when this card is sent to grave, record the reason effect
--to check whether the reason effect do something simultaneously
--so the "while this card is in your GY" condition isn't met
function Auxiliary.AddThisCardInGraveAlreadyCheck(c)
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(EVENT_TO_GRAVE)
  e1:SetCondition(Auxiliary.ThisCardInGraveAlreadyCheckReg)
  c:RegisterEffect(e1)
  return e1
end
function Auxiliary.ThisCardInGraveAlreadyCheckReg(e, tp, eg, ep, ev, re, r, rp)
  --condition of continous effect will be checked before other effects
  if re == nil then
    return false
  end
  if e:GetLabelObject() ~= nil then
    return false
  end
  if (r & REASON_EFFECT) > 0 then
    e:SetLabelObject(re)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_CHAIN_END)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetOperation(Auxiliary.ThisCardInGraveAlreadyReset1)
    e1:SetLabelObject(e)
    Duel.RegisterEffect(e1, tp)
    local e2 = e1:Clone()
    e2:SetCode(EVENT_BREAK_EFFECT)
    e2:SetOperation(Auxiliary.ThisCardInGraveAlreadyReset2)
    e2:SetReset(RESET_CHAIN)
    e2:SetLabelObject(e1)
    Duel.RegisterEffect(e2, tp)
  elseif (r & REASON_MATERIAL) > 0 or not re:IsActivated() and (r & REASON_COST) > 0 then
    e:SetLabelObject(re)
    local reset_event = EVENT_SPSUMMON
    if re:GetCode() ~= EFFECT_SPSUMMON_PROC then
      reset_event = EVENT_SUMMON
    end
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(reset_event)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetOperation(Auxiliary.ThisCardInGraveAlreadyReset1)
    e1:SetLabelObject(e)
    Duel.RegisterEffect(e1, tp)
  end
  return false
end
function Auxiliary.ThisCardInGraveAlreadyReset1(e)
  --this will run after EVENT_SPSUMMON_SUCCESS
  e:GetLabelObject():SetLabelObject(nil)
  e:Reset()
end
function Auxiliary.ThisCardInGraveAlreadyReset2(e)
  local e1 = e:GetLabelObject()
  e1:GetLabelObject():SetLabelObject(nil)
  e1:Reset()
  e:Reset()
end
--Player p place g on the top of Deck in any order
function Auxiliary.PlaceCardsOnDeckTop(p, g, reason)
  if reason == nil then
    reason = REASON_EFFECT
  end
  Duel.SendtoDeck(g, nil, SEQ_DECKTOP, reason)
  local rg = Duel.GetOperatedGroup()
  local og = rg:Filter(Card.IsLocation, nil, LOCATION_DECK)
  local ct1 = og:FilterCount(Card.IsControler, nil, p)
  local ct2 = og:FilterCount(Card.IsControler, nil, 1 - p)
  if ct1 > 1 then
    Duel.SortDecktop(p, p, ct1)
  end
  if ct2 > 1 then
    Duel.SortDecktop(p, 1 - p, ct2)
  end
  return #rg
end
--Player p place g on the bottom of Deck in any order
function Auxiliary.PlaceCardsOnDeckBottom(p, g, reason)
  if reason == nil then
    reason = REASON_EFFECT
  end
  Duel.SendtoDeck(g, nil, SEQ_DECKTOP, reason)
  local rg = Duel.GetOperatedGroup()
  local og = rg:Filter(Card.IsLocation, nil, LOCATION_DECK)
  local ct1 = og:FilterCount(Card.IsControler, nil, p)
  local ct2 = og:FilterCount(Card.IsControler, nil, 1 - p)
  if ct1 > 0 then
    if ct1 > 1 then
      Duel.SortDecktop(p, p, ct1)
    end
    for i = 1, ct1 do
      local tc = Duel.GetDecktopGroup(p, 1):GetFirst()
      Duel.MoveSequence(tc, SEQ_DECKBOTTOM)
    end
  end
  if ct2 > 0 then
    if ct2 > 1 then
      Duel.SortDecktop(p, 1 - p, ct2)
    end
    for i = 1, ct2 do
      local tc = Duel.GetDecktopGroup(1 - p, 1):GetFirst()
      Duel.MoveSequence(tc, SEQ_DECKBOTTOM)
    end
  end
  return #rg
end
--The event is triggered multiple times in a chain
--but only 1 event with EVENT_CUSTOM+code will be triggered at EVENT_CHAIN_END, or immediately if not in chain
--NOTE: re,r,rp,ep,ev of that custom event ARE NOT releated to the real event that trigger this custom event
function Auxiliary.RegisterMergedDelayedEvent(c, code, event, g)
  local mt = getmetatable(c)
  if mt[event] == true then
    return
  end
  mt[event] = true
  if not g then
    g = Group.CreateGroup()
  end
  g:KeepAlive()
  local ge1 = Effect.CreateEffect(c)
  ge1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
  ge1:SetCode(event)
  ge1:SetLabel(code)
  ge1:SetLabelObject(g)
  ge1:SetOperation(Auxiliary.MergedDelayEventCheck1)
  Duel.RegisterEffect(ge1, 0)
  local ge2 = ge1:Clone()
  ge2:SetCode(EVENT_CHAIN_END)
  ge2:SetOperation(Auxiliary.MergedDelayEventCheck2)
  Duel.RegisterEffect(ge2, 0)
end
function Auxiliary.MergedDelayEventCheck1(e, tp, eg, ep, ev, re, r, rp)
  local g = e:GetLabelObject()
  g:Merge(eg)
  if Duel.GetCurrentChain() == 0 and not Duel.CheckEvent(EVENT_CHAIN_END) then
    local _eg = g:Clone()
    Duel.RaiseEvent(_eg, EVENT_CUSTOM + e:GetLabel(), re, r, rp, ep, ev)
    g:Clear()
  end
end
function Auxiliary.MergedDelayEventCheck2(e, tp, eg, ep, ev, re, r, rp)
  local g = e:GetLabelObject()
  if #g > 0 then
    local _eg = g:Clone()
    Duel.RaiseEvent(_eg, EVENT_CUSTOM + e:GetLabel(), re, r, rp, ep, ev)
    g:Clear()
  end
end
--Once the card has been moved to the public area, it should be listened to again
Auxiliary.merge_single_effect_codes = {}
function Auxiliary.RegisterMergedDelayedEvent_ToSingleCard(c, code, events)
  local g = Group.CreateGroup()
  g:KeepAlive()
  local mt = getmetatable(c)
  local seed = 0
  if type(events) == "table" then
    for _, event in ipairs(events) do
      seed = seed + event
    end
  else
    seed = events
  end
  while mt[seed] == true do
    seed = seed + 1
  end
  mt[seed] = true
  local event_code_single = (code ~ (seed << 16)) | EVENT_CUSTOM
  if type(events) == "table" then
    for _, event in ipairs(events) do
      Auxiliary.RegisterMergedDelayedEvent_ToSingleCard_AddOperation(c, g, event, event_code_single)
    end
  else
    Auxiliary.RegisterMergedDelayedEvent_ToSingleCard_AddOperation(c, g, events, event_code_single)
  end
  --listened to again
  local e3 = Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
  e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_SET_AVAILABLE)
  e3:SetCode(EVENT_MOVE)
  e3:SetLabel(event_code_single)
  e3:SetLabelObject(g)
  e3:SetOperation(Auxiliary.ThisCardMovedToPublicResetCheck_ToSingleCard)
  c:RegisterEffect(e3)
  Auxiliary.merge_single_effect_codes[event_code_single] = g
  --use global effect to raise event for face-down cards
  if not Auxiliary.merge_single_global_check then
    Auxiliary.merge_single_global_check = true
    local ge1 = Effect.GlobalEffect()
    ge1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    ge1:SetCode(EVENT_CHAIN_END)
    ge1:SetOperation(Auxiliary.RegisterMergedDelayedEvent_ToSingleCard_RaiseEvent)
    Duel.RegisterEffect(ge1, 0)
  end
  return event_code_single
end
function Auxiliary.RegisterMergedDelayedEvent_ToSingleCard_AddOperation(c, g, event, event_code_single)
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
  e1:SetCode(event)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_SET_AVAILABLE)
  e1:SetRange(0xff)
  e1:SetLabel(event_code_single, event)
  e1:SetLabelObject(g)
  e1:SetOperation(Auxiliary.MergedDelayEventCheck1_ToSingleCard)
  c:RegisterEffect(e1)
  local e2 = e1:Clone()
  e2:SetCode(EVENT_CHAIN_END)
  e2:SetOperation(Auxiliary.MergedDelayEventCheck2_ToSingleCard)
  c:RegisterEffect(e2)
end
function Auxiliary.ThisCardMovedToPublicResetCheck_ToSingleCard(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetOwner()
  local g = e:GetLabelObject()
  if c:IsFaceup() or c:IsPublic() then
    g:Clear()
  end
end
function Auxiliary.MergedDelayEventCheck1_ToSingleCard(e, tp, eg, ep, ev, re, r, rp)
  local g = e:GetLabelObject()
  g:Merge(eg)
  local code, event = e:GetLabel()
  local c = e:GetOwner()
  local mr, meg = Duel.CheckEvent(event, true)
  if mr and meg:IsContains(c) and (c:IsFaceup() or c:IsPublic()) then
    g:Clear()
  end
  if Duel.GetCurrentChain() == 0 and #g > 0 and not Duel.CheckEvent(EVENT_CHAIN_END) then
    local _eg = g:Clone()
    Duel.RaiseEvent(_eg, code, re, r, rp, ep, ev)
    g:Clear()
  end
end
function Auxiliary.MergedDelayEventCheck2_ToSingleCard(e, tp, eg, ep, ev, re, r, rp)
  local g = e:GetLabelObject()
  if Duel.CheckEvent(EVENT_MOVE) then
    local _, meg = Duel.CheckEvent(EVENT_MOVE, true)
    local c = e:GetOwner()
    if meg:IsContains(c) and (c:IsFaceup() or c:IsPublic()) then
      g:Clear()
    end
  end
  if #g > 0 then
    local _eg = g:Clone()
    Duel.RaiseEvent(_eg, e:GetLabel(), re, r, rp, ep, ev)
    g:Clear()
  end
end
function Auxiliary.RegisterMergedDelayedEvent_ToSingleCard_RaiseEvent(e, tp, eg, ep, ev, re, r, rp)
  for code, g in pairs(Auxiliary.merge_single_effect_codes) do
    if #g > 0 then
      local _eg = g:Clone()
      Duel.RaiseEvent(_eg, code, re, r, rp, ep, ev)
      g:Clear()
    end
  end
end
--B.E.S. remove counter
function Auxiliary.EnableBESRemove(c)
  local e1 = Effect.CreateEffect(c)
  e1:SetDescription(10)
  e1:SetCategory(CATEGORY_DESTROY)
  e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
  e1:SetCode(EVENT_DAMAGE_STEP_END)
  e1:SetRange(LOCATION_MZONE)
  e1:SetCondition(Auxiliary.RemoveCondtion)
  e1:SetTarget(Auxiliary.RemoveTarget)
  e1:SetOperation(Auxiliary.RemoveOperation)
  c:RegisterEffect(e1)
end
function Auxiliary.RemoveCondtion(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  return c:IsRelateToBattle()
end
function Auxiliary.RemoveTarget(e, tp, eg, ep, ev, re, r, rp, chk)
  if chk == 0 then
    return true
  end
  if not e:GetHandler():IsCanRemoveCounter(tp, 0x1f, 1, REASON_EFFECT) then
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, e:GetHandler(), 1, 0, 0)
  end
end
function Auxiliary.RemoveOperation(e, tp, eg, ep, ev, re, r, rp)
  local c = e:GetHandler()
  if c:IsRelateToEffect(e) then
    if c:IsCanRemoveCounter(tp, 0x1f, 1, REASON_EFFECT) then
      c:RemoveCounter(tp, 0x1f, 1, REASON_EFFECT)
    else
      Duel.Destroy(c, REASON_EFFECT)
    end
  end
end
--The operation function of "destroy during End Phase"
function Auxiliary.EPDestroyOperation(e, tp, eg, ep, ev, re, r, rp)
  local tc = e:GetLabelObject()
  if Auxiliary.GetValueType(tc) == "Card" or Auxiliary.GetValueType(tc) == "Group" then
    Duel.Destroy(tc, REASON_EFFECT, LOCATION_GRAVE)
  end
end
--
function Auxiliary.NegateSummonCondition()
  return Duel.GetReadyChain() == 0
end
---Check if all cards in g have the same Attribute/Race
---@param g Group
---@param f function Like Card.GetAttribute, must return binary value
---@return boolean
function Auxiliary.SameValueCheck(g, f)
  if #g <= 1 then
    return true
  end
  if #g == 2 then
    return f(g:GetFirst()) & f(g:GetNext()) ~= 0
  end
  local tc = g:GetFirst()
  local v = f(tc)
  tc = g:GetNext()
  while tc do
    v = v & f(tc)
    if v == 0 then
      return false
    end
    tc = g:GetNext()
  end
  return v ~= 0
end
---
---@param tp integer
---@return boolean
function Auxiliary.IsPlayerCanNormalDraw(tp)
  return Duel.GetDrawCount(tp) > 0 and Duel.GetFieldGroupCount(tp, LOCATION_DECK, 0) > 0 and Duel.GetFlagEffect(tp, FLAG_ID_NO_NORMAL_DRAW) == 0
end
---
---@param e Effect
---@param tp integer
---@param property? integer
function Auxiliary.GiveUpNormalDraw(e, tp, property)
  property = property or 0
  local c = e:GetHandler()
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET | property)
  e1:SetCode(EFFECT_DRAW_COUNT)
  e1:SetTargetRange(1, 0)
  e1:SetReset(RESET_PHASE + PHASE_DRAW)
  e1:SetValue(0)
  Duel.RegisterEffect(e1, tp)
  Duel.RegisterFlagEffect(tp, FLAG_ID_NO_NORMAL_DRAW, RESET_PHASE + PHASE_DRAW, property, 1)
end
---Add EFFECT_TYPE_ACTIVATE effect to Equip Spell Cards
---@param c Card
---@param is_self boolean
---@param is_opponent boolean
---@param filter function
---@param eqlimit function|nil
---@param pause? boolean
---@param skip_target? boolean
function Auxiliary.AddEquipSpellEffect(c, is_self, is_opponent, filter, eqlimit, pause, skip_target)
  local value = (type(eqlimit) == "function") and eqlimit or 1
  if pause == nil then
    pause = false
  end
  if skip_target == nil then
    skip_target = false
  end
  --Activate
  local e1 = Effect.CreateEffect(c)
  e1:SetCategory(CATEGORY_EQUIP)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET + EFFECT_FLAG_CONTINUOUS_TARGET)
  if not skip_target then
    e1:SetTarget(Auxiliary.EquipSpellTarget(is_self, is_opponent, filter, eqlimit))
  end
  e1:SetOperation(Auxiliary.EquipSpellOperation(eqlimit))
  if not pause then
    c:RegisterEffect(e1)
  end
  --Equip limit
  local e2 = Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_SINGLE)
  e2:SetCode(EFFECT_EQUIP_LIMIT)
  e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e2:SetValue(value)
  c:RegisterEffect(e2)
  return e1
end
function Auxiliary.EquipSpellTarget(is_self, is_opponent, filter, eqlimit)
  local loc1 = is_self and LOCATION_MZONE or 0
  local loc2 = is_opponent and LOCATION_MZONE or 0
  return function(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
      return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and (not eqlimit or eqlimit(e, chkc))
    end
    if chk == 0 then
      return Duel.IsExistingTarget(filter, tp, loc1, loc2, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_EQUIP)
    Duel.SelectTarget(tp, filter, tp, loc1, loc2, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_EQUIP, e:GetHandler(), 1, 0, 0)
  end
end
function Auxiliary.EquipSpellOperation(eqlimit)
  return function(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local tc = Duel.GetFirstTarget()
    if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and (not eqlimit or eqlimit(e, tc)) then
      Duel.Equip(tp, c, tc)
    end
  end
end
---If this face-up card would leave the field, banish it instead.
---@param c Card
---@param condition? function
function Auxiliary.AddBanishRedirect(c, condition)
  if type(condition) ~= "function" then
    condition = Auxiliary.BanishRedirectCondition
  end
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_CAN_FORBIDDEN)
  e1:SetCondition(condition)
  e1:SetValue(LOCATION_REMOVED)
  c:RegisterEffect(e1)
end
---
---@param e Effect
function Auxiliary.BanishRedirectCondition(e)
  return e:GetHandler():IsFaceup()
end
---Check if c has a equip card equipped by the effect of itself.
---@param c Card
---@param id integer
---@return boolean
function Auxiliary.IsSelfEquip(c, id)
  return c:GetEquipGroup():IsExists(Auxiliary.SelfEquipFilter, 1, nil, id)
end
function Auxiliary.SelfEquipFilter(c, id)
  return c:GetFlagEffect(id) > 0
end
---Orcustrated Babel
---@param c Card
---@return boolean
function Auxiliary.OrcustratedBabelFilter(c)
  return c:IsOriginalSetCard(0x11b) and (c:IsLocation(LOCATION_MZONE) and c:IsAllTypes(TYPE_LINK + TYPE_MONSTER) or c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER))
end
---Golden Allure Queen
---@param c Card
---@return boolean
function Auxiliary.GoldenAllureQueenFilter(c)
  return c:IsOriginalSetCard(0x3)
end
--The table of all "become quick effects"
Auxiliary.quick_effect_filter = {}
Auxiliary.quick_effect_filter[90351981] = Auxiliary.OrcustratedBabelFilter
Auxiliary.quick_effect_filter[95937545] = Auxiliary.GoldenAllureQueenFilter
---Check if the effect of c becomes a Quick Effect.
---@param c Card
---@param tp integer
---@param code integer
---@return boolean
function Auxiliary.IsCanBeQuickEffect(c, tp, code)
  local filter = Auxiliary.quick_effect_filter[code]
  return Duel.IsPlayerAffectedByEffect(tp, code) ~= nil and filter ~= nil and filter(c)
end
--
function Auxiliary.DimensionalFissureTarget(e, c)
  return c:GetOriginalType() & TYPE_MONSTER > 0 and not c:IsLocation(LOCATION_OVERLAY) and not c:IsType(TYPE_SPELL + TYPE_TRAP)
end
--
function Auxiliary.MimighoulFlipCondition(e, tp, eg, ep, ev, re, r, rp)
  return Duel.IsMainPhase()
end
---The name of `c` becomes the original name of `tc`
---@param c Card
---@param tc Card
---@param reset? integer defult: RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END
---@return Effect
function Auxiliary.BecomeOriginalCode(c, tc, reset)
  reset = reset or (RESET_EVENT + RESETS_STANDARD + RESET_PHASE + PHASE_END)
  local code = tc:GetOriginalCodeRule()
  local e1 = Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_CHANGE_CODE)
  e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e1:SetValue(code)
  e1:SetReset(reset)
  c:RegisterEffect(e1)
  return e1
end
---@param category integer
---@return function
function Auxiliary.EffectCategoryFilter(category)
  ---@param e Effect
  return function(e)
    return e:IsHasCategory(category)
  end
end
---@param flag integer
---@return function
function Auxiliary.EffectPropertyFilter(flag)
  ---@param e Effect
  return function(e)
    return e:IsHasProperty(flag)
  end
end
---@param flag integer
---@return function
function Auxiliary.MonsterEffectPropertyFilter(flag)
  ---@param e Effect
  return function(e)
    return e:IsHasProperty(flag) and not e:IsHasRange(LOCATION_PZONE)
  end
end

aux.DebugConstant_PROCESSOR = false

--~ DUEL_REVEAL_DECK_SEQ = 0x100

--~ if OPCODE_ADD > 0x100000000 then
--~ DUEL_REVEAL_DECK_SEQ = 0
--~ end

do
  local dispatch = {}
  dispatch["boolean"] = function(arg)
    Debug.ShowHint(tostring(arg))
  end
  dispatch["number"] = dispatch["boolean"]
  dispatch["string"] = dispatch["boolean"]
  dispatch["nil"] = dispatch["boolean"]
  dispatch["table"] = function(arg)
    Debug.ShowHint(table.concat(arg, "\n"))
  end
  aux.DebugHint = function(...)
    local count = select("#", ...)
    for i = 1, count do
      local arg = select(i, ...)
      dispatch[type(arg)](arg)
    end
  end
end

--~ do
--~ local puzzle_card = {}
--~ local format_code = ""

--~ local SetPuzzleCard = function(code, owner, location, seq, pos)
--~ local card = Debug.AddCard(code, owner, owner, location, seq, pos)
--~ local _seq = #puzzle_card[owner][format_code] + 1
--~ puzzle_card[owner][format_code][_seq] = card or false
--~ puzzle_card[owner .. " " .. format_code .. " " .. _seq] = card or false
--~ end

--~ local AddPuzzleCard = function(code, owner, location, seq, pos)
--~ puzzle_card[owner] = puzzle_card[owner] or {}
--~ if code < 100000000 then
--~ format_code = string.format("%08d", code)
--~ end
--~ puzzle_card[owner][format_code] = puzzle_card[owner][format_code] or {}
--~ SetPuzzleCard(code, owner, location, seq, pos)
--~ end

--~ local AddPuzzleCards = function(puzzle_data)
--~ for _, i in ipairs(puzzle_data) do
--~ AddPuzzleCard(table.unpack(i))
--~ end
--~ end

--~ aux.SetPuzzle = function(puzzle_data)
--~ AddPuzzleCards(puzzle_data)
--~ return puzzle_card
--~ end
--~ end

do
  aux["REASON"] = {
    [REASON_DESTROY] = "REASON_DESTROY",
    [REASON_RELEASE] = "REASON_RELEASE",
    [REASON_TEMPORARY] = "REASON_TEMPORARY",
    [REASON_MATERIAL] = "REASON_MATERIAL",
    [REASON_SUMMON] = "REASON_SUMMON",
    [REASON_BATTLE] = "REASON_BATTLE",
    [REASON_EFFECT] = "REASON_EFFECT",
    [REASON_COST] = "REASON_COST",
    [REASON_ADJUST] = "REASON_ADJUST",
    [REASON_LOST_TARGET] = "REASON_LOST_TARGET",
    [REASON_RULE] = "REASON_RULE",
    [REASON_SPSUMMON] = "REASON_SPSUMMON",
    [REASON_DISSUMMON] = "REASON_DISSUMMON",
    [REASON_FLIP] = "REASON_FLIP",
    [REASON_DISCARD] = "REASON_DISCARD",
    [REASON_RDAMAGE] = "REASON_RDAMAGE",
    [REASON_RRECOVER] = "REASON_RRECOVER",
    [REASON_RETURN] = "REASON_RETURN",
    [REASON_FUSION] = "REASON_FUSION",
    [REASON_SYNCHRO] = "REASON_SYNCHRO",
    [REASON_RITUAL] = "REASON_RITUAL",
    [REASON_XYZ] = "REASON_XYZ",
    [REASON_REPLACE] = "REASON_REPLACE",
    [REASON_DRAW] = "REASON_DRAW",
    [REASON_REDIRECT] = "REASON_REDIRECT",
    [REASON_REVEAL] = "REASON_REVEAL",
    [REASON_LINK] = "REASON_LINK",
    [REASON_LOST_OVERLAY] = "REASON_LOST_OVERLAY",
    [REASON_MAINTENANCE] = "REASON_MAINTENANCE",
    [REASON_ACTION] = "REASON_ACTION",
  }

  aux["LOCATION"] = {
    [LOCATION_DECK] = "LOCATION_DECK",
    [LOCATION_HAND] = "LOCATION_HAND",
    [LOCATION_MZONE] = "LOCATION_MZONE",
    [LOCATION_SZONE] = "LOCATION_SZONE",
    [LOCATION_GRAVE] = "LOCATION_GRAVE",
    [LOCATION_REMOVED] = "LOCATION_REMOVED",
    [LOCATION_EXTRA] = "LOCATION_EXTRA",
    [LOCATION_OVERLAY] = "LOCATION_OVERLAY",
  }

  aux["EFFECT"] = {
    [EFFECT_IMMUNE_EFFECT] = "EFFECT_IMMUNE_EFFECT",
    [EFFECT_DISABLE] = "EFFECT_DISABLE",
    [EFFECT_CANNOT_DISABLE] = "EFFECT_CANNOT_DISABLE",
    [EFFECT_SET_CONTROL] = "EFFECT_SET_CONTROL",
    [EFFECT_CANNOT_CHANGE_CONTROL] = "EFFECT_CANNOT_CHANGE_CONTROL",
    [EFFECT_CANNOT_ACTIVATE] = "EFFECT_CANNOT_ACTIVATE",
    [EFFECT_CANNOT_TRIGGER] = "EFFECT_CANNOT_TRIGGER",
    [EFFECT_DISABLE_EFFECT] = "EFFECT_DISABLE_EFFECT",
    [EFFECT_DISABLE_CHAIN] = "EFFECT_DISABLE_CHAIN",
    [EFFECT_DISABLE_TRAPMONSTER] = "EFFECT_DISABLE_TRAPMONSTER",
    [EFFECT_CANNOT_INACTIVATE] = "EFFECT_CANNOT_INACTIVATE",
    [EFFECT_CANNOT_DISEFFECT] = "EFFECT_CANNOT_DISEFFECT",
    [EFFECT_CANNOT_CHANGE_POSITION] = "EFFECT_CANNOT_CHANGE_POSITION",
    [EFFECT_TRAP_ACT_IN_HAND] = "EFFECT_TRAP_ACT_IN_HAND",
    [EFFECT_TRAP_ACT_IN_SET_TURN] = "EFFECT_TRAP_ACT_IN_SET_TURN",
    [EFFECT_REMAIN_FIELD] = "EFFECT_REMAIN_FIELD",
    [EFFECT_MONSTER_SSET] = "EFFECT_MONSTER_SSET",
    [EFFECT_CANNOT_SUMMON] = "EFFECT_CANNOT_SUMMON",
    [EFFECT_CANNOT_FLIP_SUMMON] = "EFFECT_CANNOT_FLIP_SUMMON",
    [EFFECT_CANNOT_SPECIAL_SUMMON] = "EFFECT_CANNOT_SPECIAL_SUMMON",
    [EFFECT_CANNOT_MSET] = "EFFECT_CANNOT_MSET",
    [EFFECT_CANNOT_SSET] = "EFFECT_CANNOT_SSET",
    [EFFECT_CANNOT_DRAW] = "EFFECT_CANNOT_DRAW",
    [EFFECT_CANNOT_DISABLE_SUMMON] = "EFFECT_CANNOT_DISABLE_SUMMON",
    [EFFECT_CANNOT_DISABLE_SPSUMMON] = "EFFECT_CANNOT_DISABLE_SPSUMMON",
    [EFFECT_SET_SUMMON_COUNT_LIMIT] = "EFFECT_SET_SUMMON_COUNT_LIMIT",
    [EFFECT_EXTRA_SUMMON_COUNT] = "EFFECT_EXTRA_SUMMON_COUNT",
    [EFFECT_SPSUMMON_CONDITION] = "EFFECT_SPSUMMON_CONDITION",
    [EFFECT_REVIVE_LIMIT] = "EFFECT_REVIVE_LIMIT",
    [EFFECT_SUMMON_PROC] = "EFFECT_SUMMON_PROC",
    [EFFECT_LIMIT_SUMMON_PROC] = "EFFECT_LIMIT_SUMMON_PROC",
    [EFFECT_SPSUMMON_PROC] = "EFFECT_SPSUMMON_PROC",
    [EFFECT_EXTRA_SET_COUNT] = "EFFECT_EXTRA_SET_COUNT",
    [EFFECT_SET_PROC] = "EFFECT_SET_PROC",
    [EFFECT_LIMIT_SET_PROC] = "EFFECT_LIMIT_SET_PROC",
    [EFFECT_DIVINE_LIGHT] = "EFFECT_DIVINE_LIGHT",
    [EFFECT_CANNOT_DISABLE_FLIP_SUMMON] = "EFFECT_CANNOT_DISABLE_FLIP_SUMMON",
    [EFFECT_INDESTRUCTABLE] = "EFFECT_INDESTRUCTABLE",
    [EFFECT_INDESTRUCTABLE_EFFECT] = "EFFECT_INDESTRUCTABLE_EFFECT",
    [EFFECT_INDESTRUCTABLE_BATTLE] = "EFFECT_INDESTRUCTABLE_BATTLE",
    [EFFECT_UNRELEASABLE_SUM] = "EFFECT_UNRELEASABLE_SUM",
    [EFFECT_UNRELEASABLE_NONSUM] = "EFFECT_UNRELEASABLE_NONSUM",
    [EFFECT_DESTROY_SUBSTITUTE] = "EFFECT_DESTROY_SUBSTITUTE",
    [EFFECT_CANNOT_RELEASE] = "EFFECT_CANNOT_RELEASE",
    [EFFECT_INDESTRUCTABLE_COUNT] = "EFFECT_INDESTRUCTABLE_COUNT",
    [EFFECT_UNRELEASABLE_EFFECT] = "EFFECT_UNRELEASABLE_EFFECT",
    [EFFECT_DESTROY_REPLACE] = "EFFECT_DESTROY_REPLACE",
    [EFFECT_RELEASE_REPLACE] = "EFFECT_RELEASE_REPLACE",
    [EFFECT_SEND_REPLACE] = "EFFECT_SEND_REPLACE",
    [EFFECT_CANNOT_DISCARD_HAND] = "EFFECT_CANNOT_DISCARD_HAND",
    [EFFECT_CANNOT_DISCARD_DECK] = "EFFECT_CANNOT_DISCARD_DECK",
    [EFFECT_CANNOT_USE_AS_COST] = "EFFECT_CANNOT_USE_AS_COST",
    [EFFECT_CANNOT_PLACE_COUNTER] = "EFFECT_CANNOT_PLACE_COUNTER",
    [EFFECT_CANNOT_TO_GRAVE_AS_COST] = "EFFECT_CANNOT_TO_GRAVE_AS_COST",
    [EFFECT_LEAVE_FIELD_REDIRECT] = "EFFECT_LEAVE_FIELD_REDIRECT",
    [EFFECT_TO_HAND_REDIRECT] = "EFFECT_TO_HAND_REDIRECT",
    [EFFECT_TO_DECK_REDIRECT] = "EFFECT_TO_DECK_REDIRECT",
    [EFFECT_TO_GRAVE_REDIRECT] = "EFFECT_TO_GRAVE_REDIRECT",
    [EFFECT_REMOVE_REDIRECT] = "EFFECT_REMOVE_REDIRECT",
    [EFFECT_CANNOT_TO_HAND] = "EFFECT_CANNOT_TO_HAND",
    [EFFECT_CANNOT_TO_DECK] = "EFFECT_CANNOT_TO_DECK",
    [EFFECT_CANNOT_REMOVE] = "EFFECT_CANNOT_REMOVE",
    [EFFECT_CANNOT_TO_GRAVE] = "EFFECT_CANNOT_TO_GRAVE",
    [EFFECT_CANNOT_TURN_SET] = "EFFECT_CANNOT_TURN_SET",
    [EFFECT_CANNOT_BE_BATTLE_TARGET] = "EFFECT_CANNOT_BE_BATTLE_TARGET",
    [EFFECT_CANNOT_BE_EFFECT_TARGET] = "EFFECT_CANNOT_BE_EFFECT_TARGET",
    [EFFECT_IGNORE_BATTLE_TARGET] = "EFFECT_IGNORE_BATTLE_TARGET",
    [EFFECT_CANNOT_DIRECT_ATTACK] = "EFFECT_CANNOT_DIRECT_ATTACK",
    [EFFECT_DIRECT_ATTACK] = "EFFECT_DIRECT_ATTACK",
    [EFFECT_DUAL_STATUS] = "EFFECT_DUAL_STATUS",
    [EFFECT_EQUIP_LIMIT] = "EFFECT_EQUIP_LIMIT",
    [EFFECT_DUAL_SUMMONABLE] = "EFFECT_DUAL_SUMMONABLE",
    [EFFECT_UNION_LIMIT] = "EFFECT_UNION_LIMIT",
    [EFFECT_REVERSE_DAMAGE] = "EFFECT_REVERSE_DAMAGE",
    [EFFECT_REVERSE_RECOVER] = "EFFECT_REVERSE_RECOVER",
    [EFFECT_CHANGE_DAMAGE] = "EFFECT_CHANGE_DAMAGE",
    [EFFECT_REFLECT_DAMAGE] = "EFFECT_REFLECT_DAMAGE",
    [EFFECT_CANNOT_ATTACK] = "EFFECT_CANNOT_ATTACK",
    [EFFECT_CANNOT_ATTACK_ANNOUNCE] = "EFFECT_CANNOT_ATTACK_ANNOUNCE",
    [EFFECT_CANNOT_CHANGE_POS_E] = "EFFECT_CANNOT_CHANGE_POS_E",
    [EFFECT_ACTIVATE_COST] = "EFFECT_ACTIVATE_COST",
    [EFFECT_SUMMON_COST] = "EFFECT_SUMMON_COST",
    [EFFECT_SPSUMMON_COST] = "EFFECT_SPSUMMON_COST",
    [EFFECT_FLIPSUMMON_COST] = "EFFECT_FLIPSUMMON_COST",
    [EFFECT_MSET_COST] = "EFFECT_MSET_COST",
    [EFFECT_SSET_COST] = "EFFECT_SSET_COST",
    [EFFECT_ATTACK_COST] = "EFFECT_ATTACK_COST",
    [EFFECT_UPDATE_ATTACK] = "EFFECT_UPDATE_ATTACK",
    [EFFECT_SET_ATTACK] = "EFFECT_SET_ATTACK",
    [EFFECT_SET_ATTACK_FINAL] = "EFFECT_SET_ATTACK_FINAL",
    [EFFECT_SET_BASE_ATTACK] = "EFFECT_SET_BASE_ATTACK",
    [EFFECT_UPDATE_DEFENSE] = "EFFECT_UPDATE_DEFENSE",
    [EFFECT_SET_DEFENSE] = "EFFECT_SET_DEFENSE",
    [EFFECT_SET_DEFENSE_FINAL] = "EFFECT_SET_DEFENSE_FINAL",
    [EFFECT_SET_BASE_DEFENSE] = "EFFECT_SET_BASE_DEFENSE",
    [EFFECT_REVERSE_UPDATE] = "EFFECT_REVERSE_UPDATE",
    [EFFECT_SWAP_AD] = "EFFECT_SWAP_AD",
    [EFFECT_SWAP_BASE_AD] = "EFFECT_SWAP_BASE_AD",
    [EFFECT_SET_BASE_ATTACK_FINAL] = "EFFECT_SET_BASE_ATTACK_FINAL",
    [EFFECT_SET_BASE_DEFENSE_FINAL] = "EFFECT_SET_BASE_DEFENSE_FINAL",
    [EFFECT_ADD_CODE] = "EFFECT_ADD_CODE",
    [EFFECT_CHANGE_CODE] = "EFFECT_CHANGE_CODE",
    [EFFECT_ADD_TYPE] = "EFFECT_ADD_TYPE",
    [EFFECT_REMOVE_TYPE] = "EFFECT_REMOVE_TYPE",
    [EFFECT_CHANGE_TYPE] = "EFFECT_CHANGE_TYPE",
    [EFFECT_ADD_RACE] = "EFFECT_ADD_RACE",
    [EFFECT_REMOVE_RACE] = "EFFECT_REMOVE_RACE",
    [EFFECT_CHANGE_RACE] = "EFFECT_CHANGE_RACE",
    [EFFECT_ADD_ATTRIBUTE] = "EFFECT_ADD_ATTRIBUTE",
    [EFFECT_REMOVE_ATTRIBUTE] = "EFFECT_REMOVE_ATTRIBUTE",
    [EFFECT_CHANGE_ATTRIBUTE] = "EFFECT_CHANGE_ATTRIBUTE",
    [EFFECT_UPDATE_LEVEL] = "EFFECT_UPDATE_LEVEL",
    [EFFECT_CHANGE_LEVEL] = "EFFECT_CHANGE_LEVEL",
    [EFFECT_UPDATE_RANK] = "EFFECT_UPDATE_RANK",
    [EFFECT_CHANGE_RANK] = "EFFECT_CHANGE_RANK",
    [EFFECT_UPDATE_LSCALE] = "EFFECT_UPDATE_LSCALE",
    [EFFECT_CHANGE_LSCALE] = "EFFECT_CHANGE_LSCALE",
    [EFFECT_UPDATE_RSCALE] = "EFFECT_UPDATE_RSCALE",
    [EFFECT_CHANGE_RSCALE] = "EFFECT_CHANGE_RSCALE",
    [EFFECT_SET_POSITION] = "EFFECT_SET_POSITION",
    [EFFECT_SELF_DESTROY] = "EFFECT_SELF_DESTROY",
    [EFFECT_SELF_TOGRAVE] = "EFFECT_SELF_TOGRAVE",
    [EFFECT_DOUBLE_TRIBUTE] = "EFFECT_DOUBLE_TRIBUTE",
    [EFFECT_DECREASE_TRIBUTE] = "EFFECT_DECREASE_TRIBUTE",
    [EFFECT_DECREASE_TRIBUTE_SET] = "EFFECT_DECREASE_TRIBUTE_SET",
    [EFFECT_EXTRA_RELEASE] = "EFFECT_EXTRA_RELEASE",
    [EFFECT_TRIBUTE_LIMIT] = "EFFECT_TRIBUTE_LIMIT",
    [EFFECT_EXTRA_RELEASE_SUM] = "EFFECT_EXTRA_RELEASE_SUM",
    [EFFECT_TRIPLE_TRIBUTE] = "EFFECT_TRIPLE_TRIBUTE",
    [EFFECT_ADD_EXTRA_TRIBUTE] = "EFFECT_ADD_EXTRA_TRIBUTE",
    [EFFECT_EXTRA_RELEASE_NONSUM] = "EFFECT_EXTRA_RELEASE_NONSUM",
    [EFFECT_PUBLIC] = "EFFECT_PUBLIC",
    [EFFECT_COUNTER_PERMIT] = "EFFECT_COUNTER_PERMIT",
    [EFFECT_COUNTER_LIMIT] = "EFFECT_COUNTER_LIMIT",
    [EFFECT_RCOUNTER_REPLACE] = "EFFECT_RCOUNTER_REPLACE",
    [EFFECT_LPCOST_CHANGE] = "EFFECT_LPCOST_CHANGE",
    [EFFECT_LPCOST_REPLACE] = "EFFECT_LPCOST_REPLACE",
    [EFFECT_SKIP_DP] = "EFFECT_SKIP_DP",
    [EFFECT_SKIP_SP] = "EFFECT_SKIP_SP",
    [EFFECT_SKIP_M1] = "EFFECT_SKIP_M1",
    [EFFECT_SKIP_BP] = "EFFECT_SKIP_BP",
    [EFFECT_SKIP_M2] = "EFFECT_SKIP_M2",
    [EFFECT_CANNOT_BP] = "EFFECT_CANNOT_BP",
    [EFFECT_CANNOT_M2] = "EFFECT_CANNOT_M2",
    [EFFECT_CANNOT_EP] = "EFFECT_CANNOT_EP",
    [EFFECT_SKIP_TURN] = "EFFECT_SKIP_TURN",
    [EFFECT_DEFENSE_ATTACK] = "EFFECT_DEFENSE_ATTACK",
    [EFFECT_MUST_ATTACK] = "EFFECT_MUST_ATTACK",
    [EFFECT_FIRST_ATTACK] = "EFFECT_FIRST_ATTACK",
    [EFFECT_ATTACK_ALL] = "EFFECT_ATTACK_ALL",
    [EFFECT_EXTRA_ATTACK] = "EFFECT_EXTRA_ATTACK",
    [EFFECT_MUST_BE_ATTACKED] = "EFFECT_MUST_BE_ATTACKED",
    [EFFECT_ONLY_BE_ATTACKED] = "EFFECT_ONLY_BE_ATTACKED",
    [EFFECT_ATTACK_DISABLED] = "EFFECT_ATTACK_DISABLED",
    [EFFECT_NO_BATTLE_DAMAGE] = "EFFECT_NO_BATTLE_DAMAGE",
    [EFFECT_AVOID_BATTLE_DAMAGE] = "EFFECT_AVOID_BATTLE_DAMAGE",
    [EFFECT_REFLECT_BATTLE_DAMAGE] = "EFFECT_REFLECT_BATTLE_DAMAGE",
    [EFFECT_PIERCE] = "EFFECT_PIERCE",
    [EFFECT_BATTLE_DESTROY_REDIRECT] = "EFFECT_BATTLE_DESTROY_REDIRECT",
    [EFFECT_BATTLE_DAMAGE_TO_EFFECT] = "EFFECT_BATTLE_DAMAGE_TO_EFFECT",
    [EFFECT_BOTH_BATTLE_DAMAGE] = "EFFECT_BOTH_BATTLE_DAMAGE",
    [EFFECT_ALSO_BATTLE_DAMAGE] = "EFFECT_ALSO_BATTLE_DAMAGE",
    [EFFECT_CHANGE_BATTLE_DAMAGE] = "EFFECT_CHANGE_BATTLE_DAMAGE",
    [EFFECT_TOSS_COIN_REPLACE] = "EFFECT_TOSS_COIN_REPLACE",
    [EFFECT_TOSS_DICE_REPLACE] = "EFFECT_TOSS_DICE_REPLACE",
    [EFFECT_FUSION_MATERIAL] = "EFFECT_FUSION_MATERIAL",
    [EFFECT_CHAIN_MATERIAL] = "EFFECT_CHAIN_MATERIAL",
    [EFFECT_EXTRA_SYNCHRO_MATERIAL] = "EFFECT_EXTRA_SYNCHRO_MATERIAL",
    [EFFECT_XYZ_MATERIAL] = "EFFECT_XYZ_MATERIAL",
    [EFFECT_FUSION_SUBSTITUTE] = "EFFECT_FUSION_SUBSTITUTE",
    [EFFECT_CANNOT_BE_FUSION_MATERIAL] = "EFFECT_CANNOT_BE_FUSION_MATERIAL",
    [EFFECT_CANNOT_BE_SYNCHRO_MATERIAL] = "EFFECT_CANNOT_BE_SYNCHRO_MATERIAL",
    [EFFECT_SYNCHRO_MATERIAL_CUSTOM] = "EFFECT_SYNCHRO_MATERIAL_CUSTOM",
    [EFFECT_CANNOT_BE_XYZ_MATERIAL] = "EFFECT_CANNOT_BE_XYZ_MATERIAL",
    [EFFECT_CANNOT_BE_LINK_MATERIAL] = "EFFECT_CANNOT_BE_LINK_MATERIAL",
    [EFFECT_SYNCHRO_LEVEL] = "EFFECT_SYNCHRO_LEVEL",
    [EFFECT_RITUAL_LEVEL] = "EFFECT_RITUAL_LEVEL",
    [EFFECT_XYZ_LEVEL] = "EFFECT_XYZ_LEVEL",
    [EFFECT_EXTRA_RITUAL_MATERIAL] = "EFFECT_EXTRA_RITUAL_MATERIAL",
    [EFFECT_NONTUNER] = "EFFECT_NONTUNER",
    [EFFECT_OVERLAY_REMOVE_REPLACE] = "EFFECT_OVERLAY_REMOVE_REPLACE",
    [EFFECT_SCRAP_CHIMERA] = "EFFECT_SCRAP_CHIMERA",
    [EFFECT_TUNE_MAGICIAN_X] = "EFFECT_TUNE_MAGICIAN_X",
    [EFFECT_TUNE_MAGICIAN_F] = "EFFECT_TUNE_MAGICIAN_F",
    [EFFECT_PRE_MONSTER] = "EFFECT_PRE_MONSTER",
    [EFFECT_MATERIAL_CHECK] = "EFFECT_MATERIAL_CHECK",
    [EFFECT_DISABLE_FIELD] = "EFFECT_DISABLE_FIELD",
    [EFFECT_USE_EXTRA_MZONE] = "EFFECT_USE_EXTRA_MZONE",
    [EFFECT_USE_EXTRA_SZONE] = "EFFECT_USE_EXTRA_SZONE",
    [EFFECT_MAX_MZONE] = "EFFECT_MAX_MZONE",
    [EFFECT_MAX_SZONE] = "EFFECT_MAX_SZONE",
    [EFFECT_MUST_USE_MZONE] = "EFFECT_MUST_USE_MZONE",
    [EFFECT_HAND_LIMIT] = "EFFECT_HAND_LIMIT",
    [EFFECT_DRAW_COUNT] = "EFFECT_DRAW_COUNT",
    [EFFECT_SPIRIT_DONOT_RETURN] = "EFFECT_SPIRIT_DONOT_RETURN",
    [EFFECT_SPIRIT_MAYNOT_RETURN] = "EFFECT_SPIRIT_MAYNOT_RETURN",
    [EFFECT_CHANGE_ENVIRONMENT] = "EFFECT_CHANGE_ENVIRONMENT",
    [EFFECT_NECRO_VALLEY] = "EFFECT_NECRO_VALLEY",
    [EFFECT_FORBIDDEN] = "EFFECT_FORBIDDEN",
    [EFFECT_NECRO_VALLEY_IM] = "EFFECT_NECRO_VALLEY_IM",
    [EFFECT_REVERSE_DECK] = "EFFECT_REVERSE_DECK",
    [EFFECT_REMOVE_BRAINWASHING] = "EFFECT_REMOVE_BRAINWASHING",
    [EFFECT_BP_TWICE] = "EFFECT_BP_TWICE",
    [EFFECT_UNIQUE_CHECK] = "EFFECT_UNIQUE_CHECK",
    [EFFECT_MATCH_KILL] = "EFFECT_MATCH_KILL",
    [EFFECT_SYNCHRO_CHECK] = "EFFECT_SYNCHRO_CHECK",
    [EFFECT_QP_ACT_IN_NTPHAND] = "EFFECT_QP_ACT_IN_NTPHAND",
    [EFFECT_MUST_BE_SMATERIAL] = "EFFECT_MUST_BE_SMATERIAL",
    [EFFECT_TO_GRAVE_REDIRECT_CB] = "EFFECT_TO_GRAVE_REDIRECT_CB",
    [EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE] = "EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE",
    [EFFECT_CHANGE_RANK_FINAL] = "EFFECT_CHANGE_RANK_FINAL",
    [EFFECT_MUST_BE_FMATERIAL] = "EFFECT_MUST_BE_FMATERIAL",
    [EFFECT_MUST_BE_XMATERIAL] = "EFFECT_MUST_BE_XMATERIAL",
    [EFFECT_MUST_BE_LMATERIAL] = "EFFECT_MUST_BE_LMATERIAL",
    [EFFECT_SPSUMMON_PROC_G] = "EFFECT_SPSUMMON_PROC_G",
    [EFFECT_SPSUMMON_COUNT_LIMIT] = "EFFECT_SPSUMMON_COUNT_LIMIT",
    [EFFECT_LEFT_SPSUMMON_COUNT] = "EFFECT_LEFT_SPSUMMON_COUNT",
    [EFFECT_CANNOT_SELECT_BATTLE_TARGET] = "EFFECT_CANNOT_SELECT_BATTLE_TARGET",
    [EFFECT_CANNOT_SELECT_EFFECT_TARGET] = "EFFECT_CANNOT_SELECT_EFFECT_TARGET",
    [EFFECT_ADD_SETCODE] = "EFFECT_ADD_SETCODE",
    [EFFECT_NO_EFFECT_DAMAGE] = "EFFECT_NO_EFFECT_DAMAGE",
    [EFFECT_UNSUMMONABLE_CARD] = "EFFECT_UNSUMMONABLE_CARD",
    [EFFECT_DISABLE_CHAIN_FIELD] = "EFFECT_DISABLE_CHAIN_FIELD",
    [EFFECT_DISCARD_COST_CHANGE] = "EFFECT_DISCARD_COST_CHANGE",
    [EFFECT_HAND_SYNCHRO] = "EFFECT_HAND_SYNCHRO",
    [EFFECT_ADD_FUSION_CODE] = "EFFECT_ADD_FUSION_CODE",
    [EFFECT_ADD_FUSION_SETCODE] = "EFFECT_ADD_FUSION_SETCODE",
    [EFFECT_RISE_TO_FULL_HEIGHT] = "EFFECT_RISE_TO_FULL_HEIGHT",
    [EFFECT_ONLY_ATTACK_MONSTER] = "EFFECT_ONLY_ATTACK_MONSTER",
    [EFFECT_MUST_ATTACK_MONSTER] = "EFFECT_MUST_ATTACK_MONSTER",
    [EFFECT_PATRICIAN_OF_DARKNESS] = "EFFECT_PATRICIAN_OF_DARKNESS",
    [EFFECT_EXTRA_ATTACK_MONSTER] = "EFFECT_EXTRA_ATTACK_MONSTER",
    [EFFECT_UNION_STATUS] = "EFFECT_UNION_STATUS",
    [EFFECT_OLDUNION_STATUS] = "EFFECT_OLDUNION_STATUS",
    [EFFECT_ADD_FUSION_ATTRIBUTE] = "EFFECT_ADD_FUSION_ATTRIBUTE",
    [EFFECT_REMOVE_FUSION_ATTRIBUTE] = "EFFECT_REMOVE_FUSION_ATTRIBUTE",
    [EFFECT_CHANGE_FUSION_ATTRIBUTE] = "EFFECT_CHANGE_FUSION_ATTRIBUTE",
    [EFFECT_EXTRA_FUSION_MATERIAL] = "EFFECT_EXTRA_FUSION_MATERIAL",
    [EFFECT_TUNER_MATERIAL_LIMIT] = "EFFECT_TUNER_MATERIAL_LIMIT",
    [EFFECT_ADD_LINK_CODE] = "EFFECT_ADD_LINK_CODE",
    [EFFECT_ADD_LINK_SETCODE] = "EFFECT_ADD_LINK_SETCODE",
    [EFFECT_ADD_LINK_ATTRIBUTE] = "EFFECT_ADD_LINK_ATTRIBUTE",
    [EFFECT_ADD_LINK_RACE] = "EFFECT_ADD_LINK_RACE",
    [EFFECT_EXTRA_LINK_MATERIAL] = "EFFECT_EXTRA_LINK_MATERIAL",
    [EFFECT_QP_ACT_IN_SET_TURN] = "EFFECT_QP_ACT_IN_SET_TURN",
    [EFFECT_EXTRA_PENDULUM_SUMMON] = "EFFECT_EXTRA_PENDULUM_SUMMON",
    [EFFECT_MATERIAL_LIMIT] = "EFFECT_MATERIAL_LIMIT",
    [EFFECT_SET_BATTLE_ATTACK] = "EFFECT_SET_BATTLE_ATTACK",
    [EFFECT_SET_BATTLE_DEFENSE] = "EFFECT_SET_BATTLE_DEFENSE",
    [EFFECT_OVERLAY_RITUAL_MATERIAL] = "EFFECT_OVERLAY_RITUAL_MATERIAL",
    [EFFECT_CHANGE_GRAVE_ATTRIBUTE] = "EFFECT_CHANGE_GRAVE_ATTRIBUTE",
    [EFFECT_CHANGE_GRAVE_RACE] = "EFFECT_CHANGE_GRAVE_RACE",
    [EFFECT_ACTIVATION_COUNT_LIMIT] = "EFFECT_ACTIVATION_COUNT_LIMIT",
    [EFFECT_LIMIT_SPECIAL_SUMMON_POSITION] = "EFFECT_LIMIT_SPECIAL_SUMMON_POSITION",
    [EFFECT_TUNER] = "EFFECT_TUNER",
    [EFFECT_KAISER_COLOSSEUM] = "EFFECT_KAISER_COLOSSEUM",
    [EFFECT_REPLACE_DAMAGE] = "EFFECT_REPLACE_DAMAGE",
    [EFFECT_XYZ_MIN_COUNT] = "EFFECT_XYZ_MIN_COUNT",
    [EFFECT_SYNCHRO_LEVEL_EX] = "EFFECT_SYNCHRO_LEVEL_EX",
    [EFFECT_RITUAL_LEVEL_EX] = "EFFECT_RITUAL_LEVEL_EX",
    [EFFECT_FLAG_EFFECT] = "EFFECT_FLAG_EFFECT",
    [EVENT_STARTUP] = "EVENT_STARTUP",
    [EVENT_FLIP] = "EVENT_FLIP",
    [EVENT_FREE_CHAIN] = "EVENT_FREE_CHAIN",
    [EVENT_DESTROY] = "EVENT_DESTROY",
    [EVENT_REMOVE] = "EVENT_REMOVE",
    [EVENT_TO_HAND] = "EVENT_TO_HAND",
    [EVENT_TO_DECK] = "EVENT_TO_DECK",
    [EVENT_TO_GRAVE] = "EVENT_TO_GRAVE",
    [EVENT_LEAVE_FIELD] = "EVENT_LEAVE_FIELD",
    [EVENT_CHANGE_POS] = "EVENT_CHANGE_POS",
    [EVENT_RELEASE] = "EVENT_RELEASE",
    [EVENT_DISCARD] = "EVENT_DISCARD",
    [EVENT_LEAVE_FIELD_P] = "EVENT_LEAVE_FIELD_P",
    [EVENT_CHAIN_SOLVING] = "EVENT_CHAIN_SOLVING",
    [EVENT_CHAIN_ACTIVATING] = "EVENT_CHAIN_ACTIVATING",
    [EVENT_CHAIN_SOLVED] = "EVENT_CHAIN_SOLVED",
    [EVENT_CHAIN_ACTIVATED] = "EVENT_CHAIN_ACTIVATED",
    [EVENT_CHAIN_NEGATED] = "EVENT_CHAIN_NEGATED",
    [EVENT_CHAIN_DISABLED] = "EVENT_CHAIN_DISABLED",
    [EVENT_CHAIN_END] = "EVENT_CHAIN_END",
    [EVENT_CHAINING] = "EVENT_CHAINING",
    [EVENT_BECOME_TARGET] = "EVENT_BECOME_TARGET",
    [EVENT_DESTROYED] = "EVENT_DESTROYED",
    [EVENT_MOVE] = "EVENT_MOVE",
    [EVENT_LEAVE_GRAVE] = "EVENT_LEAVE_GRAVE",
    [EVENT_LEAVE_DECK] = "EVENT_LEAVE_DECK",
    [EVENT_ADJUST] = "EVENT_ADJUST",
    [EVENT_BREAK_EFFECT] = "EVENT_BREAK_EFFECT",
    [EVENT_SUMMON_SUCCESS] = "EVENT_SUMMON_SUCCESS",
    [EVENT_FLIP_SUMMON_SUCCESS] = "EVENT_FLIP_SUMMON_SUCCESS",
    [EVENT_SPSUMMON_SUCCESS] = "EVENT_SPSUMMON_SUCCESS",
    [EVENT_SUMMON] = "EVENT_SUMMON",
    [EVENT_FLIP_SUMMON] = "EVENT_FLIP_SUMMON",
    [EVENT_SPSUMMON] = "EVENT_SPSUMMON",
    [EVENT_MSET] = "EVENT_MSET",
    [EVENT_SSET] = "EVENT_SSET",
    [EVENT_BE_MATERIAL] = "EVENT_BE_MATERIAL",
    [EVENT_BE_PRE_MATERIAL] = "EVENT_BE_PRE_MATERIAL",
    [EVENT_DRAW] = "EVENT_DRAW",
    [EVENT_DAMAGE] = "EVENT_DAMAGE",
    [EVENT_RECOVER] = "EVENT_RECOVER",
    [EVENT_PREDRAW] = "EVENT_PREDRAW",
    [EVENT_SUMMON_NEGATED] = "EVENT_SUMMON_NEGATED",
    [EVENT_FLIP_SUMMON_NEGATED] = "EVENT_FLIP_SUMMON_NEGATED",
    [EVENT_SPSUMMON_NEGATED] = "EVENT_SPSUMMON_NEGATED",
    [EVENT_SPSUMMON_SUCCESS_G_P] = "EVENT_SPSUMMON_SUCCESS_G_P",
    [EVENT_CONTROL_CHANGED] = "EVENT_CONTROL_CHANGED",
    [EVENT_EQUIP] = "EVENT_EQUIP",
    [EVENT_ATTACK_ANNOUNCE] = "EVENT_ATTACK_ANNOUNCE",
    [EVENT_BE_BATTLE_TARGET] = "EVENT_BE_BATTLE_TARGET",
    [EVENT_BATTLE_START] = "EVENT_BATTLE_START",
    [EVENT_BATTLE_CONFIRM] = "EVENT_BATTLE_CONFIRM",
    [EVENT_PRE_DAMAGE_CALCULATE] = "EVENT_PRE_DAMAGE_CALCULATE",
    [EVENT_DAMAGE_CALCULATING] = "EVENT_DAMAGE_CALCULATING",
    [EVENT_PRE_BATTLE_DAMAGE] = "EVENT_PRE_BATTLE_DAMAGE",
    [EVENT_BATTLE_END] = "EVENT_BATTLE_END",
    [EVENT_BATTLED] = "EVENT_BATTLED",
    [EVENT_BATTLE_DESTROYING] = "EVENT_BATTLE_DESTROYING",
    [EVENT_BATTLE_DESTROYED] = "EVENT_BATTLE_DESTROYED",
    [EVENT_DAMAGE_STEP_END] = "EVENT_DAMAGE_STEP_END",
    [EVENT_ATTACK_DISABLED] = "EVENT_ATTACK_DISABLED",
    [EVENT_BATTLE_DAMAGE] = "EVENT_BATTLE_DAMAGE",
    [EVENT_TOSS_DICE] = "EVENT_TOSS_DICE",
    [EVENT_TOSS_COIN] = "EVENT_TOSS_COIN",
    [EVENT_TOSS_COIN_NEGATE] = "EVENT_TOSS_COIN_NEGATE",
    [EVENT_TOSS_DICE_NEGATE] = "EVENT_TOSS_DICE_NEGATE",
    [EVENT_LEVEL_UP] = "EVENT_LEVEL_UP",
    [EVENT_PAY_LPCOST] = "EVENT_PAY_LPCOST",
    [EVENT_DETACH_MATERIAL] = "EVENT_DETACH_MATERIAL",
    [EVENT_RETURN_TO_GRAVE] = "EVENT_RETURN_TO_GRAVE",
    [EVENT_TURN_END] = "EVENT_TURN_END",
    [EVENT_PHASE] = "EVENT_PHASE",
    [EVENT_PHASE_START] = "EVENT_PHASE_START",
    [EVENT_ADD_COUNTER] = "EVENT_ADD_COUNTER",
    [EVENT_REMOVE_COUNTER] = "EVENT_REMOVE_COUNTER",
    [EVENT_CUSTOM] = "EVENT_CUSTOM",
  }

  local PROCESSOR_ADJUST = 1
  local PROCESSOR_HINT = 2
  local PROCESSOR_TURN = 3
  local PROCESSOR_WAIT = 4
  local PROCESSOR_REFRESH_LOC = 5
  local PROCESSOR_SELECT_IDLECMD = 10
  local PROCESSOR_SELECT_EFFECTYN = 11
  local PROCESSOR_SELECT_BATTLECMD = 12
  local PROCESSOR_SELECT_YESNO = 13
  local PROCESSOR_SELECT_OPTION = 14
  local PROCESSOR_SELECT_CARD = 15
  local PROCESSOR_SELECT_CHAIN = 16
  local PROCESSOR_SELECT_UNSELECT_CARD = 17
  local PROCESSOR_SELECT_PLACE = 18
  local PROCESSOR_SELECT_POSITION = 19
  local PROCESSOR_SELECT_TRIBUTE_P = 20
  local PROCESSOR_SELECT_COUNTER = 22
  local PROCESSOR_SELECT_SUM = 23
  local PROCESSOR_SELECT_DISFIELD = 24
  local PROCESSOR_SORT_CARD = 25
  local PROCESSOR_SELECT_RELEASE = 26
  local PROCESSOR_SELECT_TRIBUTE = 27
  local PROCESSOR_POINT_EVENT = 30
  local PROCESSOR_QUICK_EFFECT = 31
  local PROCESSOR_IDLE_COMMAND = 32
  local PROCESSOR_PHASE_EVENT = 33
  local PROCESSOR_BATTLE_COMMAND = 34
  local PROCESSOR_DAMAGE_STEP = 35
  local PROCESSOR_ADD_CHAIN = 40
  local PROCESSOR_SOLVE_CHAIN = 42
  local PROCESSOR_SOLVE_CONTINUOUS = 43
  local PROCESSOR_EXECUTE_COST = 44
  local PROCESSOR_EXECUTE_OPERATION = 45
  local PROCESSOR_EXECUTE_TARGET = 46
  local PROCESSOR_DESTROY = 50
  local PROCESSOR_RELEASE = 51
  local PROCESSOR_SENDTO = 52
  local PROCESSOR_MOVETOFIELD = 53
  local PROCESSOR_CHANGEPOS = 54
  local PROCESSOR_OPERATION_REPLACE = 55
  local PROCESSOR_DESTROY_REPLACE = 56
  local PROCESSOR_RELEASE_REPLACE = 57
  local PROCESSOR_SENDTO_REPLACE = 58
  local PROCESSOR_SUMMON_RULE = 60
  local PROCESSOR_SPSUMMON_RULE = 61
  local PROCESSOR_SPSUMMON = 62
  local PROCESSOR_FLIP_SUMMON = 63
  local PROCESSOR_MSET = 64
  local PROCESSOR_SSET = 65
  local PROCESSOR_SPSUMMON_STEP = 66
  local PROCESSOR_SSET_G = 67
  local PROCESSOR_DRAW = 70
  local PROCESSOR_DAMAGE = 71
  local PROCESSOR_RECOVER = 72
  local PROCESSOR_EQUIP = 73
  local PROCESSOR_GET_CONTROL = 74
  local PROCESSOR_SWAP_CONTROL = 75
  local PROCESSOR_CONTROL_ADJUST = 76
  local PROCESSOR_SELF_DESTROY = 77
  local PROCESSOR_TRAP_MONSTER_ADJUST = 78
  local PROCESSOR_PAY_LPCOST = 80
  local PROCESSOR_REMOVE_COUNTER = 81
  local PROCESSOR_ATTACK_DISABLE = 82
  local PROCESSOR_ACTIVATE_EFFECT = 83
  local PROCESSOR_ANNOUNCE_RACE = 110
  local PROCESSOR_ANNOUNCE_ATTRIB = 111
  local PROCESSOR_ANNOUNCE_LEVEL = 112
  local PROCESSOR_ANNOUNCE_CARD = 113
  local PROCESSOR_ANNOUNCE_TYPE = 114
  local PROCESSOR_ANNOUNCE_NUMBER = 115
  local PROCESSOR_ANNOUNCE_COIN = 116
  local PROCESSOR_TOSS_DICE = 117
  local PROCESSOR_TOSS_COIN = 118
  local PROCESSOR_ROCK_PAPER_SCISSORS = 119
  local PROCESSOR_SELECT_FUSION = 131
  local PROCESSOR_SELECT_SYNCHRO = 132
  local PROCESSOR_SELECT_XMATERIAL = 139
  local PROCESSOR_DISCARD_HAND = 150
  local PROCESSOR_DISCARD_DECK = 151
  local PROCESSOR_SORT_DECK = 152
  local PROCESSOR_REMOVE_OVERLAY = 160
  local PROCESSOR_SORT_CHAIN = 21
  local PROCESSOR_DESTROY_S = 100
  local PROCESSOR_RELEASE_S = 101
  local PROCESSOR_SENDTO_S = 102
  local PROCESSOR_CHANGEPOS_S = 103
  local PROCESSOR_SELECT_YESNO_S = 120
  local PROCESSOR_SELECT_OPTION_S = 121
  local PROCESSOR_SELECT_CARD_S = 122
  local PROCESSOR_SELECT_EFFECTYN_S = 123
  local PROCESSOR_SELECT_UNSELECT_CARD_S = 124
  local PROCESSOR_SELECT_PLACE_S = 125
  local PROCESSOR_SELECT_POSITION_S = 126
  local PROCESSOR_SELECT_TRIBUTE_S = 127
  local PROCESSOR_SORT_CARDS_S = 128
  local PROCESSOR_SELECT_RELEASE_S = 129
  local PROCESSOR_SELECT_TARGET = 130
  local PROCESSOR_SELECT_SUM_S = 133
  local PROCESSOR_SELECT_DISFIELD_S = 134
  local PROCESSOR_SPSUMMON_S = 135
  local PROCESSOR_SPSUMMON_STEP_S = 136
  local PROCESSOR_SPSUMMON_COMP_S = 137
  local PROCESSOR_RANDOM_SELECT_S = 138
  local PROCESSOR_DRAW_S = 140
  local PROCESSOR_DAMAGE_S = 141
  local PROCESSOR_RECOVER_S = 142
  local PROCESSOR_EQUIP_S = 143
  local PROCESSOR_GET_CONTROL_S = 144
  local PROCESSOR_SWAP_CONTROL_S = 145
  local PROCESSOR_MOVETOFIELD_S = 161

  aux["PROCESSOR"] = {
    [PROCESSOR_ADJUST] = "PROCESSOR_ADJUST",
    [PROCESSOR_HINT] = "PROCESSOR_HINT",
    [PROCESSOR_TURN] = "PROCESSOR_TURN",
    [PROCESSOR_WAIT] = "PROCESSOR_WAIT",
    [PROCESSOR_REFRESH_LOC] = "PROCESSOR_REFRESH_LOC",
    [PROCESSOR_SELECT_IDLECMD] = "PROCESSOR_SELECT_IDLECMD",
    [PROCESSOR_SELECT_EFFECTYN] = "PROCESSOR_SELECT_EFFECTYN",
    [PROCESSOR_SELECT_BATTLECMD] = "PROCESSOR_SELECT_BATTLECMD",
    [PROCESSOR_SELECT_YESNO] = "PROCESSOR_SELECT_YESNO",
    [PROCESSOR_SELECT_OPTION] = "PROCESSOR_SELECT_OPTION",
    [PROCESSOR_SELECT_CARD] = "PROCESSOR_SELECT_CARD",
    [PROCESSOR_SELECT_CHAIN] = "PROCESSOR_SELECT_CHAIN",
    [PROCESSOR_SELECT_UNSELECT_CARD] = "PROCESSOR_SELECT_UNSELECT_CARD",
    [PROCESSOR_SELECT_PLACE] = "PROCESSOR_SELECT_PLACE",
    [PROCESSOR_SELECT_POSITION] = "PROCESSOR_SELECT_POSITION",
    [PROCESSOR_SELECT_TRIBUTE_P] = "PROCESSOR_SELECT_TRIBUTE_P",
    [PROCESSOR_SELECT_COUNTER] = "PROCESSOR_SELECT_COUNTER",
    [PROCESSOR_SELECT_SUM] = "PROCESSOR_SELECT_SUM",
    [PROCESSOR_SELECT_DISFIELD] = "PROCESSOR_SELECT_DISFIELD",
    [PROCESSOR_SORT_CARD] = "PROCESSOR_SORT_CARD",
    [PROCESSOR_SELECT_RELEASE] = "PROCESSOR_SELECT_RELEASE",
    [PROCESSOR_SELECT_TRIBUTE] = "PROCESSOR_SELECT_TRIBUTE",
    [PROCESSOR_POINT_EVENT] = "PROCESSOR_POINT_EVENT",
    [PROCESSOR_QUICK_EFFECT] = "PROCESSOR_QUICK_EFFECT",
    [PROCESSOR_IDLE_COMMAND] = "PROCESSOR_IDLE_COMMAND",
    [PROCESSOR_PHASE_EVENT] = "PROCESSOR_PHASE_EVENT",
    [PROCESSOR_BATTLE_COMMAND] = "PROCESSOR_BATTLE_COMMAND",
    [PROCESSOR_DAMAGE_STEP] = "PROCESSOR_DAMAGE_STEP",
    [PROCESSOR_ADD_CHAIN] = "PROCESSOR_ADD_CHAIN",
    [PROCESSOR_SOLVE_CHAIN] = "PROCESSOR_SOLVE_CHAIN",
    [PROCESSOR_SOLVE_CONTINUOUS] = "PROCESSOR_SOLVE_CONTINUOUS",
    [PROCESSOR_EXECUTE_COST] = "PROCESSOR_EXECUTE_COST",
    [PROCESSOR_EXECUTE_OPERATION] = "PROCESSOR_EXECUTE_OPERATION",
    [PROCESSOR_EXECUTE_TARGET] = "PROCESSOR_EXECUTE_TARGET",
    [PROCESSOR_DESTROY] = "PROCESSOR_DESTROY",
    [PROCESSOR_RELEASE] = "PROCESSOR_RELEASE",
    [PROCESSOR_SENDTO] = "PROCESSOR_SENDTO",
    [PROCESSOR_MOVETOFIELD] = "PROCESSOR_MOVETOFIELD",
    [PROCESSOR_CHANGEPOS] = "PROCESSOR_CHANGEPOS",
    [PROCESSOR_OPERATION_REPLACE] = "PROCESSOR_OPERATION_REPLACE",
    [PROCESSOR_DESTROY_REPLACE] = "PROCESSOR_DESTROY_REPLACE",
    [PROCESSOR_RELEASE_REPLACE] = "PROCESSOR_RELEASE_REPLACE",
    [PROCESSOR_SENDTO_REPLACE] = "PROCESSOR_SENDTO_REPLACE",
    [PROCESSOR_SUMMON_RULE] = "PROCESSOR_SUMMON_RULE",
    [PROCESSOR_SPSUMMON_RULE] = "PROCESSOR_SPSUMMON_RULE",
    [PROCESSOR_SPSUMMON] = "PROCESSOR_SPSUMMON",
    [PROCESSOR_FLIP_SUMMON] = "PROCESSOR_FLIP_SUMMON",
    [PROCESSOR_MSET] = "PROCESSOR_MSET",
    [PROCESSOR_SSET] = "PROCESSOR_SSET",
    [PROCESSOR_SPSUMMON_STEP] = "PROCESSOR_SPSUMMON_STEP",
    [PROCESSOR_SSET_G] = "PROCESSOR_SSET_G",
    [PROCESSOR_DRAW] = "PROCESSOR_DRAW",
    [PROCESSOR_DAMAGE] = "PROCESSOR_DAMAGE",
    [PROCESSOR_RECOVER] = "PROCESSOR_RECOVER",
    [PROCESSOR_EQUIP] = "PROCESSOR_EQUIP",
    [PROCESSOR_GET_CONTROL] = "PROCESSOR_GET_CONTROL",
    [PROCESSOR_SWAP_CONTROL] = "PROCESSOR_SWAP_CONTROL",
    [PROCESSOR_CONTROL_ADJUST] = "PROCESSOR_CONTROL_ADJUST",
    [PROCESSOR_SELF_DESTROY] = "PROCESSOR_SELF_DESTROY",
    [PROCESSOR_TRAP_MONSTER_ADJUST] = "PROCESSOR_TRAP_MONSTER_ADJUST",
    [PROCESSOR_PAY_LPCOST] = "PROCESSOR_PAY_LPCOST",
    [PROCESSOR_REMOVE_COUNTER] = "PROCESSOR_REMOVE_COUNTER",
    [PROCESSOR_ATTACK_DISABLE] = "PROCESSOR_ATTACK_DISABLE",
    [PROCESSOR_ACTIVATE_EFFECT] = "PROCESSOR_ACTIVATE_EFFECT",
    [PROCESSOR_ANNOUNCE_RACE] = "PROCESSOR_ANNOUNCE_RACE",
    [PROCESSOR_ANNOUNCE_ATTRIB] = "PROCESSOR_ANNOUNCE_ATTRIB",
    [PROCESSOR_ANNOUNCE_LEVEL] = "PROCESSOR_ANNOUNCE_LEVEL",
    [PROCESSOR_ANNOUNCE_CARD] = "PROCESSOR_ANNOUNCE_CARD",
    [PROCESSOR_ANNOUNCE_TYPE] = "PROCESSOR_ANNOUNCE_TYPE",
    [PROCESSOR_ANNOUNCE_NUMBER] = "PROCESSOR_ANNOUNCE_NUMBER",
    [PROCESSOR_ANNOUNCE_COIN] = "PROCESSOR_ANNOUNCE_COIN",
    [PROCESSOR_TOSS_DICE] = "PROCESSOR_TOSS_DICE",
    [PROCESSOR_TOSS_COIN] = "PROCESSOR_TOSS_COIN",
    [PROCESSOR_ROCK_PAPER_SCISSORS] = "PROCESSOR_ROCK_PAPER_SCISSORS",
    [PROCESSOR_SELECT_FUSION] = "PROCESSOR_SELECT_FUSION",
    [PROCESSOR_SELECT_SYNCHRO] = "PROCESSOR_SELECT_SYNCHRO",
    [PROCESSOR_SELECT_XMATERIAL] = "PROCESSOR_SELECT_XMATERIAL",
    [PROCESSOR_DISCARD_HAND] = "PROCESSOR_DISCARD_HAND",
    [PROCESSOR_DISCARD_DECK] = "PROCESSOR_DISCARD_DECK",
    [PROCESSOR_SORT_DECK] = "PROCESSOR_SORT_DECK",
    [PROCESSOR_REMOVE_OVERLAY] = "PROCESSOR_REMOVE_OVERLAY",
    [PROCESSOR_SORT_CHAIN] = "PROCESSOR_SORT_CHAIN",
    [PROCESSOR_DESTROY_S] = "PROCESSOR_DESTROY_S",
    [PROCESSOR_RELEASE_S] = "PROCESSOR_RELEASE_S",
    [PROCESSOR_SENDTO_S] = "PROCESSOR_SENDTO_S",
    [PROCESSOR_CHANGEPOS_S] = "PROCESSOR_CHANGEPOS_S",
    [PROCESSOR_SELECT_YESNO_S] = "PROCESSOR_SELECT_YESNO_S",
    [PROCESSOR_SELECT_OPTION_S] = "PROCESSOR_SELECT_OPTION_S",
    [PROCESSOR_SELECT_CARD_S] = "PROCESSOR_SELECT_CARD_S",
    [PROCESSOR_SELECT_EFFECTYN_S] = "PROCESSOR_SELECT_EFFECTYN_S",
    [PROCESSOR_SELECT_UNSELECT_CARD_S] = "PROCESSOR_SELECT_UNSELECT_CARD_S",
    [PROCESSOR_SELECT_PLACE_S] = "PROCESSOR_SELECT_PLACE_S",
    [PROCESSOR_SELECT_POSITION_S] = "PROCESSOR_SELECT_POSITION_S",
    [PROCESSOR_SELECT_TRIBUTE_S] = "PROCESSOR_SELECT_TRIBUTE_S",
    [PROCESSOR_SORT_CARDS_S] = "PROCESSOR_SORT_CARDS_S",
    [PROCESSOR_SELECT_RELEASE_S] = "PROCESSOR_SELECT_RELEASE_S",
    [PROCESSOR_SELECT_TARGET] = "PROCESSOR_SELECT_TARGET",
    [PROCESSOR_SELECT_SUM_S] = "PROCESSOR_SELECT_SUM_S",
    [PROCESSOR_SELECT_DISFIELD_S] = "PROCESSOR_SELECT_DISFIELD_S",
    [PROCESSOR_SPSUMMON_S] = "PROCESSOR_SPSUMMON_S",
    [PROCESSOR_SPSUMMON_STEP_S] = "PROCESSOR_SPSUMMON_STEP_S",
    [PROCESSOR_SPSUMMON_COMP_S] = "PROCESSOR_SPSUMMON_COMP_S",
    [PROCESSOR_RANDOM_SELECT_S] = "PROCESSOR_RANDOM_SELECT_S",
    [PROCESSOR_DRAW_S] = "PROCESSOR_DRAW_S",
    [PROCESSOR_DAMAGE_S] = "PROCESSOR_DAMAGE_S",
    [PROCESSOR_RECOVER_S] = "PROCESSOR_RECOVER_S",
    [PROCESSOR_EQUIP_S] = "PROCESSOR_EQUIP_S",
    [PROCESSOR_GET_CONTROL_S] = "PROCESSOR_GET_CONTROL_S",
    [PROCESSOR_SWAP_CONTROL_S] = "PROCESSOR_SWAP_CONTROL_S",
    [PROCESSOR_MOVETOFIELD_S] = "PROCESSOR_MOVETOFIELD_S",
  }

  local dispatch = {}

  dispatch.REASON = function(constant, type)
    local list = {}
    for i1, i2 in pairs(aux[type]) do
      if (i1 & constant) == 0 then
      else
        list[#list + 1] = i2
      end
    end
    return list
  end

  dispatch.LOCATION = dispatch.REASON

  dispatch.CODE = function(constant, type)
    local list = {}
    list[#list + 1] = aux[type][constant]
    return list
  end

  dispatch.PROCESSOR = dispatch.CODE

  aux.DebugConstant = function(constant, type)
    if not constant then
      return ""
    end
    local list = dispatch[type](constant, type)
    return table.concat(list, "\n")
  end

  aux.ShowConstant = function(constant, type)
    Debug.ShowHint(aux.DebugConstant(constant, type))
  end
end
