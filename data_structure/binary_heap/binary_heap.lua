function ternary(condition, if_true, if_false)
  if condition then
    return if_true
  end

  return if_false
end

local BinaryMinHeap = {}

function BinaryMinHeap:new()
  local obj = {}
  self.__index = self
  self._data = {}
  self._size = 0

  return setmetatable(obj, self)
end

function BinaryMinHeap:get_minimum()
  if (self._size == 1) then return nil end
  return self._data[1]
end

function BinaryMinHeap:add(value)
  self._size = self._size + 1
  self._data[self._size] = value
  self:_sift_up(self._size)

  return true
end

function BinaryMinHeap:_sift_up(index)
  if index == 1 then return end

  -- pick up the parent index from the tree
  local parent_index = math.floor(index / 2)
  if self._data[parent_index] < self._data[index] then return end

  -- swap the elements
  self._data[parent_index], self._data[index] = self._data[index], self._data[parent_index]

  self:_sift_up(parent_index)
end

function BinaryMinHeap:remove_min()
  if self._size == 0 then return false end

  self._data[1] = self._data[self._size]
  self._data[self._size] = nil
  self._size = self._size - 1

  if self._size > 1 then
    self:_sift_down(1)
  end

  return true
end

function BinaryMinHeap:_sift_down(index)
  local left_child_index = ternary(index == 1, 2, index + 2)
  local right_child_index = ternary(index == 1, 3, index + 3)
  local min_index = nil

  -- check if indexes are valids
  if right_child_index > self._size then
    if left_child_index > self._size then return end
    min_index = left_child_index

  -- pick up the minimum between left child and right child
  elseif self._data[left_child_index] < self._data[right_child_index] then
    min_index = left_child_index
  else
    min_index = right_child_index
  end

  if self._data[index] < self._data[min_index] then return end

  -- swap the elements
  self._data[min_index], self._data[index] = self._data[index], self._data[min_index]

  self:_sift_down(min_index)
end

function BinaryMinHeap:size()
  return self._size
end

return BinaryMinHeap
