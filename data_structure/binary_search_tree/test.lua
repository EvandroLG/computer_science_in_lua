package.path = './data_structure/?/?.lua;' .. package.path

local BinarySearchTree = require 'binary_search_tree'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('should add as root and return true', function()
  local bst = BinarySearchTree:new()
  assert_equal(bst:add(1), true)
end)

test('should add on the left and return true', function()
  local bst = BinarySearchTree:new()
  assert_equal(bst:add(10), true)
  assert_equal(bst:add(5), true)
end)


test('should add on the right and return true', function()
  local bst = BinarySearchTree:new()
  assert_equal(bst:add(5), true)
  assert_equal(bst:add(10), true)
end)

test('should return true when the value is in the tree', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  assert_equal(bst:contains(10), true)
end)

test('should return false when the value is not in the tree', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  assert_equal(bst:contains(4), false)
end)

test('should remove root and return true', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  assert_equal(bst:remove(10), true)
  assert_equal(bst:contains(10), false)
end)

test('should remove left node and return true', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  assert_equal(bst:remove(5), true)
  assert_equal(bst:contains(5), false)
end)

test('should remove right node and return true', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(15)
  assert_equal(bst:remove(15), true)
  assert_equal(bst:contains(15), false)
end)

test('should return correct length', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(8)
  bst:add(15)
  bst:add(25)

  assert_equal(bst:size(), 5)
end)

test('should return length zero', function()
  local bst = BinarySearchTree:new()
  assert_equal(bst:size(), 0)
end)
