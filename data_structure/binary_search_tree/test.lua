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

test('should remove all nodes', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(15)

  assert_equal(bst:destroy(), true)
  assert_equal(bst:size(), 0)
end)


test('should return smallest value in the tree', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(8)
  bst:add(15)
  bst:add(25)
  bst:add(1)

  assert_equal(bst:get_smallest(), 1)
end)

test('should return biggest value in the tree', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(8)
  bst:add(15)
  bst:add(25)
  bst:add(1)

  assert_equal(bst:get_biggest(), 25)
end)

function _add_datas()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(12)
  bst:add(4)

  return bst
end

test('in_order', function()
  local bst = _add_datas()

  local output = {}

  bst:in_order(function(node)
    table.insert(output, node.value)
  end)

  assert_equal(output[1], 4)
  assert_equal(output[2], 5)
  assert_equal(output[3], 10)
  assert_equal(output[4], 12)
end)

test('pre_order', function()
  local bst = _add_datas()

  local output = {}

  bst:pre_order(function(node)
    table.insert(output, node.value)
  end)

  assert_equal(output[1], 10)
  assert_equal(output[2], 5)
  assert_equal(output[3], 4)
  assert_equal(output[4], 12)
end)

test('post_order', function()
  local bst = _add_datas()

  local output = {}

  bst:post_order(function(node)
    table.insert(output, node.value)
  end)

  assert_equal(output[1], 4)
  assert_equal(output[2], 5)
  assert_equal(output[3], 12)
  assert_equal(output[4], 10)
end)

test('is_root should return false', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)

  assert_equal(bst:is_root(5), false)
end)

test('is_root should return false', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)

  assert_equal(bst:is_root(10), true)
end)

test('is_leaf should return false', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(4)

  assert_equal(bst:is_leaf(5), false)
end)

test('is_leaf should return false when it does not find the value', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(4)

  assert_equal(bst:is_leaf(7), false)
end)

test('is_leaf should return true', function()
  local bst = BinarySearchTree:new()
  bst:add(10)
  bst:add(5)
  bst:add(4)

  assert_equal(bst:is_leaf(4), true)
end)

test('is balanced should return true', function()
  local bst = BinarySearchTree:new()
  bst:add(5)
  bst:add(4)
  bst:add(6)

  assert_equal(bst:is_balanced(), true)
end)

test('is balanced should return false', function()
  local bst = BinarySearchTree:new()
  bst:add(5)
  bst:add(4)
  bst:add(3)
  bst:add(2)
  bst:add(6)

  assert_equal(bst:is_balanced(), false)
end)
