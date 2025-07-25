--召喚獣カリギュラ
function c13529466.initial_effect(c)
  --fusion material
  c:EnableReviveLimit()
  aux.AddFusionProcCodeFun(c, 86120751, aux.FilterBoolFunction(Card.IsFusionAttribute, ATTRIBUTE_DARK), 1, true, true)
  --activate limit
  local e3 = Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e3:SetCode(EFFECT_ACTIVATE_COST)
  e3:SetRange(LOCATION_MZONE)
  e3:SetTargetRange(1, 0)
  e3:SetTarget(c13529466.limtg)
  e3:SetCost(aux.TRUE)
  e3:SetOperation(c13529466.limop)
  c:RegisterEffect(e3)
  local e6 = e3:Clone()
  e6:SetTargetRange(0, 1)
  c:RegisterEffect(e6)
  --attack limit
  local e7 = Effect.CreateEffect(c)
  e7:SetType(EFFECT_TYPE_FIELD)
  e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
  e7:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
  e7:SetRange(LOCATION_MZONE)
  e7:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
  e7:SetCondition(c13529466.atkcon)
  e7:SetTarget(c13529466.atktg)
  c:RegisterEffect(e7)
  local e8 = Effect.CreateEffect(c)
  e8:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
  e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e8:SetCode(EVENT_ATTACK_ANNOUNCE)
  e8:SetRange(LOCATION_MZONE)
  e8:SetOperation(c13529466.checkop)
  e8:SetLabelObject(e7)
  c:RegisterEffect(e8)
end
function c13529466.limtg(e, te, tp)
  return te:IsActiveType(TYPE_MONSTER)
end
function c13529466.limop(e, tp, eg, ep, ev, re, r, rp)
  e:SetCost(aux.FALSE)
end
function c13529466.atkcon(e)
  return e:GetHandler():GetFlagEffect(13529468) ~= 0
end
function c13529466.atktg(e, c)
  return c:GetFieldID() ~= e:GetLabel()
end
function c13529466.checkop(e, tp, eg, ep, ev, re, r, rp)
  if e:GetHandler():GetFlagEffect(13529468) ~= 0 then
    return
  end
  local fid = eg:GetFirst():GetFieldID()
  e:GetHandler():RegisterFlagEffect(13529468, RESET_EVENT + RESETS_STANDARD + RESET_PHASE + PHASE_END, 0, 1)
  e:GetLabelObject():SetLabel(fid)
end
