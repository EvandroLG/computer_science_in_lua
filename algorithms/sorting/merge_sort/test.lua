package.path = './algorithms/sorting/?/?.lua;' .. package.path

local merge_sort = require 'merge_sort'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('order from lowest to highest', function()
  local elements = { 20, 10, 15, 9, 8 }
  merge_sort(elements)

  assert_equal(elements[1], 8)
  assert_equal(elements[2], 9)
  assert_equal(elements[3], 10)
  assert_equal(elements[4], 15)
  assert_equal(elements[5], 20)
end)
