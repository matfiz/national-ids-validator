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
validates :personal_id_attribute, :national_id => {country: "PL"}
```

## Options
A custom error message can be provided:

```ruby
validates :personal_id_attribute, :national_id => {country: "PL", message: "is not valid personal number"}
```

If the nil value should be allowed, it need to be explicitely stated:
```ruby
validates :personal_id_attribute, :national_id => {country: "PL", allow_nil: true}
```

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