local BinaryMinHeap = {}

function BinaryMinHeap:new()
  local obj = {}
  self.__index = self
  self._data = {}
  self._size = 0

  return setmetatable(obj, self)
end

function BinaryMinHeap:get_minimum()
  if (self._size == 0) then return nil end
  return self._data[0]
end

function BinaryMinHeap:add(value)
  self._size = self._size + 1
  self._data[self._size] = value
  self:_sift_up(self._size)

  return true
end

function BinaryMinHeap:_sift_up(index)
  if index == 1 then return end

  local parent_index = math.ceil((index) / 2)
  if self._data[parent_index] < self._data[index] then return end

  local temp = self._data[parent_index]
  self._data[parent_index] = self._data[index]
  self._data[index] = temp

  self:_sift_up(parent_index)
end

function BinaryMinHeap:size()
  return self._size
end

return BinaryMinHeap
