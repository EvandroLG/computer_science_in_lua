package.path = './data_structure/?/?.lua;' .. package.path

local BinarySearchTree = require 'binary_search_tree'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('should return true', function()
  local bst = BinarySearchTree:new()
  assert_equal(bst:add(1), true)
end)
