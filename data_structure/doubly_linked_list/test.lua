package.path = './data_structure/?/?.lua;' .. package.path

local DoublyLinkedList = require 'doubly_linked_list'
local unittest = require 'unittest'
local test = unittest.test
local assert_equal = unittest.assert_equal

test('add the data in the end of the list', function()
  local list = DoublyLinkedList:new()
  list:add_last('JavaScript')
  list:add_last('Lua')

  assert_equal(list:item(0), 'JavaScript')
  assert_equal(list:item(1), 'Lua')
  assert_equal(list:size(), 2)
end)

test('add the data in the begin of the list', function()
  local list = DoublyLinkedList:new()
  list:add_first('JavaScript')
  list:add_first('Lua')
  list:add_first('Python')

  assert_equal(list:item(0), 'Python')
  assert_equal(list:item(1), 'Lua')
  assert_equal(list:item(2), 'JavaScript')
  assert_equal(list:size(), 3)
end)

test('retrieve the first data in the list', function()
  local list = DoublyLinkedList:new()
  list:add_last('Python')
  assert_equal(list:item(0), 'Python')
end)

test('remove the item given a position in the list', function()
  local list = DoublyLinkedList:new()
  list:add_last('C')
  list:add_last('C++')
  list:add_last('Java')
  list:remove(1)

  assert_equal(list:item(0), 'C')
  assert_equal(list:item(1), 'Java')
  assert_equal(list:size(), 2)
end)

test('remove the last item', function()
  local list = DoublyLinkedList:new()
  list:add_last('Python')
  list:add_last('Lua')
  list:add_last('Ruby')
  list:remove(2)

  assert_equal(list:item(0), 'Python')
  assert_equal(list:item(1), 'Lua')
  assert_equal(list:item(2), nil)
end)

test('remove the last item', function()
  local list = DoublyLinkedList:new()
  list:add_last('Python')
  list:add_last('Lua')
  list:add_last('Ruby')
  list:remove_last()

  assert_equal(list:item(0), 'Python')
  assert_equal(list:item(1), 'Lua')
  assert_equal(list:item(2), nil)
end)

test('remove the first item', function()
  local list = DoublyLinkedList:new()
  list:add_last('Go')
  list:add_last('Rust')
  list:add_last('Ruby')
  list:remove_first()

  assert_equal(list:item(0), 'Rust')
  assert_equal(list:item(1), 'Ruby')
  assert_equal(list:item(2), nil)
  assert_equal(list:size(), 2)
end)

--test('remove by data', function()
  --local list = DoublyLinkedList:new()
  --list:add_last('Go')
  --list:add_last('Python')
  --list:add_last('Ruby')
  --list:remove_by_data('Python')

  --assert_equal(list:item(0), 'Go')
  --assert_equal(list:item(1), 'Ruby')
  --assert_equal(list:item(2), nil)
  --assert_equal(list:size(), 2)
--end)

--test('should remove the first node', function()
  --local list = DoublyLinkedList:new()
  --list:add_last('Go')
  --list:add_last('Python')
  --list:add_last('Ruby')
  --list:remove_by_data('Go')

  --assert_equal(list:item(0), 'Python')
  --assert_equal(list:item(1), 'Ruby')
  --assert_equal(list:item(2), nil)
  --assert_equal(list:size(), 2)
--end)

test('should remove the last node', function()
  local list = DoublyLinkedList:new()
  list:add_last('Go')
  list:add_last('Python')
  list:add_last('Ruby')
  list:remove_by_data('Ruby')

  assert_equal(list:item(0), 'Go')
  assert_equal(list:item(1), 'Python')
  assert_equal(list:item(2), nil)
  assert_equal(list:size(), 2)
end)
