# == Define shibboleth::certificate
#
# This define is called from shibboleth for creating an SSL cert file.
#
# Examples:
# shibboleth::certificate { 'example certificate':
#   certificate => "YOUR_SSL_CERT_GOES_HERE\nSPLIT_WITH_NEWLINES",
#   path        => '/path/to/certificate/file',
# }

define shibboleth::certificate (
  $certificate = undef,
  $path = undef,
) {
  validate_string($certificate)
  validate_absolute_path($path)

  file { $path:
    ensure  => file,
    content => template('shibboleth/certificate.erb'),
  }
}
