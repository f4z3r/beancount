<div align="center">

<img src="./assets/logo.jpeg" alt="Beancount" width="50%">

# Beancount

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/f4z3r/beancount/lint-and-test.yml)
![GitHub License](https://img.shields.io/github/license/f4z3r/beancount?link=https%3A%2F%2Fgithub.com%2Ff4z3r%2Fbeancount%2Fblob%2Fmain%2FLICENSE)
![GitHub Release](https://img.shields.io/github/v/release/f4z3r/beancount?logo=github&link=https%3A%2F%2Fgithub.com%2Ff4z3r%2Fbeancount%2Freleases)
![LuaRocks](https://img.shields.io/luarocks/v/f4z3r/beancount?logo=lua&link=https%3A%2F%2Fluarocks.org%2Fmodules%2Ff4z3r%2Fbeancount)

### A library to interact with [Beancount](https://beancount.io/) objects directly in Lua.

[About](#about) |
[Usage](#usage) |
[Roadmap](#roadmap) |
[License](#license)

<hr />
</div>

## About

This is a library grown out of personal use to help generate Beancount ledgers automatically. I am
currently mostly using this to parse CSVs and PDFs into Beancount transaction ledgers. In the future
I am thinking of using this for more advanced use cases.

I mostly decided against using beangulp because it seemed overly complex for simple generation of
ledgers, has a more rigid structure, has a dependency on beancount itself, and I ended up writing
quite massive importers for stuff that seemed trivial. Since I prefer Lua for simple yet flexible
scripting, I decided to write something small that allows me to easily render transactions without
any dependencies.

## Usage

See [`docs/reference.md`](./docs/reference.md) for a full reference of the API.

## Roadmap

This library has grown out of personal use. I am implementing stuff as I need it, while publishing
it here, mostly because why not? I am listing some feature that might be nice, but I won't implement
them unless I need them. Thus don't expect stuff to be implemented just because they are listed
below. If you want to use this library and are missing a feature (regardless of whether this is
listed below), open an issue and I will have a look.

- [ ] Documentation: this I will add for sure.
- [ ] Full support for transaction syntax, including posting costs, posting metadata, posting flags,
  etc.
- [ ] Support for generating balances.
- [ ] Support for generating commodity price points.
- [ ] Support for opening and closing accounts.
- [ ] Support for parsing strings into Lua objects.

## License

![GitHub License](https://img.shields.io/github/license/f4z3r/beancount)

The license can be found under [`./LICENSE`](./LICENSE).

