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

  --  if it's the first node, it's the root
  if self._root == nil then
    self._root = node
    return true
  end

  local current = self._root

  while true do
    -- if the value is smaller than the current,
    -- this value should go to left of the tree
    if value < current.value then
      -- if there's no left node, then the new node should be create there
      if current.left == nil then
        current.left = node
        return true
      -- if not, the program continues though the left node
      else
        current = current.left
      end

    -- if the value is bigger than the current,
    -- this value should go to right of the tree
    elseif value > current.value then
      -- if there's no right node, then the new node should be create there
      if current.right == nil then
        current.right = node
        return true

      -- if not, the program continues though the right node
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

  -- when value is less than the current node, go left
  -- when value is greater than the current node, go right
  -- when the values are equal, we found it!
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

function BinarySearchTree:destroy()
  self:traverse(function(node)
    self:remove(node.value)
  end)

  return true
end

function BinarySearchTree:get_smallest()
  function _find(node)
    local current = node

    -- make a loop while there's left node
    while current.left ~= nil do
      current = current.left
    end

    -- return the last node of left
    return current.value
  end

  return _find(self._root, 0)
end

function BinarySearchTree:get_biggest()
  function _find(node)
    local current = node

    -- make a loop while there's right node
    while current.right ~= nil do
      current = current.right
    end

    -- return the last node of right
    return current.value
  end

  return _find(self._root, 0)
end

function BinarySearchTree:traverse(callback)
  -- first, traverse to the left, then to root and
  -- then to the right
  function _in_order(node)
    if node == nil then return end

    _in_order(node.left)
    callback(node)
    _in_order(node.right)
  end

  _in_order(self._root)
end

return BinarySearchTree
