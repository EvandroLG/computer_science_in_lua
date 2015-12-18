package.path = './data_structure/?/?.lua;' .. package.path

local Graph = require 'graph'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('return all graph vertices', function()
  local g = {
    ['a'] = {'b', 'c'},
    ['b'] = {'a'},
    ['c'] = {'a'}
  }

  local graph = Graph:new(g)
  local vertices = graph:get_vertices()

  assert_equal(#vertices, 3)

  for k, v in pairs(vertices) do
    assert_equal(v == 'a' or v == 'b' or v == 'c', true)
  end
end)

test('return all graph edges', function()
  local g = {
    ['a'] = {'b'},
    ['b'] = {'a'}
  }

  local graph = Graph:new(g)
  local edges = graph:get_edges()

  assert_equal(#edges, 2)

  for k, edge in pairs(edges) do
    assert_equal(edge[1] == 'a' or edge[1] == 'b', true)
    assert_equal(edge[2] == 'a' or edge[2] == 'b', true)
  end
end)

test('add vertex', function()
  local g = {
    ['a'] = {'b'},
    ['b'] = {'a'}
  }

  local graph = Graph:new(g)

  assert_equal(graph:add_vertex('c'), true)
  assert_equal(#graph:get_vertices(), 3)
end)

test('should not add vertex', function()
  local g = {
    ['a'] = {'b'},
    ['b'] = {'a'}
  }

  local graph = Graph:new(g)

  assert_equal(graph:add_vertex('b'), false)
  assert_equal(#graph:get_vertices(), 2)
end)

test('should not add edge', function()
  local graph = Graph:new({})

  assert_equal(graph:add_edge('a'), false)
  assert_equal(#graph:get_vertices(), 0)
end)

test('add edge in a new vertex', function()
  local graph = Graph:new({})

  assert_equal(graph:add_edge({'a', 'b'}), true)
  assert_equal(#graph:get_vertices(), 1)

  local edge = graph:get_edges()
  assert_equal(edge[1][1], 'a')
  assert_equal(edge[1][2], 'b')
end)

test('add edge in a old vertex', function()
  local graph = Graph:new({
    ['a'] = {'b'}
  })

  assert_equal(graph:add_edge({'a', 'c'}), true)
  assert_equal(#graph:get_vertices(), 1)
end)

test('remove edge', function()
  local graph = Graph:new({
    ['a'] = {'b'}
  })

  assert_equal(graph:remove_edge({'a', 'b'}), true)
  assert_equal(#graph:get_edges(), 0)
end)

test('should not any remove edge', function()
  local graph = Graph:new({
    ['a'] = {'b'}
  })

  assert_equal(graph:remove_edge({'a', 'c'}), false)
  assert_equal(#graph:get_edges(), 1)
end)

test('remove vertex', function()
  local graph = Graph:new({
    ['a'] = {'b'},
    ['b'] = {'a'}
  })

  assert_equal(graph:remove_vertex('a'), true)
  local vertices = graph:get_vertices()
  assert_equal(#vertices, 1)
  assert_equal(vertices[1], 'b')
  assert_equal(#graph:get_edges(), 0)
end)

test('find complete path between two vertices', function()
  local graph = Graph:new({
    ['a'] = {'b'},
    ['b'] = {'c'}
  })

  local path = graph:find_path('a', 'c')

  assert_equal(#path, 3)
  assert_equal(path[1], 'a')
  assert_equal(path[2], 'b')
  assert_equal(path[3], 'c')
end)

test('return nil when path between two vertices does not exist', function()
  local graph = Graph:new({
    ['a'] = {'b'},
    ['b'] = {'c'}
  })

  assert_equal(graph:find_path('a', 'd'), nil)
end)

test('return all paths between two vertices', function()
  local graph = Graph:new({
    ['a'] = {'b', 'c'},
    ['b'] = {'d'},
    ['c'] = {'d'}
  })

  --local paths = graph:find_all_paths('a', 'd')
end)
