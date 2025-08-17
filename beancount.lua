--- Beancount module.
-- This module provides capabilities to interact with beancount objects
-- natively in Lua.

local string = require("string")

local M = {}

---An amount consisting of a number and a commodity.
---@class Amount
---@field package amount number
---@field package commodity string
---@field package multiplier number?
local Amount = {}

---Create a new amount.
---@param amount number A quantity. For instance the value 100 for an amount of "100 USD".
---@param commodity string The commodity. For instance the string USD for an amount of "100 USD".
---@param multiplier number? A potential multiplier in order to support multiplication arithmetic in the amount.
---@return Amount
function Amount:new(amount, commodity, multiplier)
  local obj = {
    amount = amount,
    commodity = commodity,
    multiplier = multiplier,
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Amount:__tostring()
  if self.multiplier then
    return string.format("%d * %.2f %s", self.multiplier, self.amount, self.commodity)
  end
  return string.format("%.2f %s", self.amount, self.commodity)
end

---A posting on an account, optionally containing an amount.
---@class Posting
---@field package _commodity Amount?
---@field package _price Amount?
---@field package _total_cost Amount?
---@field package _account string
local Posting = {}

---Create a new posting for an account.
---@param account string The account for which to create a posting.
---@return Posting
function Posting:new(account)
  local obj = {
    _account = account,
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

---Add a commodity to the posting.
---@param amount number A quantity.
---@param commodity string The commodity.
---@param multiplier number? A potential multiplier in order to support multiplication arithmetic in the amount.
---@return Posting
function Posting:commodity(amount, commodity, multiplier)
  self._commodity = Amount:new(amount, commodity, multiplier)
  return self
end

---Add a price to the posting.
---@param amount number A quantity.
---@param commodity string The commodity.
---@return Posting
function Posting:price(amount, commodity)
  self._price = Amount:new(amount, commodity)
  return self
end

---Add a total cost to the posting.
---@param amount number A quantity.
---@param commodity string The commodity.
---@return Posting
function Posting:total_cost(amount, commodity)
  self._total_cost = Amount:new(amount, commodity)
  return self
end

function Posting:__tostring()
  if self._total_cost ~= nil then
    assert(self._commodity ~= nil, "cannot set total cost without commotidy")
    assert(self._price == nil, "cannot set price and total cost")
    return string.format("%-40s %15s @@ %s", self._account, self._commodity, self._total_cost)
  elseif self._price ~= nil then
    assert(self._commodity ~= nil, "cannot set price without commotidy")
    return string.format("%-40s %15s @ %s", self._account, self._commodity, self._price)
  elseif self._commodity ~= nil then
    return string.format("%-40s %15s", self._account, self._commodity)
  end
  return string.format("%s", self._account)
end

---A full beancount transaction.
---@class Transaction
---@field package _metadata { [string]: string }
---@field package _tags string[]
---@field package _desc string
---@field package _date string
---@field package _type TransactionType
---@field package _postings Posting[]
local Transaction = {}

---The type of a transaction.
---@enum TransactionType
local TransactionType = {
  OK = "*",
  NOK = "!",
}

---Create a new transaction.
---@param date string The date for the transaction.
---@param desc string A description for the transaction.
---@return Transaction
function Transaction:new(date, desc)
  assert(string.match(date, "^%d%d%d%d%-%d%d%-%d%d$"))
  local obj = {
    _metadata = {},
    _tags = {},
    _date = date,
    _desc = desc,
    _type = TransactionType.OK,
    _postings = {},
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

---Add metadata to the transaction.
---@param key string The key under which to add the metadata.
---@param value string The value for the metadata point.
---@return Transaction
function Transaction:metadata(key, value)
  self._metadata[key] = value
  return self
end

---Add tags to the transaction.
---@vararg string The tags to attach to the transaction.
---@return Transaction
function Transaction:tag(...)
  for _, tag in ipairs({ ... }) do
    self._tags[#self._tags + 1] = tag
  end
  return self
end

---Change the type of the transaction.
---@param typ TransactionType The type to assign to the transaction.
---@return Transaction
function Transaction:type(typ)
  self._type = typ
  return self
end

---Return the date of the transaction.
---@return string
function Transaction:date()
  return self._date
end

---Add a posting to this transaction.
---@vararg Posting The postings to attach to the transaction.
---@return Transaction
function Transaction:posting(...)
  for _, posting in ipairs({ ... }) do
    self._postings[#self._postings + 1] = posting
  end
  return self
end

function Transaction:__tostring()
  local header = string.format('%s %s "%s"', self._date, self._type, self._desc)
  for _, tag in ipairs(self._tags) do
    header = header .. string.format(" #%s", tag)
  end
  local lines = { header }
  for k, v in pairs(self._metadata) do
    lines[#lines + 1] = string.format('  %s: "%s"', k, v)
  end
  for _, posting in ipairs(self._postings) do
    lines[#lines + 1] = string.format("  %s", posting)
  end
  return table.concat(lines, "\n")
end

M.Transaction = Transaction
M.Posting = Posting
M.Amount = Amount
M.TransactionType = TransactionType

return M
