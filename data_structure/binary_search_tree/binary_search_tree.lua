local BinarySearchTree = {}

function BinarySearchTree:new()
  local obj = {}
  self.__index = self
  self._root = nil

  return setmetatable(obj, self)
end

function BinarySearchTree:create_node(value)
  return {
    value = value,
    left = nil,
    right = nil
  }
end

function BinarySearchTree:add(value)
  local node = self:create_node(value)

  if self._root == nil then
    self._root = node
    return true
  end

  local current = self._root

  while true do
    if value < current.value then
      if current.left == nil then
        current.left = node
        return true

      else
        current = current.left
      end
    elseif value > current.value then
      if current.right == nil then
        current.right = node
        return true

      else
        current = current.right
      end
    else
      return false
    end
  end
end

function BinarySearchTree:contains(value)
  local found = false
  local current = self._root

  while not found and current do
    if value < current.value then
      current = current.left
    elseif value > current.value then
      current = current.right
    else
      found = true
    end
  end

  return found
end

return BinarySearchTree
