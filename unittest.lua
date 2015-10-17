local format = string.format

function test(name, func)
  xpcall(function()
    func()
    print(format('[pass] %s', name))
  end, function(err)
    print(format('[fail] %s : %s', name, err))  
  end)
end

function _equal(a, b)
  return a == b
end

function assert_equal(a, b)
  assert(_equal(a, b))
end

return {
  test = test,
  assert_equal = assert_equal
}
