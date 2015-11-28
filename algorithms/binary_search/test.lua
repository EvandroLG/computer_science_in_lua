package.path = './algorithms/?/?.lua;' .. package.path

local binary_search = require 'binary_search'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('should return true', function()
  local output = binary_search({ 10, 20, 30, 40 }, 20)
  assert_equal(output, true)
end)

test('should return false', function()
  local output = binary_search({ 10, 20, 30, 40 }, 50)
  assert_equal(output, false)
end)
