package.path = './data_structure/?/?.lua;' .. package.path

local BinaryMinHeap = require 'binary_heap'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('should add element and update size', function()
  local heap = BinaryMinHeap:new()

  assert_equal(heap:add(2), true)
  assert_equal(heap:add(1), true)
  assert_equal(heap:add(3), true)
  assert_equal(heap:size(), 3)
end)

test('should return the minimum value', function()
  local heap = BinaryMinHeap:new()
  heap:add(2)
  heap:add(1)
  heap:add(3)
  
  assert_equal(heap:get_minimum(), 1)
end)

test('should remove the minimum value from the tree', function()
  local heap = BinaryMinHeap:new()
  heap:add(2)
  heap:add(1)
  heap:add(3)

  assert_equal(heap:remove_min(), true)
  assert_equal(heap:size(), 2)
  assert_equal(heap:get_minimum(), 2)
end)
