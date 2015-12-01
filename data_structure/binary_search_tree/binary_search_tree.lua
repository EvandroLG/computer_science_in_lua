local BSTNode = {}

function BSTNode:new(value)
  local obj = {}
  self.__index = self
  self._value = value
  self._left = nil
  self._right = nil
end

function BSTNode:add(value)
  if value == self._value then
    return false
  end

  if value < self._value then
    if self._left == nil then
      self._left = BSTNode:new(value)
      return true
    end

    return self._left:add(value)
  end

  if value > self._value then
    if self._right == nil then
      self._right = BSTNode:new(value)
      return true
    end

    return self._right:add(value)
  end
end

local BinarySearchTree = {}

function BinarySearchTree:new()
  local obj = {}
  self.__index = self
  self._root = nil

  return setmetatable(obj, self)
end

function BinarySearchTree:add(value)
  if self._root == nil then
    self._root = BSTNode:new(value) 
    return true
  end
  
  return self._root:add(value)
end

return BinarySearchTree
