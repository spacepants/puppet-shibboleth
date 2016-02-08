# == Define shibboleth::attribute
#
# This define is called from shibboleth for building out an attribute definition.
#
# Examples:
# shibboleth::attribute { 'uid':
#   attribute_type => 'ad:Simple',
#   dependency     => 'myLDAP',
#   saml1_type     => 'SAML1String',
#   saml1_name     => 'urn:mace:dir:attribute-def:uid',
#   saml2_type     => 'SAML2String',
#   saml2_name     => 'urn:oid:0.9.2342.19200300.100.1.1',
# }
#
# shibboleth::attribute { 'eduPersonPrincipalName':
#   attribute_type => 'ad:Scoped',
#   scope          => '%{idp.scope}',
#   source_id      => 'uid',
#   dependency     => 'uid',
#   saml1_type     => 'SAML1ScopedString',
#   saml1_name     => 'urn:mace:dir:attribute-def:eduPersonPrincipalName',
#   saml2_type     => 'SAML2ScopedString',
#   saml2_name     => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6',
# }

define shibboleth::attribute (
  $attribute_type    = undef,
  $scope             = undef,
  $source_id         = $name,
  $dependency        = undef,
  $saml1_type        = undef,
  $saml1_name        = undef,
  $saml1_encode_type = 'false',
  $saml2_type        = undef,
  $saml2_name        = undef,
  $friendly_name     = $name,
  $saml2_encode_type = 'false',
) {
  concat::fragment { "${name} attribute definition":
    target  => 'attribute resolver',
    content => template('shibboleth/resolver-attribute.erb'),
    order   => '1',
  }
}
