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

function _merge(left, right)
  local output = {}
  local index_left = 1
  local index_right = 1

  while index_left < #left and index_right < #right do
    if left[index_left] < right[index_right] then
      table.insert(output, left[index_left])
      index_left = index_left + 1
    else
      table.insert(output, right[index_right])
      index_right = index_right + 1
    end
  end

  return _concat(_slice(left, index_left, #left),
                 _slice(right, index_right, #right))
end

function merge_sort(items)
  if #items < 2 then return items end

  local middle = math.floor(#items / 2)
  local left = _slice(items, 1, middle)
  local right = _slice(items, middle+1, #items)

  return _merge(merge_sort(left), merge_sort(right))
end

return merge_sort
