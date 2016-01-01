function _slice(array, first, last)
  local output = {}

  for i=first, last do
    table.insert(output, array[i])
  end

  return output
end

function _concat(first, second)
  for i=1, #second do
    first[#first+1] = second[i]
  end

  return first
end

function _merge(left, right, comp)
  local left_size, right_size = #left, #right
  local left_index, right_index = 1, 1
  local output = {}

  repeat
    if left_index <= left_size and right_index <= right_size then
      if left[left_index] < right[right_index] then
        table.insert(output, left[left_index])
        left_index = left_index + 1
      else
        table.insert(output, right[right_index])
        right_index = right_index + 1
      end
    elseif left_index <= left_size then
        table.insert(output, left[left_index])
        left_index = left_index + 1
    else
        table.insert(output, right[right_index])
        right_index = right_index + 1
    end
  until (left_index > left_size and right_index > right_size)

  return output
end

function merge_sort(items)
  if #items < 2 then return items end

  local middle = math.floor(#items / 2)
  local left = _slice(items, 1, middle)
  local right = _slice(items, middle+1, #items)

  return _merge(merge_sort(left), merge_sort(right))
end

return merge_sort
