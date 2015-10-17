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
    self._tail = node
  else
    self._tail.next = node
    node.node_prev = self._tail
    self._tail = node
  end

  self._size = self._size + 1
end

function DoublyLinkedList:item(index)
  if index > -1 and index < self._size then
    local current = self._head
    local i = 0

    while i < index do
      current = current.node_next
      i = i + i
    end

    return current.data
  else
    return nil
  end
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
      current.node_next = nil
      current._tail = current.node_prev
    else
      while i < index do
        current = current.node_next
        i = i + 1
      end

      current.node_prev.node_next = current.node_next
      current.node_next.node_prev = current.node_prev
    end

    self.size = self.size - 1

    return current.data
  else
    return nil
  end
end

return DoublyLinkedList
