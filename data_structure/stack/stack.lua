local Stack = {}

function Stack:new()
  local obj = {}
  self.__index = self
  self._head = nil
  self._size = 0

  return setmetatable(obj, self)
end

function Stack:_create_node(item)
  return {
    item = item,
    node_next = nil
  }
end

function Stack:push(item)
  local old_head = self._head
  self._head = self:_create_node(item)
  self._head.item = item
  self._head.node_next = old_head
  self._size = self._size + 1
end

function Stack:pop()
  local item = self._head.item
  self._head = self._head.node_next
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
