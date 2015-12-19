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
      elements[i], elements[min] = elements[min], elements[i]
    end
  end
end

return selection_sort
