# == Class shibboleth::config
#
# This class is called from shibboleth for service config.
#
class shibboleth::config {
  file { "${shibboleth::idp_home}/metadata/idp-metadata.xml":
    ensure  => file,
    mode    => '0644',
    content => template('shibboleth/idp-metadata.xml.erb'),
  }
  file { "${shibboleth::idp_home}/credentials/idp-backchannel.crt":
    ensure  => file,
    mode    => '0644',
    content => template('shibboleth/backchannel-cert.erb'),
  }
  file { "${shibboleth::idp_home}/credentials/idp-backchannel.p12":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::backchannel_key_path,
  }
  file { "${shibboleth::idp_home}/credentials/idp-encryption.crt":
    ensure  => file,
    mode    => '0644',
    content => template('shibboleth/encryption-cert.erb'),
  }
  file { "${shibboleth::idp_home}/credentials/idp-encryption.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::encryption_key_path,
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/credentials/idp-signing.crt":
    ensure  => file,
    mode    => '0644',
    content => template('shibboleth/signing-cert.erb'),
  }
  file { "${shibboleth::idp_home}/credentials/idp-signing.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::signing_key_path,
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/credentials/sealer.jks":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::sealer_keystore_path,
  }
  file { "${shibboleth::idp_home}/credentials/sealer.kver":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::sealer_keyver_path,
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  if $shibboleth::ldap_cert_path {
    file { "${shibboleth::idp_home}/credentials/ldap-server.crt":
      ensure => file,
      mode   => '0644',
      source => $shibboleth::ldap_cert_path,
    }
  }
  file { "${shibboleth::idp_home}/conf/authn":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/authn",
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/conf/c14n":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/c14n",
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/conf/intercept":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/intercept",
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/conf/access-control.xml":
    ensure => file,
    content => template('shibboleth/access-control.xml.erb'),
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  concat { 'attribute filter':
    ensure => present,
    path   => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/attribute-filter.xml",
    owner  => $shibboleth::shibboleth_user,
    group  => $shibboleth::shibboleth_group,
  }
  concat::fragment { 'attribute filter header':
    target  => 'attribute filter',
    content => template('shibboleth/filter-header.erb'),
    order   => '0',
  }
  concat::fragment { 'attribute filter footer':
    target  => 'attribute filter',
    content => "</AttributeFilterPolicyGroup>\n",
    order   => '999',
  }
  concat { 'attribute resolver':
    ensure => present,
    path   => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/attribute-resolver.xml",
    owner  => $shibboleth::shibboleth_user,
    group  => $shibboleth::shibboleth_group,
  }
  concat::fragment { 'attribute resolver header':
    target  => 'attribute resolver',
    content => template('shibboleth/resolver-header.erb'),
    order   => '0',
  }
  concat::fragment { 'attribute resolver footer':
    target  => 'attribute resolver',
    content => template('shibboleth/resolver-footer.erb'),
    order   => '999',
  }
  file { "${shibboleth::idp_home}/conf/audit.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/audit.xml",
  }
  file { "${shibboleth::idp_home}/conf/cas-protocol.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/cas-protocol.xml",
  }
  concat { 'cas protocol':
    ensure => present,
    path   => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/cas-protocol.xml",
    owner  => $shibboleth::shibboleth_user,
    group  => $shibboleth::shibboleth_group,
  }
  concat::fragment { 'cas protocol header':
    target  => 'cas protocol',
    content => template('shibboleth/cas-header.erb'),
    order   => '0',
  }
  concat::fragment { 'cas protocol footer':
    target  => 'cas protocol',
    content => template('shibboleth/cas-footer.erb'),
    order   => '999',
  }
  file { "${shibboleth::idp_home}/conf/credentials.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/credentials.xml",
  }
  file { "${shibboleth::idp_home}/conf/errors.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/errors.xml",
  }
  file { "${shibboleth::idp_home}/conf/global.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/global.xml",
  }
  file { "${shibboleth::idp_home}/conf/idp.properties":
    ensure => file,
    content => template('shibboleth/idp.properties.erb'),
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/conf/ldap.properties":
    ensure => file,
    content => template('shibboleth/ldap.properties.erb'),
    owner   => $shibboleth::shibboleth_user,
    group   => $shibboleth::shibboleth_group,
  }
  file { "${shibboleth::idp_home}/conf/logback.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/logback.xml",
  }
  file { "${shibboleth::idp_home}/conf/metadata-providers.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/metadata-providers.xml",
  }
  file { "${shibboleth::idp_home}/conf/mvc-beans.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/mvc-beans.xml",
  }
  file { "${shibboleth::idp_home}/conf/relying-party.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/relying-party.xml",
  }
  file { "${shibboleth::idp_home}/conf/saml-nameid.properties":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/saml-nameid.properties",
  }
  file { "${shibboleth::idp_home}/conf/saml-nameid.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/saml-nameid.xml",
  }
  file { "${shibboleth::idp_home}/conf/services.properties":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/services.properties",
  }
  file { "${shibboleth::idp_home}/conf/services.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/services.xml",
  }
  file { "${shibboleth::idp_home}/conf/session-manager.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/session-manager.xml",
  }
  file { "${shibboleth::idp_home}/bin/aacli.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/ant.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/build.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/install.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/keygen.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/reload-metadata.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/reload-service.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/runclass.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/seckeygen.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/status.sh":
    ensure => file,
    mode   => '0755',
  }
  file { "${shibboleth::idp_home}/bin/version.sh":
    ensure => file,
    mode   => '0755',
  }
  shibboleth::attribute { 'uid':
    attribute_type => 'ad:Simple',
    dependency     => 'myLDAP',
    saml1_type     => 'SAML1String',
    saml1_name     => 'urn:mace:dir:attribute-def:uid',
    saml2_type     => 'SAML2String',
    saml2_name     => 'urn:oid:0.9.2342.19200300.100.1.1',
  }
  shibboleth::attribute { 'eduPersonPrincipalName':
    attribute_type => 'ad:Scoped',
    scope          => '%{idp.scope}',
    source_id      => 'uid',
    dependency     => 'uid',
    saml1_type     => 'SAML1ScopedString',
    saml1_name     => 'urn:mace:dir:attribute-def:eduPersonPrincipalName',
    saml2_type     => 'SAML2ScopedString',
    saml2_name     => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6',
  }
  shibboleth::attribute { 'mail':
    attribute_type => 'ad:Simple',
    dependency     => 'myLDAP',
    saml1_type     => 'SAML1String',
    saml1_name     => 'urn:mace:dir:attribute-def:mail',
    saml2_type     => 'SAML2String',
    saml2_name     => 'urn:oid:0.9.2342.19200300.100.1.3',
  }
  shibboleth::attribute { 'givenName':
    attribute_type => 'ad:Simple',
    dependency     => 'myLDAP',
    saml1_type     => 'SAML1String',
    saml1_name     => 'urn:mace:dir:attribute-def:givenName',
    saml2_type     => 'SAML2String',
    saml2_name     => 'urn:oid:2.5.4.42',
  }
  shibboleth::attribute { 'sn':
    attribute_type => 'ad:Simple',
    dependency     => 'myLDAP',
    saml1_type     => 'SAML1String',
    saml1_name     => 'urn:mace:dir:attribute-def:sn',
    saml2_type     => 'SAML2String',
    saml2_name     => 'urn:oid:2.5.4.4',
  }
  shibboleth::attribute { 'displayName':
    attribute_type => 'ad:Simple',
    dependency     => 'myLDAP',
    saml1_type     => 'SAML1String',
    saml1_name     => 'urn:mace:dir:attribute-def:displayName',
    saml2_type     => 'SAML2String',
    saml2_name     => 'urn:oid:2.16.840.1.113730.3.1.241',
  }
  shibboleth::attribute { 'employeeNumber':
    attribute_type => 'ad:Simple',
    dependency     => 'myLDAP',
    saml1_type     => 'SAML1String',
    saml1_name     => 'urn:mace:dir:attribute-def:employeeNumber',
    saml2_type     => 'SAML2String',
    saml2_name     => 'urn:oid:2.16.840.1.113730.3.1.3',
  }
}
