local Stack = {}

function Stack:new()
  local obj = {}
  self.__index = self
  self._head = nil
  self._tail = nil
  self._size = 0

  return setmetatable(obj, self)
end

function Stack:peek()
  return self._head.item
end

function Stack:_create_node(item)
  return {
    item = item,
    node_next = nil,
    node_prev = nil
  }
end

function Stack:push(item)
  local node = self:_create_node(item)

  if self:is_empty() then
    self._head = node
  else
    local old_tail = self._tail
    old_tail.node_next = node
    node.node_prev = old_tail
  end

  self._tail = node
  self._size = self._size + 1

  return self._size
end

function Stack:pop()
  if self:is_empty() then
    return nil
  end

  local item = self._tail.item
  local new_tail = self._tail.node_prev
  new_tail.node_next = nil
  self._tail = new_tail
  self._size = self._size - 1

  return item
end

function Stack:is_empty()
  return self._size == 0
end

function Stack:size()
  return self._size
end

return Stack
