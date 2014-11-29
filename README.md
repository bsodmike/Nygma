# Nygma

[![Build Status](https://travis-ci.org/bsodmike/Nygma.svg?branch=master)](https://travis-ci.org/bsodmike/Nygma)

Gotham's very own Mr. Nygma, a Rails 4 Encryptor

## Compatibility

* Supports multiple Ruby versions: Ruby 2.0.0, 2.1.0, 2.1.5 and above (see
Travis build status).
* Current untested for Ruby 1.9.3 and older.

## Usage

```ruby
crypt = Nygma::Encryptor.crypt!(
  Nygma::Configuration.secure_key,
  Nygma::Configuration.secure_salt
)

encrypted_data = crypt.encrypt_and_sign("foo")
# => "bDFTamNFcUxvU052c1MyZ0t5NkppQT09LS1WeDhBZUR1SkphczR2WmxiSWJoUElnPT0=--54f84c7f97986ab9b6afb74aea6e9b5b764cf6c1"

crypt.decrypt_and_verify(encrypted_data)
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
