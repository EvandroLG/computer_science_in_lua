local UnionFind = {}

function UnionFind:new(N)
  local obj = {} 
  self.__index = self
  self._id = {} 

  -- set id of each object to itself
  for i=1, N do
    self._id[i] = i
  end

  return setmetatable(obj, self)
end

-- chase parent pointers until reach root
function UnionFind:_root(i)
  while i ~= self._id[i] do
    i = self._id[i]
  end

  return i
end

-- check whether p and q are in the same component
function UnionFind:is_connected(p, q)
  return self._id[p] == self._id[q]
end

-- change all entries whith id[p] to id[q]
function UnionFind:union(p, q)
  local i = self:_root(p)
  local j = self:_root(q)

  self._id[i] = j
end

return UnionFind
