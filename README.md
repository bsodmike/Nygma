# Nygma

[![Build Status](https://travis-ci.org/bsodmike/Nygma.svg?branch=master)](https://travis-ci.org/bsodmike/Nygma)

Gotham's very own Mr. Nygma, a Rails 4.2 attribute Encryptor

## Compatibility

* Supports Ruby 1.9.3 and 2.
* Travis CI for Ruby 1.9.3, and 2.2.2

## Usage

Add Nygma to your Gemfile and an initialiser to your Rails app, generating the
key and salt with `SecureRandom.hex(40)` and `SecureRandom.random_bytes(64)`.

```ruby
# config/initializers/nygma.rb

Rails.application.config.encryptor = Nygma::Encryptor.crypt!(
  'f46c1fb228aac44e55f82293a2341fb47c6f12c3721382ae7dbfe2e912941f59191efbc711f1ea5e',
  '[d\x89\r\xF6\xEB7\x9C\n\x1F+\xCAG\xF1g\e\x9Bg\xA7-:iG\b4\x03\xED\xCE\x8F>OH\b\x80\x8F\xE3\x17j\x1D\xA6\b?3\xC4\xE4\x8D\x9Eb\xA5\xB0\xB6jS\xAD\v\xE4\xBB\xDB\xF7\xFC\xBC\x04\xFD\xE4'
)
```

You will now be able to specify attributes within your models that need
attribute level encryption,

```ruby
class POTUSNuclearCode < ActiveRecord::Base
  encrypt :launch_code_potus, :football_token
end
```

### How it works

```ruby
crypt = Nygma::Encryptor.crypt!(
  Nygma::Configuration.secure_key,
  Nygma::Configuration.secure_salt
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
