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

test('create the following connections: (3, 8), (6, 5), (8, 9), (2, 1)', function()
  local union_find = UnionFind:new(10)
  union_find:union(4, 3)
  union_find:union(3, 8)
  union_find:union(6, 5)
  union_find:union(9, 4)
  union_find:union(2, 1)

  assert_equal(union_find:is_connected(3, 8), true)
  assert_equal(union_find:is_connected(6, 5), true)
  assert_equal(union_find:is_connected(8, 9), true)
  assert_equal(union_find:is_connected(2, 1), true)
end)
