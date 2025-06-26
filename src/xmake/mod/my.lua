files = function(o1)
  local k1 = {}
  for i = 1, #o1 do
    table.join2(k1, os.files(o1[i]))
  end
  return k1
end
