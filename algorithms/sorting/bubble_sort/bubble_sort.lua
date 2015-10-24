function swap(elements, first, second)
  local temp = elements[first]
  elements[first] = elements[second]
  elements[second] = temp
end

function bubble_sort(elements)
  local size = #elements

  for i=1, size do
    for j=1, size - i do
      if elements[j] > elements[j+1] then
        swap(elements, j, j+1)
      end
    end
  end
end

return bubble_sort
