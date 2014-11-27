## Nygma

### Usage

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

This project rocks and uses MIT-LICENSE.
