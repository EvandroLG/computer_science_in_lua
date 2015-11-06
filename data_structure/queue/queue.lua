local Queue = {}

function Queue:new()
  local obj = {}
  self.__index = self
  self._head = nil
  self._tail = nil
  self._size = 0

  return setmetatable(obj, self)
end

function Queue:_create_node(item)
  return {
    item = item,
    node_next = nil
  }
end

function Queue:enqueue(item)
  local node = self:_create_node(item)

  if self._head == nil then
    self._head = node
  else
    self._tail.node_next = node
  end

  self._tail = node
  self._size = self._size + 1
end

function Queue:dequeue()
  if self:is_empty() then
    return nil
  end

  self._size = self._size - 1
  local item = self._head.item
  self._head = self._head.node_next 

  if self:is_empty() then
    self._tail = nil
  end

  return item
end

function Queue:is_empty()
  return self._size == 0
end

function Queue:size()
  return self._size
end

return Queue
