local QuickUnionFind = {}

function QuickUnionFind:new(N)
  local obj = {} 
  self.__index = self
  self._id = {} 
  self._size = {}

  -- set id of each object to itself
  for i=1, N do
    self._id[i] = i
    self._size[i] = i
  end

  return setmetatable(obj, self)
end

-- chase parent pointers until reach root
function QuickUnionFind:_root(i)
  while i ~= self._id[i] do
    i = self._id[i]
  end

  return i
end

-- check whether p and q are in the same component
function QuickUnionFind:is_connected(p, q)
  return self._id[p] == self._id[q]
end

-- change all entries whith id[p] to id[q]
function QuickUnionFind:union(p, q)
  local i = self:_root(p)
  local j = self:_root(q)

  if i == j then return end

  -- make smaller root point to larger one
  if self._size[i] < self._size[j] then
    self._id[i] = j
    self._size[j] = self._size[i] + self._size[j]
  else
    self._id[j] = i
    self._size[i] = self._size[i] + self._size[j]
  end
end

return QuickUnionFind
