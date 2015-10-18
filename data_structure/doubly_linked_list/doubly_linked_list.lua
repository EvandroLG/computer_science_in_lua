local DoublyLinkedList = {}

function DoublyLinkedList:new()
  local obj = {}
  self.__index = self
  self._head = nil
  self._tail = nil
  self._size = 0

  return setmetatable(obj, self)
end

function DoublyLinkedList:add(data)
  local node = {
    data = data,
    node_next = nil,
    node_prev = nil
  }

  if self._head == nil then
    self._head = node
  else
    self._tail.node_next = node
    node.node_prev = self._tail
  end

  self._tail = node
  self._size = self._size + 1
end

function DoublyLinkedList:item(index)
  if index > -1 and index < self._size then
    local current = self._head
    local i = 0

    while i < index do
      current = current.node_next
      i = i + 1
    end

    return current.data
  else
    return nil
  end
end

function DoublyLinkedList:remove_first()
  return self:remove(0)
end

function DoublyLinkedList:remove_last()
  return self:remove(self._size - 1)
end

function DoublyLinkedList:remove(index)
  if index > -1 and index < self._size then
    local current = self._head
    local i = 0

    if index == 0 then
      self._head = current.node_next

      if self._head == nil then
        self.tail = nil
      else
        self._head.node_prev = nil
      end

    elseif index == self._size - 1 then
      current = self._tail
      self._tail = current.node_prev
      current.node_next = nil

    else
      while i < index do
        current = current.node_next
        i = i + 1
      end

      current.node_prev.node_next = current.node_next
      current.node_next.node_prev = current.node_prev
    end

    self._size = self._size - 1

    return current.data
  else
    return nil
  end
end

function DoublyLinkedList:size()
  return self._size
end

return DoublyLinkedList
