
# ssl_labs

A gem to provide a client for ssllabs.com SSL/TLS scanner.

The reference client is at https://github.com/ssllabs/ssllabs-scan

## TODO

* Error handling

* Tests

* Weirdness: `#analyze` and `#analyze!` return different things

* Helper `#methods?` for boolean attributes

* `SslLabs` constructor must take a URI string _with a scheme_

* `endpoint_data.details.foo` is annoying; remove `details`

* Configurable poll delay

* `Cert` and `ChainCert` are melded
