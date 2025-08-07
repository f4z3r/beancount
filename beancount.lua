local string = require("string")

local M = {}

---@class Amount
---@field package amount number
---@field package unit string
local Amount = {}

---Create a new amount.
---@param amount number
---@param unit string
---@return Amount
function Amount:new(amount, unit)
  local obj = {
    amount = amount,
    unit = unit,
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Amount:__tostring()
  return string.format("%.2f %s", self.amount, self.unit)
end

---@class Posting
---@field package _amount Amount?
---@field package _price Amount?
---@field package _account string
local Posting = {}

function Posting:new(account)
  local obj = {
    _account = account,
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

---Add units to posting.
---@param amount number
---@param unit string
---@return Posting
function Posting:units(amount, unit)
  self._amount = Amount:new(amount, unit)
  return self
end

---Add price to posting.
---@param amount number
---@param unit string
---@return Posting
function Posting:price(amount, unit)
  self._price = Amount:new(amount, unit)
  return self
end

function Posting:__tostring()
  if self._price ~= nil then
    return string.format("%-40s %15s @ %s", self._account, self._amount, self._price)
  elseif self._amount ~= nil then
    return string.format("%-40s %15s", self._account, self._amount)
  end
  return string.format("%s", self._account)
end

---@class Transaction
---@field package _metadata { [string]: string }
---@field package _tags string[]
---@field package _desc string
---@field package _date string
---@field package _type TransactionType
---@field package _postings Posting[]
local Transaction = {}

---@enum TransactionType
local TransactionType = {
  OK = "*",
}

---Create a new Transaction
---@param date string
---@param desc string
---@return table
function Transaction:new(date, desc)
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
---@param key string
---@param value string
---@return Transaction
function Transaction:metadata(key, value)
  self._metadata[key] = value
  return self
end

---Add tags to the transaction.
---@vararg string
---@return Transaction
function Transaction:tag(...)
  for _, tag in ipairs({ ... }) do
    self._tags[#self._tags+1] = tag
  end
  return self
end

---Change the type of the transaction.
---@param typ TransactionType
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

---Set the postings for this transaction.
---@param postings Posting[]
---@return Transaction
function Transaction:postings(postings)
  self._postings = postings
  return self
end

function Transaction:__tostring()
  local header = string.format('%s %s "%s"', self._date, self._type, self._desc)
  for _, tag in ipairs(self._tags) do
    header = header .. string.format(' #%s', tag)
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
