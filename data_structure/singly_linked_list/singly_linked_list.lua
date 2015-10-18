local LinkedList = {}

function LinkedList:new()
  local obj = {}
  self.__index = self
  self._size = 0
  self._head = nil
  self._tail = nil

  return setmetatable(obj, self)
end

-- Add a data to the end of the list
function LinkedList:add(data)
  local node = {
    data = data,
    node_next = nil
  }

  if self._head == nil then
    self._head = node
  else
    self._tail.node_next = node
  end

  self._tail = node
  self._size = self._size + 1
end

-- Retrieves a data by a position in the list 
function LinkedList:item(index)
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

function LinkedList:remove_first()
  return self:remove(0)
end

function LinkedList:remove_last()
  return self:remove(self._size - 1)
end

-- Remove a item by a position in the list
function LinkedList:remove(index)
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

-- Return the number of elements in the list
function LinkedList:size()
  return self._size
end

return LinkedList
