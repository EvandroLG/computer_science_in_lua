function _slice(array, first, last)
  local output = {}
  local i = first

  while i <= last do
    table.insert(output, array[i])
    i = i + 1
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
  local index_left = 0
  local index_right = 0

  while index_left < #left and index_right < #right do
    if left[index_left] < right[index_right] then
      table.insert(output, left[index_left])
    else
      table.insert(output, right[index_right])
    end
  end

  return _concat(_slice(left, index_left, #left),
                 _slice(right, index_right, #right))
end

function merge_sort(items)
  if #items < 2 then return items end

  local middle = math.floor(#items / 2)
  local left = _slice(items, 1, middle)
  local right = _slice(items, middle, #items)

  return _merge(merge_sort(left), merge_sort(right))
end

return merge_sort
