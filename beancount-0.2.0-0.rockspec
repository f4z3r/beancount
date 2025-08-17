local package_version = "0.2.0"
rockspec_format = "3.0"
package = "beancount"
version = package_version .. "-0"
source = {
  url = "git://github.com/f4z3r/beancount.git",
  tag = "v" .. package_version,
}
description = {
  summary = "A library to interact with beancount objects directly in Lua.",
  detailed = [[
     Interact with beancount objects in Lua with without depending on other
     libraries. Work with the speed of LuaJIT with your ledgers without
     any hassle.
   ]],
  homepage = "https://github.com/f4z3r/beancount/tree/main",
  license = "MIT",
}
dependencies = {
  "lua >= 5.1",
}
build = {
  type = "builtin",
  modules = {
    beancount = "./beancount.lua",
  },
}
