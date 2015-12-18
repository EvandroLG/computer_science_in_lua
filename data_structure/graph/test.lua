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
