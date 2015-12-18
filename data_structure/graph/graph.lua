function is_in_table(object, item)
  for key, value in ipairs(object) do
    if value == item then return true end
  end

  return false
end

local Graph = {}

function Graph:new(graph)
  local obj = {}
  self.__index = self
  self._graph = graph

  return setmetatable(obj, self)
end

function Graph:get_vertices()
  local vertices = {}

  for k in pairs(self._graph) do 
    table.insert(vertices, k)
  end

  return vertices 
end

function Graph:get_edges()
  local edges = {}

  for vertex in pairs(self._graph) do
    for k, neighbour in pairs(self._graph[vertex]) do 
      table.insert(edges, { vertex, neighbour })
    end
  end

  return edges
end

function Graph:add_vertex(vertex)
  if self._graph[vertex] == nil then
    self._graph[vertex] = {}
    return true
  end

  return false
end

function Graph:add_edge(edge)
  if type(edge) ~= 'table' then return false end

  if self._graph[edge[1]] == nil then
    self._graph[edge[1]] = {edge[2]}
  else
    table.insert(self._graph[edge[1]], edge[2])
  end

  return true
end

function Graph:find_path(start_vertex, end_vertex, path)
  path = path or {}
  table.insert(path, start_vertex)

  if start_vertex == end_vertex then
    return path
  end

  if self._graph[start_vertex] == nil then
    return nil
  end

  local extended_path = nil

  for k, vertex in pairs(self._graph[start_vertex]) do
    if is_in_table(path, vertex) then break end
    extended_path = self:find_path(vertex, end_vertex, path)
    if extended_path ~= nil then return extended_path end
  end

  return nil
end

return Graph
