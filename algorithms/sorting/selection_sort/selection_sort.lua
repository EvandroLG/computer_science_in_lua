local swap = function(elements, first, second)
  local temp = elements[first]
  elements[first] = elements[second]
  elements[second] = temp
end

local selection_sort = function(elements)
  local size = #elements
  local min

  for i=1, size do
    min = i 

    for j=i+1, size do
      if elements[j] < elements[min] then
        min = j
      end
    end

    if i ~= min then
      swap(elements, i, min)
    end
  end
end

return selection_sort
