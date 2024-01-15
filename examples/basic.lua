local test = require "luatest"

test("explicit pass", function(t)
  t:pass()
end)

test("explicit fail", function(t)
  t:fail()
end)

test("assert pass", function(t)
  t:assert(true)
end)

test("assert fail", function(t)
  t:assert(false)
end)

test("is equal pass", function(t)
  t:is(1, 1)
end)

test("is equal fail", function(t)
  t:is(1, 2)
end)

test("doesn't compile", function(t)
  local a
  print(a.b.c)
end)

test.run()