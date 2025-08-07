--# selene: allow(undefined_variable, incorrect_standard_library_use)

local beancount = require("beancount")

context("This", function()
  describe("That, it", function()
    it("should work", function()
      assert.are.equal(1, 1)
    end)
  end)
end)
