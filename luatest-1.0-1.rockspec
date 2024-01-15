package = "luatest"
version = "1.0-1"
source = {
   url = "git://github.com/tayadev/luatest",
   tag = "v1.0"
}
description = {
   summary = "Pure Lua testing framework",
   detailed = "Pure Lua testing framework",
   homepage = "https://github.com/tayadev/luatest",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5"
}
build = {
   type = "builtin",
   modules = {
      luatest = "luatest.lua"
   }
}