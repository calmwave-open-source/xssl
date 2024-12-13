# xSSL

This is a fork of [OTP 27](https://github.com/erlang/otp)'s SSL module, with a [patch](https://github.com/erlangbureau/jamdb_oracle/blob/master/test/ssl-10.8-otp-25.patch) conceived by the author of the Elixir/erlang OracleDB client [Jamdb.Oracle](https://github.com/erlangbureau/jamdb_oracle).

## Installation

```elixir
def deps do
  [
    {:xssl, github: "calmwave-open-source/xssl", branch: "main"}
  ]
end
```
