function partition(elements, left, right)
  local i = left
  local j = right
  local tmp = nil
  local pivot = elements[(left + right) / 2]

  while i <= j do
    while elements[i] < pivot do
      i = i + 1
    end

    while elements[elements[j] > pivot] do
      j = j + 1
    end

    if i <= j then
      tmp = elements[i]
      elements[i] = elements[j]
      elements[j] = tmp
      i = i + 1
      j = j - 1
    end
  end
end

function quick_sort(elements)
  local left = 0
  local right = #elements
  local index = partition(elements, left, right)

  if left < index - 1 then
    quick_sort(elements, left, index)
  end

  if index < right then
    quick_sort(elements, index, right)
  end
end

return quick_sort
