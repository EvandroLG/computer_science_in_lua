package.path = './data_structure/?/?.lua;' .. package.path

local Stack = require 'stack'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('is_empty should return true', function()
  local stack = Stack:new()
  assert_equal(stack:is_empty(), true)
end)

test('is_empty should return false when it has at least one item', function()
  local stack = Stack:new()
  stack:push('Lua')
  assert_equal(stack:is_empty(), false)
end)

test('should return correct size', function()
  local stack = Stack:new()
  stack:push('JavaScript')
  stack:push('Python')
  stack:push('Lua')

  assert_equal(stack:size(), 3)
end)

test('should return and remove the first item', function()
  local stack = Stack:new()
  stack:push('JavaScript')
  stack:push('Python')
  stack:push('Lua')

  assert_equal(stack:pop(), 'Lua')
  assert_equal(stack:size(), 2)
end)

test('should return nil', function()
  local stack = Stack:new()
  assert_equal(stack:pop(), nil)
end)

test('should return the first item added', function()
  local stack = Stack:new()
  stack:push('JavaScript')
  stack:push('Python')
  stack:push('Lua')
  assert_equal(stack:peek(), 'JavaScript')
end)
