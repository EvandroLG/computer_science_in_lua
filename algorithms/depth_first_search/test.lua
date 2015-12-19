package.path = './algorithms/?/?.lua;' .. package.path

local dfs = require 'depth_first_search'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('return all the vertices of a given graph', function()
  local graph = {
    ['a'] = { 'b', 'c' },
    ['b'] = { 'a', 'd', 'e' },
    ['c'] = { 'a', 'f' },
    ['d'] = { 'b' },
    ['e'] = { 'b', 'f' },
    ['f'] = { 'c', 'e' }
  }

  local vertices = dfs(graph, 'a')

  assert_equal(#vertices, 6)
end)
