local SinglyLinkedList = {}

function SinglyLinkedList:new()
  local obj = {}
  self.__index = self
  self._size = 0
  self._head = nil
  self._tail = nil

  return setmetatable(obj, self)
end

function SinglyLinkedList:_create_node(data)
  return {
    data = data,
    node_next = nil
  }
end

function SinglyLinkedList:add_last(data)
  local node = self:_create_node(data)

  if self._head == nil then
    self._head = node
  else
    self._tail.node_next = node
  end

  self._tail = node
  self._size = self._size + 1
end

function SinglyLinkedList:add_first(data)
  local node = self:_create_node(data)

  if self._head == nil then
    self._head = node
    self._tail = node
  else
    node.node_next = self._head
    self._head = node
  end

  self._size = self._size + 1
end

-- Retrieves a data by a position in the list 
function SinglyLinkedList:item(index)
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

function SinglyLinkedList:remove_first()
  return self:remove(0)
end

function SinglyLinkedList:remove_last()
  return self:remove(self._size - 1)
end

-- Remove a item by a position in the list
function SinglyLinkedList:remove(index)
  if index > -1 and index < self._size then
    local current = self._head
    local previous = nil
    local i = 0
    
    if index == 0 then
      self._head = current.node_next

      if self._head == nil then
        self.tail = nil
      end

    elseif index == self._size - 1 then
      previous = self._head
      
      while previous.node_next ~= self._tail do
        previous = previous.node_next
      end

      self._tail = previous
      self._tail.node_next = nil

    else
      while i < index do
        previous = current
        current = current.node_next
        i = i + 1
      end

      previous.node_next = current.node_next
    end

    self._size = self._size - 1

    return current.data
  else
    return nil
  end
end

function SinglyLinkedList:remove_by_data(data)
  if self._head == nil then return end

  if self._head.data == data then
    self._size = self._size - 1
    self._head = self._head.node_next
    return
  end

  local current = self._head
  local previous = nil

  while current.node_next ~= nil do
    if current.node_next.data == data then
      self._size = self._size - 1
      current.node_next = current.node_next.node_next
      return
    end

    current = current.node_next
  end
end

function SinglyLinkedList:size()
  return self._size
end

return SinglyLinkedList
