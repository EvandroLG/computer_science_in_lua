local insertion_sort = function(elements)
  local new_value = nil
  local size = #elements

  for i = 2, size do
    new_value = elements[i]
    j = i

    while j > 1 and elements[j - 1] > new_value do
      elements[j] = elements[j - 1]
      j = j - 1
    end

    elements[j] = new_value
  end
end

return insertion_sort
