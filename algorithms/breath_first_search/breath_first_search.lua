function _is_in_table(array, value)
  for k, v in pairs(array) do
    if v == value then return true end
  end

  return false
end

-- it makes a new table with the differences between two tables
function _diff(first_table, second_table)
  local output = {}

  for k, v in pairs(first_table) do
    if not _is_in_table(second_table, v) then
      table.insert(output, v)
    end
  end

  return output
end

function breath_first_search(graph, start)
  local visited = {}
  local queue = { start }
  local vertex = nil

  while #queue > 0 do
    vertex = table.remove(queue, 1)

    if not _is_in_table(visited, vertex) then
      table.insert(visited, vertex)
      queue = _diff(queue, visited)
    end
  end

  return visited
end
