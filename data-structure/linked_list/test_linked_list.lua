local LinkedList = require 'linked_list'

local format = string.format

function test(name, func)
  xpcall(function()
    func()
    print(format('[pass] %s', name))
  end, function(err)
    print(format('[fail] %s : %s', name, err))  
  end)
end

function _equal(a, b)
  return a == b
end

function equal(a, b)
  assert(_equal(a, b))
end

test('add the data in the end of the list', function()
  local list = LinkedList:new()
  list:add('JavaScript')
  list:add('Lua')

  equal(list:item(0), 'JavaScript')
  equal(list:item(1), 'Lua')
  equal(list:size(), 2)
end)

test('remove the item given a position in the list', function()
  local list = LinkedList:new()
  list:add('C')
  list:add('C++')
  list:add('Java')
  list:remove(1)

  equal(list:item(0), 'C')
  equal(list:item(1), 'Java')
  equal(list:size(), 2)
end)
