function is_in_table(object, item)
  for key, value in ipairs(object) do
    if value == item then return true end
  end

  return false
end

function shallow_copy(orig)
    local orig_type = type(orig)
    local copy

    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else
        copy = orig
    end

    return copy
end

local Graph = {}

function Graph:new(graph)
  local obj = {}
  self.__index = self
  self._graph = graph or {}

  return setmetatable(obj, self)
end

function Graph:get_vertices()
  local vertices = {}

  -- pick up every vertice and return in a new table
  for k in pairs(self._graph) do 
    table.insert(vertices, k)
  end

  return vertices 
end

function Graph:get_edges()
  local edges = {}

  -- visit every vertice and its edges
  -- then storage every edges in a new table
  for vertex in pairs(self._graph) do
    for k, neighbour in pairs(self._graph[vertex]) do 
      table.insert(edges, { vertex, neighbour })
    end
  end

  return edges
end

function Graph:add_vertex(vertex)
  -- if vertex doesn't exist, create as a index in the graph table
  -- and return true
  if self._graph[vertex] == nil then
    self._graph[vertex] = {}
    return true
  end

  -- if not, just return false
  return false
end

function Graph:add_edge(first, second)
  -- check if types are valids
  if type(first) ~= 'string' or type(second) ~= 'string' then
    return false
  end

  -- if there's no index to first item, add it
  -- and pass the conection into a table
  if self._graph[first] == nil then
    self._graph[first] = {second}
  -- if there's, we simply add the second item in the table that already exists
  else
    table.insert(self._graph[first], second)
  end

  return true
end

function Graph:remove_edge(first, second)
  -- if first is a vertex in the graph
  if self._graph[first] ~= nil then
    -- then, pick up the second value and update it to nil
    for key, value in pairs(self._graph[first]) do
      if value == second then
        self._graph[first][key] = nil
        return true
      end
    end
  end

  -- if first isn't a vertex in the graph, just return false
  return false
end

function Graph:remove_vertex(vertex)
  -- if there's no vertex, just return false
  if self._graph[vertex] == nil then return false end

  -- if there's vertex, we set it as nil
  self._graph[vertex] = nil

  -- then, remove every connection with other vertices
  for k, obj in pairs(self._graph) do
    for key in pairs(obj) do
      if obj[key] == vertex then
        table.remove(obj, key)
        break
      end
    end
  end

  return true
end

function Graph:destroy()
end

function Graph:find_path(start_vertex, end_vertex, _path)
  -- if the _path is nil, then set a table
  -- then, add start_vertex in the path table
  local path = _path or {}
  table.insert(path, start_vertex)

  -- if start_vertex and end_vertex are the same, then we completed a path :D
  if start_vertex == end_vertex then
    return path
  end

  if self._graph[start_vertex] == nil then
    return nil
  end

  local extended_path = nil

  -- visit every vertex that's connected to the start_vertex
  for k, vertex in pairs(self._graph[start_vertex]) do
    -- case it's in the path, ignore
    if not is_in_table(path, vertex) then
      -- call the function recursively passing the new vertex in place of start_vertex
      extended_path = self:find_path(vertex, end_vertex, path)

      -- then, if it return a table, the program found a path! :D
      if extended_path ~= nil then return extended_path end
    end
  end

  return nil
end

function Graph:find_shortest_path(start_vertex, end_vertex, _path)
  -- if the _path is nil, then set a table
  -- then, add start_vertex in the path table
  local path = shallow_copy(_path) or {}
  table.insert(path, start_vertex)

  -- if start_vertex and end_vertex are the same, then we found a path
  if start_vertex == end_vertex then
    return path
  end
 
  if self._graph[start_vertex] == nil then
    return nil
  end

  local shortest = nil
  local new_path = nil

  -- visit every vertex that's connected to the start_vertex
  for k, vertex in pairs(self._graph[start_vertex]) do
    -- case it's in the path, ignore
    if not is_in_table(path, vertex) then
      -- call the function recursively passing the new vertex in place of start_vertex
      new_path = self:find_shortest_path(vertex, end_vertex, path)

      -- then, if the new_path has less elements than shortest, we updated the shortest is the new_path
      if (new_path ~= nil and shortest == nil) or (shortest ~= nil and #new_path < #shortest) then
        shortest = new_path
      end
    end
  end

  return shortest
end

function Graph:find_all_paths(start_vertex, end_vertex, _path)
  -- if path is nil, set a new table
  -- then add start_vertext in the path table
  local path = shallow_copy(_path) or {}
  table.insert(path, start_vertex)

  -- if the start_vertext and end_vertex are the same, we found a path
  if start_vertex == end_vertex then
    return {path}
  end

  if self._graph[start_vertex] == nil then
    return {}
  end

  local paths = {}
  local new_path = nil

  -- visit every vertces that's connected to the start_vertex
  for k, vertex in pairs(self._graph[start_vertex]) do
    -- if vertex is in the path table, then ignore it
    if not is_in_table(path, vertex) then
      -- call the function recursively passing the new vertex in the place of start_vertex
      new_path = self:find_all_paths(vertex, end_vertex, path)

      -- add the new path in paths table
      for _k, obj in pairs(new_path) do
        table.insert(paths, obj)
      end
    end
  end

  -- return all paths
  return paths
end

return Graph
