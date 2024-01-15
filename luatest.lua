-- TODO: add deep table comparison
-- t.throws(fn)
-- t.notThrows(fn)
-- t.match(a, pattern)
-- t.notMatch(a, pattern)

---@overload fun(name: string, fn: fun(ctx: TestContext))
local test = setmetatable({}, {
  __call = function(self, ...)
    self.add(...)
  end
})

local tests = {}

function test.add(name, fn)
  table.insert(tests, { name = name, fn = fn })
end

local function deep_equals(o1, o2)
  -- same object
  if o1 == o2 then return true end

  local o1Type = type(o1)
  local o2Type = type(o2)
  --- different type
  if o1Type ~= o2Type then return false end
  --- same type but not table, already compared above
  if o1Type ~= 'table' then return false end

  -- iterate over o1
  for key1, value1 in pairs(o1) do
    local value2 = o2[key1]
    if value2 == nil or deep_equals(value1, value2) == false then
        return false
    end
  end

  --- check keys in o2 but missing from o1
  for key2, _ in pairs(o2) do
    if o1[key2] == nil then return false end
  end
  return true
end


---@class TestContext
local testContext = {}

function testContext:new()
  self.__index = self
  local o = setmetatable({}, self)

  o.passed = nil
  o.message = ""

  return o
end

function testContext:pass(message)
  if self.passed == false then return end
  self.passed = true
  self.message = message or "Explicit pass"
end
function testContext:fail(message)
  self.passed = false
  self.message = message or "Explicit fail"
end
function testContext:assert(condition)
  if condition then
    self:pass("Assert passed")
  else
    self:fail("Assert failed")
  end
end
function testContext:is(a, b)
  if deep_equals(a, b) then
    self:pass("Values are equal")
  else
    self:fail("Values are not equal")
  end
end
function testContext:isnt(a, b)
  if not deep_equals(a, b) then
    self:pass("Values are not equal")
  else
    self:fail("Values are equal")
  end
end
function testContext:isTrue(a)
  if a == true then
    self:pass("Value is true")
  else
    self:fail("Value is not true")
  end
end
function testContext:isFalse(a)
  if a == false then
    self:pass("Value is false")
  else
    self:fail("Value is not false")
  end
end
function testContext:truthy(a)
  if a then
    self:pass("Value is truthy")
  else
    self:fail("Value is not truthy")
  end
end
function testContext:falsey(a)
  if not a then
    self:pass("Value is falsey")
  else
    self:fail("Value is not falsey")
  end
end

function test.run()
  print("Running tests...")

  local passed = 0

  for _, t in ipairs(tests) do
    local ctx = testContext:new()
    local ok, result = pcall(t.fn, ctx)
    if not ok then
      print("Test failed to run: " .. t.name)
      print(result)
    end
    if ctx.passed == false then
      print("Test failed: " .. t.name)
      print(ctx.message)
    elseif ctx.passed == true then
      -- print("Test passed: " .. t.name)
      -- print(ctx.message)
      passed = passed + 1
    end
  end

  print("Tests passed: " .. passed)
  print("Tests failed: " .. (#tests - passed))

  if passed == #tests then
    os.exit(0)
  else
    os.exit(1)
  end

end

return test