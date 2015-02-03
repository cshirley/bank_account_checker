[![Circle CI](https://circleci.com/gh/cshirley/bank_account_checker.svg?style=svg)](https://circleci.com/gh/cshirley/bank_account_checker)
[![Coverage Status](https://coveralls.io/repos/cshirley/bank_account_checker/badge.svg)](https://coveralls.io/r/cshirley/bank_account_checker)
# BankAccountChecker

Simple API wrapper for http://www.bankaccountchecker.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bank_account_checker', git: 'https://github.com/cshirley/bank_account_checker.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bank_account_checker

## Usage

Get Bank Account Details:

```ruby
client = BankAccountChecker::Client.new("user_name", "password")
```
To Check a bank account:

```ruby
json_response = client.get_bank_account("557030", "12345678")

    {"resultCode"=>"01",
     "resultDescription"=>"Sortcode and Bank Account are valid",
     "accountProperties" => { "institution"=>"NATIONAL WESTMINSTER BANK PLC",
                              "branch"=>"CROYDON",
                              "fast_payment"=>"true",
                              "bacs_credit"=>"true",
                              "bacs_direct_debit"=>"true",
                              "chaps"=>"true",
                              "cheque"=>"true"}}
```
### Exceptions
Authentication Failure:

```ruby
AuthenticationError
```

Invalid Bank Account:

```ruby
InvalidBankAccountError
```

Server Generated API Error:

```ruby
ApiException
```

## Contributing

1. Fork it ( https://github.com/cshirley/bank_account_checker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
