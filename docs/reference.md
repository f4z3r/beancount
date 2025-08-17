# Beancount

<a name="top"></a>

<!--toc:start-->
- [Beancount](#beancount)
  - [Amount](#amount)
    - [Amount:new](#amountnew)
  - [Posting](#posting)
    - [Posting:new](#postingnew)
    - [Posting:commodity](#postingcommodity)
    - [Posting:price](#postingprice)
    - [Posting:total_cost](#postingtotalcost)
  - [TransactionType](#transactiontype)
  - [Transaction](#transaction)
    - [Transaction:new](#transactionnew)
    - [Transaction:metadata](#transactionmetadata)
    - [Transaction:tag](#transactiontag)
    - [Transaction:type](#transactiontype)
    - [Transaction:date](#transactiondate)
    - [Transaction:posting](#transactionposting)
<!--toc:end-->

---

## Amount

An amount consisting of a number and a commodity.

### Amount:new

```lua
(method) Amount:new(amount: number, commodity: string, multiplier: number?)
  -> Amount
```

Create a new amount.

Parameters:
- `amount` - A quantity. For instance the value 100 for an amount of "100 USD".
- `commodity` - The commodity. For instance the string USD for an amount of "100 USD".
- `multiplier` - A potential multiplier in order to support multiplication arithmetic in the amount.
  For instance the value 10 for an amount of "10 * 5 USD". This is likely to change in the future,
  in order to support a wider range of arithmetic operations.

[Back to top](#top)

## Posting

A posting on an account, optionally containing an amount.

### Posting:new

```lua
(method) Posting:new(account: string)
  -> Posting
```

Create a new posting for an account.

Parameters:
- `account` - The account for which to create a posting.

[Back to top](#top)

### Posting:commodity

```lua
(method) Posting:commodity(amount: number, commodity: string, multiplier: number?)
  -> Posting
```

Add a commodity to the posting.

Parameters:
- `amount` - A quantity. See [`Amount:new`](#amountnew).
- `commodity` - The commodity. See [`Amount:new`](#amountnew).
- `multiplier` - A potential multiplier in order to support multiplication arithmetic in the amount.
  See [`Amount:new`](#amountnew).

[Back to top](#top)

### Posting:price

```lua
(method) Posting:price(amount: number, commodity: string)
  -> Posting
```

Add a price to the posting.

Parameters:
- `amount` - A quantity. See [`Amount:new`](#amountnew).
- `commodity` - The commodity. See [`Amount:new`](#amountnew).

[Back to top](#top)

### Posting:total_cost

```lua
(method) Posting:total_cost(amount: number, commodity: string)
  -> Posting
```

Add a total cost to the posting.

Parameters:
- `amount` - A quantity. See [`Amount:new`](#amountnew).
- `commodity` - The commodity. See [`Amount:new`](#amountnew).

[Back to top](#top)

## TransactionType

```lua
table
```

The type of a transaction. Can be:

- `OK` (default for all transactions).
- `NOK`

[Back to the top](#top)

## Transaction

A full beancount transaction.

### Transaction:new

```lua
(method) Transaction:new(date: string, desc: string)
  -> Transaction
```

Create a new transaction.

Parameters:
- `date` - The date for the transaction. This will panic if the date does not conform to the ISO
  8601 format (e.g. 2025-11-27).
- `desc` - A description for the transaction.

[Back to top](#top)

### Transaction:metadata

```lua
(method) Transaction:metadata(key: string, value: string)
  -> Transaction
```

Add metadata to the transaction.

Parameters:
- `key` - The key under which to add the metadata. Calling this repeatedly on the same transaction
  with the same key will overwrite previous values.
- `value` - The value for the metadata point.

[Back to top](#top)

### Transaction:tag

```lua
(method) Transaction:tag(...string)
  -> Transaction
```

Add tags to the transaction.

Parameters:
- `...` - The tags to attach to the transaction. Calling this repeatedly will append the tags to
  existing ones.

[Back to top](#top)

### Transaction:type

```lua
(method) Transaction:type(typ: TransactionType)
  -> Transaction
```

Change the type of the transaction.

Parameters:
- `typ` - The type to assign to the transaction.

[Back to top](#top)

### Transaction:date

```lua
(method) Transaction:date()
  -> string
```

Return the date of the transaction.

[Back to top](#top)

### Transaction:posting

```lua
(method) Transaction:posting(...Posting)
  -> Transaction
```

Add a posting to this transaction.

Parameters:
- `...` - The postings to attach to the transaction. Calling this repeatedly will append the
  postings to existing ones.

[Back to top](#top)
