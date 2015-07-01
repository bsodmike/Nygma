# Nygma

[![Build Status](https://travis-ci.org/bsodmike/Nygma.svg?branch=master)](https://travis-ci.org/bsodmike/Nygma)

Gotham's very own Mr. Nygma, a Rails 4.2 attribute Encryptor

## Compatibility

* Requires Ruby 2
* Travis CI for 2.0.0, 2.1.0, and 2.2.2

## Usage

Add Nygma to your Gemfile and an initialiser to your Rails app, generating the
key and salt with `SecureRandom.hex(40)` and `SecureRandom.random_bytes(64)`.

These are best passed to your app via env keys, as shown below.

```ruby
# config/initializers/nygma.rb

Rails.application.config.encryptor = Nygma::Encryptor.crypt!(
  ENV['NYGMA_KEY'], ENV['NYGMA_SECRET']
)
```

You will now be able to specify attributes within your models that need
attribute level encryption,

```ruby
class POTUSNuclearCode < ActiveRecord::Base
  encrypt :launch_code, :auth_token
end
```

The world is now safe as the Chinese won't be able to grab US nuclear launch
codes from Hillary's email account!  They'll be nicely encrypted and
persisted to disk.

### How it works

```ruby
crypt = Nygma::Encryptor.crypt!(
  SecureRandom.hex(40),
  SecureRandom.random_bytes(64)
)

encrypted_data = crypt.encrypt("foo")
# => "bDFTamNFcUxvU052c1MyZ0t5NkppQT09LS1WeDhBZUR1SkphczR2WmxiSWJoUElnPT0=--54f84c7f97986ab9b6afb74aea6e9b5b764cf6c1"

crypt.decrypt(encrypted_data)
# => "foo"
```

Generate the key with `SecureRandom.hex(40)` and salt with `SecureRandom.random_bytes(64)`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This project rocks and uses MIT-LICENSE.
