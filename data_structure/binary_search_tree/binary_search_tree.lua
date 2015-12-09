local ternary = function(condition, positive, negative)
  if condition then
    return positive
  end

  return negative
end

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

function BinarySearchTree:remove(value)
  local found = false
  local current = self._root
  local parent = nil

  while not found and current do
    if value < current.value then
      parent = current
      current = current.left
    elseif value > current.value then
      parent = current
      current = current.right
    else
      found = true
    end
  end

  if not found then
    return false
  end

  local child_count = ternary(current.left ~= nil, 1, 0) + ternary(current.right ~= nil, 1, 0)

  if current == self._root then
    if child_count == 0 then
      self._root = nil
      return true
    end

    if child_count == 1 then
      self._root = ternary(current.right == nil, current.left, current.right)
      return true
    end

    if child_count == 2 then
      local replacement = self._root.left
      local replacement_parent = nil

      while replacement.right ~= nil do
        replacement_parent = replacement 
        replacement = replacement.right
      end

      if replacement_parent ~= nil then
        replacement_parent.right = replacement.left
        replacement.right = self._root.right
        replacement.left = self._root.left
      else
        replacement.right = self._root.right
      end

      self._root = replacement
      return true
    end
  else
    if child_count == 0 then
      if current.value < parent.value then
        parent.left = nil
      else
        parent.right = nil
      end

      return true
    end

    if child_count == 1 then
      if current.value < parent.value then
        parent.left = ternary(current.left == nil, current.right, current.left)
      else
        parent.right = ternary(current.left == nil, current.right, current.left)
      end

      return true
    end

    if child_count == 2 then
      replacement = current.left
      replacement_parent = current

      while replacement.right ~= nil do
        replacement_parent = replacement
        replacement = replacement.right
      end

      replacement_parent.right = replacement.left
      replacement.right = current.right
      replacement.left = current.left

      if current.value < parent.value then
        parent.left = replacement
      else
        parent.right = replacement
      end
    end

    return true
  end
end

function BinarySearchTree:size()
  local size = 0

  self:traverse(function()
    size = size + 1
  end)

  return size
end

function BinarySearchTree:traverse(callback)
  function in_order(node)
    if node then
      if node.left ~= nil then
        in_order(node.left)
      end

      callback(node)

      if node.right ~= nil then
        in_order(node.right)
      end
    end
  end

  in_order(self._root)
end

return BinarySearchTree
