function binary_search(list, item)
  first = 1
  last = #list
  found = false

  while first <= last and found == false do
    middle = math.ceil((first + last) / 2)

    if list[middle] == item then
      return true
    elseif list[middle] > item then
      last = middle - 1
    else
      first = middle + 1
    end
  end

  return found
end

return binary_search
