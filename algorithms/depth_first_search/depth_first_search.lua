function _is_in_table(array, value)
  for k, v in pairs(array) do
    if v == value then return true end
  end

  return false
end

function _diff(first_table, second_table)
  local output = {}

  for k, v in pairs(first_table) do
    if not _is_in_table(second_table, v) then
      table.insert(output, v)
    end
  end

  return output
end

function depth_first_search(graph, start)
  local visited = {}
  local stack = {start}
  local vertex = nil

  while #stack > 0 do
    vertex = table.remove(stack)

    if not _is_in_table(visited, vertex) then
      table.insert(visited, vertex)
      -- then add in the stack every node that's connect to
      -- the current vertex, less the already visited nodes
      stack = _diff(graph[vertex], visited)
    end
  end

  return visited
end

return depth_first_search
