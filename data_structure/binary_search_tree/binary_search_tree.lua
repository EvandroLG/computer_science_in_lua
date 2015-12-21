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

function BinarySearchTree:is_root(value)
  return self._root.value == value
end

function BinarySearchTree:is_leaf(value)
  local found = false
  local current = self._root

  while found == false and current ~= nil do
    -- if value is smaller than current, then to go the left
    if value < current.value then
      current = current.left
    -- if value is bigger than current, then to go the right
    elseif value > current.value then
      current = current.right
    -- else we found it! :D
    else
      found = true
    end
  end

  -- if node doesn't have children, it's a leaf
  return found and current.left == nil and current.right == nil
end

function BinarySearchTree:_create_node(value)
  return {
    value = value,
    left = nil,
    right = nil
  }
end

function BinarySearchTree:add(value)
  local node = self:_create_node(value)

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

  -- search and picks up the node to remove
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

  -- figure out how many children the node has
  local child_count = ternary(current.left ~= nil, 1, 0) + ternary(current.right ~= nil, 1, 0)

  -- when the node is the root
  if current == self._root then
    -- if node doesn't have children, just remove it
    if child_count == 0 then
      self._root = nil
      return true
    end

    -- when it has one child, move child to the root
    if child_count == 1 then
      self._root = ternary(current.right == nil, current.left, current.right)
      return true
    end

    if child_count == 2 then
      local replacement = self._root.left
      local replacement_parent = nil

      -- figure out the right-most leaf node to be the new root
      while replacement.right ~= nil do
        replacement_parent = replacement 
        replacement = replacement.right
      end

      -- it's not the first node on the left
      if replacement_parent ~= nil then
        replacement_parent.right = replacement.left
        replacement.right = self._root.right
        replacement.left = self._root.left
      else
        -- assign the childre
        replacement.right = self._root.right
      end

      -- assign the new root
      self._root = replacement
      return true
    end

  -- when value is not in the root
  else
    if child_count == 0 then
      -- if the value is less than its parent's, null out to the left pointer
      if current.value < parent.value then
        parent.left = nil
      -- if not, null out to the right pointer
      else
        parent.right = nil
      end

      return true
    end

    if child_count == 1 then
      -- if the value is less than its parent's, reset the pointer of the left
      if current.value < parent.value then
        parent.left = ternary(current.left == nil, current.right, current.left)
      -- if the value is greater than its parent's, reset the pointer of the right
      else
        parent.right = ternary(current.left == nil, current.right, current.left)
      end

      return true
    end

    if child_count == 2 then
      replacement = current.left
      replacement_parent = current

      -- pick up the right-most node
      while replacement.right ~= nil do
        replacement_parent = replacement
        replacement = replacement.right
      end

      -- assign children to the replacement
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

function BinarySearchTree:_max_depth(node)
  if node == nil then return 0 end
  return 1 + math.max(self:_max_depth(node.left), self:_max_depth(node.right))
end

function BinarySearchTree:_min_depth(node)
  if node == nil then return 0 end
  return 1 + math.min(self:_min_depth(node.left), self:_min_depth(node.right))
end

function BinarySearchTree:is_balanced()
  return (self:_max_depth(self._root) - self:_min_depth(self._root) <= 1)
end

function BinarySearchTree:in_order(callback)
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

function BinarySearchTree:pre_order(callback)
  -- first of all, root
  -- after traverse to left and
  -- then to the right
  function _pre_order(node)
    if node == nil then return end

    callback(node)
    _pre_order(node.left)
    _pre_order(node.right)
  end

  _pre_order(self._root)
end

function BinarySearchTree:post_order(callback)
  -- first, traverse to left
  -- then to right
  -- then to root
  function _post_order(node)
    if node == nil then return end

    _post_order(node.left)
    _post_order(node.right)
    callback(node)
  end


  _post_order(self._root)
end

function BinarySearchTree:traverse(callback)
  self:in_order(callback)
end

return BinarySearchTree
