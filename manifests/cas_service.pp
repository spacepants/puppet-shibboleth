# == Define shibboleth::cas_service
#
# This define is called from shibboleth for defining a CAS service.
#
# Examples:
# shibboleth::cas_service { 'proxying-services':
#   regex         => 'https://([A-Za-z0-9_-]+\.)*example\.org(:\d+)?/.*',
#   proxy         => 'true',
#   single_logout => 'true',
# }
#
# shibboleth::cas_service { 'non-proxying-services':
#   regex         => 'https://([A-Za-z0-9_-]+\.)*example\.org(:\d+)?/.*',
# }

define shibboleth::cas_service (
  $regex = undef,
  $proxy = 'false',
  $single_logout = 'false',
  $service_order = '1',
) {
  concat::fragment { "${name} cas service":
    target  => 'cas protocol',
    content => template('shibboleth/cas-service.erb'),
    order   => $service_order,
  }
}
