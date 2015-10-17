package.path = './data_structure/?/?.lua;' .. package.path

local LinkedList = require 'doubly_linked_list'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('add the data in the end of the list', function()
  local list = LinkedList:new()
  list:add('JavaScript')
  list:add('Lua')

  assert_equal(list:item(0), 'JavaScript')
  assert_equal(list:item(1), 'Lua')
  assert_equal(list:size(), 2)
end)

test('should retrieve the first data in the list', function()
  local list = LinkedList:new()
  list:add('Python')
  assert_equal(list:item(0), 'Python')
end)

test('remove the item given a position in the list', function()
  local list = LinkedList:new()
  list:add('C')
  list:add('C++')
  list:add('Java')
  list:remove(1)

  assert_equal(list:item(0), 'C')
  assert_equal(list:item(1), 'Java')
  assert_equal(list:size(), 2)
end)

test('remove the last item', function()
  local list = LinkedList:new()
  list:add('Python')
  list:add('Lua')
  list:add('Ruby')
  list:remove(2)

  assert_equal(list:item(0), 'Python')
  assert_equal(list:item(1), 'Lua')
  assert_equal(list:item(2), nil)
end)
