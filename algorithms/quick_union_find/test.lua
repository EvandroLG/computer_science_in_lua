package.path = './algorithms/?/?.lua;' .. package.path

local UnionFind = require 'quick_union_find'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('create connection between 1 and 2', function()
  local union_find = UnionFind:new(10)
  union_find:union(1, 2)

  assert_equal(union_find:is_connected(1, 2), true)
end)

