# == Define shibboleth::filter
#
# This define is called from shibboleth for building out an attribute filter policy.
#
# Examples:
# shibboleth::filter { 'example1':
#   requesters => [ 'https://sp.example.org' ],
#   attributes => [
#     'eduPersonPrincipalName',
#     'uid',
#     'mail',
#   ],
# }
#
# shibboleth::filter { 'example2':
#   requesters => [
#     'https://sp.example.org',
#     'https://another.example.org/shibboleth',
#   ],
#   attributes => [ 'eduPersonScopedAffiliation' ],
# }

define shibboleth::filter (
  $requesters = [],
  $attributes = [],
) {
  concat::fragment { "${name} attribute filter policy":
    target  => 'attribute filter',
    content => template('shibboleth/filter-policy.erb'),
    order   => '1',
  }
}
