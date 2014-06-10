[![Gem Version](https://badge.fury.io/rb/national-ids-validator@2x.png)](http://badge.fury.io/rb/national-ids-validator)
[![Build Status](https://travis-ci.org/matfiz/national-ids-validator.svg?branch=master)](https://travis-ci.org/matfiz/national-ids-validator)
[![Coverage Status](https://coveralls.io/repos/matfiz/national-ids-validator/badge.png)](https://coveralls.io/r/matfiz/national-ids-validator)

National IDs Validator for Ruby on Rails (Active Model)
======================

It provides validators for national identification numbers. Currently the following countries are supported:
* Norway (NO) - Fødselsnummer
* Poland (PL) - PESEL

## Usage

Add to your Gemfile:

```ruby
gem 'national-ids-validator'
```

Run:

```
bundle install
```

Then add the following to your model:

```ruby
require 'national_ids_validator'
validates :personal_id_attribute, :national_id => {country: "PL"}
```

## Options
A custom error message can be provided:

```ruby
require 'national_ids_validator'
validates :personal_id_attribute, :national_id => {country: "PL", message: "is not valid personal number"}
```

If the nil value should be allowed, it need to be explicitely stated:
```ruby
require 'national_ids_validator'
validates :personal_id_attribute, :national_id => {country: "PL", allow_nil: true}
```

## Retrieving data out of the personal number
Often personal number contains useful data like birth date and/or gender. You may use the following commands to retrieve them:

* gender
```ruby
require 'national_ids_validator'
NationalIdsValidator.new("12030599592", "NO").gender %returns 0
```
It will return *0* for man, *1* for woman and *nil* for invalid number.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credit

Based on https://github.com/balexand/email_validator and https://github.com/max-power/iban.

## License

MIT License. Copyright 2009-2014 Grzegorz Brzezinka. http://brzezinka.eu
