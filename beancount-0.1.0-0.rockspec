local package_version = "0.1.0"
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
