# == Define shibboleth::metadata_provider
#
# This define is called from shibboleth for defining a CAS service.
#
# Examples:
# shibboleth::metadata_provider { 'incommon_metadata':
#   metadata_url  => 'http://md.incommon.org/InCommon',
#   metadata_file => 'InCommon-metadata.xml',
#   cert_url      => 'https://ds.incommon.org/certs',
#   cert_file     => 'inc-md-cert.pem',
#   max_refresh   => 'PT1H',
#   min_refresh   => 'PT5M',
#   refresh_delay => '0.75',
#   valid_until   => 'P14D',
# }

define shibboleth::metadata_provider (
  $metadata_url = undef,
  $metadata_file = undef,
  $cert_url = undef,
  $cert_file = undef,
  $max_refresh = undef,
  $min_refresh = undef,
  $refresh_delay = undef,
  $valid_until = undef,
) {
  exec { "download ${name} cert":
    command => "curl -o ${shibboleth::idp_home}/credentials/${cert_file} ${cert_url}/${cert_file}",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    creates => "${shibboleth::idp_home}/credentials/${cert_file}",
    owner   => "${shibboleth::shibboleth_user}",
    group   => "${shibboleth::shibboleth_group}"
  }
  exec { "download ${name} file":
    command => "curl -o ${shibboleth::idp_home}/metadata/${metadata_file} ${metadata_url}/${metadata_url}",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    creates => "${shibboleth::idp_home}/metadata/${metadata_file}",
    owner   => "${shibboleth::shibboleth_user}",
    group   => "${shibboleth::shibboleth_group}"
  }
  concat::fragment { "${name} metadata provider":
    target  => 'metadata providers',
    content => template('shibboleth/metadata-provider.erb'),
    order   => '1',
  }
}
