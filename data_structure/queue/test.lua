package.path = './data_structure/?/?.lua;' .. package.path

local Queue = require 'queue'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('is_empty should return true', function()
  local queue = Queue:new()
  assert_equal(queue:is_empty(), true)
end)

test('is_empty should return false when it has at least one item', function()
  local queue = Queue:new()
  queue:enqueue('Lua')
  assert_equal(queue:is_empty(), false)
end)

test('should return correct size', function()
  local queue = Queue:new()
  queue:enqueue('JavaScript')
  queue:enqueue('Python')
  queue:enqueue('Lua')

  assert_equal(queue:size(), 3)
end)

test('should return and remove the first item', function()
  local queue = Queue:new()
  queue:enqueue('JavaScript')
  queue:enqueue('Python')
  queue:enqueue('Lua')

  assert_equal(queue:dequeue(), 'JavaScript')
  assert_equal(queue:size(), 2)
end)

test('should return nil', function()
  local queue = Queue:new()
  assert_equal(queue:dequeue(), nil)
end)
