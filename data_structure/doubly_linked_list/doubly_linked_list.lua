local DoublyLinkedList = {}

function DoublyLinkedList:new()
  local obj = {}
  self.__index = self
  self._head = nil
  self._tail = nil
  self._size = 0

  return setmetatable(obj, self)
end

function DoublyLinkedList:_create_node(data)
  return {
    data = data,
    node_next = nil,
    node_prev = nil
  }
end

function DoublyLinkedList:add_last(data)
  local node = self:_create_node(data)

  if self._head == nil then
    self._head = node
  else
    self._tail.node_next = node
    node.node_prev = self._tail
  end

  self._tail = node
  self._size = self._size + 1
end

function DoublyLinkedList:add_first(data)
  local node = self:_create_node(data)

  if self._head == nil then
    self._tail = node
  else
    node.node_next = self._head
    self._head.node_prev = node
  end

  self._head = node
  self._size = self._size + 1
end

-- Retrieves a data by a position in the list
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

-- Remove a item by a position in the list
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


function DoublyLinkedList:remove_by_data(data)
  if self._head == nil then
    return
  end

  if self._head.data == data then
    self._head = self._head.node_next
    self._size = self._size - 1

    return
  end

  local current = self._head

  while current.node_next do
    if current.node_next.data == data then
      local prev = current.node_next.node_prev

      if current.node_next.node_next == nil then
        prev.node_next = nil
      else
        current.node_next = current.node_next.node_next
        current.node_next.node_prev = prev
        prev.node_next = current.node_next
      end

      self._size = self._size - 1

      return
    end

    current = current.node_next
  end
end

function DoublyLinkedList:size()
  return self._size
end

return DoublyLinkedList
