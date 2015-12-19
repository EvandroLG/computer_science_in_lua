function bubble_sort(elements)
  local size = #elements

  for i=1, size do
    for j=1, size - i do
      if elements[j] > elements[j+1] then
        elements[j], elements[j+1] = elements[j+1], elements[j]
      end
    end
  end
end

return bubble_sort
