# LTest
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0)
![](https://img.shields.io/badge/Lua-5.1--5.4-green?style=for-the-badge)
![](https://img.shields.io/badge/LuaJIT-2.0--2.1-green?style=for-the-badge)
[![Ko-Fi](https://img.shields.io/badge/Ko-fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/tayacrystals)
![https://taya.one](https://img.shields.io/badge/Made%20by-Taya-ee82ee?style=for-the-badge)

Pure Lua testing framework

## Usage

```lua
local test = require 'ltest'

test('test name', function(t)
  t:is(1, 1)
end)

test.run()
```

## Assertions

- `t:pass(message?)` Passes the test
- `t:fail(message?)` Fails the test
- `t:assert(value, message?)` Asserts that `value` is truthy
- `t:is(value, expected, message?)` Asserts that `value` is equal to `expected`
- `t:isnt(value, notexpected, message?)` Asserts that `value` is not equal to `notexpected`
- `t:isTrue(value, message?)` Asserts that `value` is true
- `t:isFalse(value, message?)` Asserts that `value` is false
- `t:truthy(value, message?)` Asserts that `value` is truthy
- `t:falsy(value, message?)` Asserts that `value` is falsy
- `t:throws(fn, message?)` Asserts that `fn` throws an error
- `t:notThrows(fn, message?)` Asserts that `fn` does not throw an error
- `t:match(value, pattern, message?)` Asserts that `value` matches `pattern`
- `t:notMatch(value, pattern, message?)` Asserts that `value` does not match `pattern`