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
  shibboleth::certificate { 'backchannel':
    certificate => $shibboleth::backchannel_cert,
    path => "${shibboleth::idp_home}/credentials/idp-backchannel.crt",
  }
  file { "${shibboleth::idp_home}/credentials/idp-backchannel.p12":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::backchannel_key_path,
  }
  shibboleth::certificate { 'encryption':
    certificate => $shibboleth::encryption_cert,
    path => "${shibboleth::idp_home}/credentials/idp-encryption.crt",
  }
  file { "${shibboleth::idp_home}/credentials/idp-encryption.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::encryption_key_path,
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  shibboleth::certificate { 'signing':
    certificate => $shibboleth::signing_cert,
    path => "${shibboleth::idp_home}/credentials/idp-signing.crt",
  }
  file { "${shibboleth::idp_home}/credentials/idp-signing.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::signing_key_path,
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
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
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  if $shibboleth::ldap_cert {
    shibboleth::certificate { 'ldap':
      certificate => $shibboleth::ldap_cert,
      path => "${shibboleth::idp_home}/credentials/ldap-server.crt",
    }
  }
  file { "${shibboleth::idp_home}/conf/authn":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/authn",
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  file { "${shibboleth::idp_home}/conf/c14n":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/c14n",
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  file { "${shibboleth::idp_home}/conf/intercept":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/intercept",
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  file { "${shibboleth::idp_home}/conf/access-control.xml":
    ensure => file,
    content => template('shibboleth/access-control.xml.erb'),
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  concat { 'attribute filter':
    ensure => present,
    path   => "${shibboleth::idp_home}/conf/attribute-filter.xml",
    owner  => $shibboleth::user,
    group  => $shibboleth::group,
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
    path   => "${shibboleth::idp_home}/conf/attribute-resolver.xml",
    owner  => $shibboleth::user,
    group  => $shibboleth::group,
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
  concat { 'cas protocol':
    ensure => present,
    path   => "${shibboleth::idp_home}/conf/cas-protocol.xml",
    owner  => $shibboleth::user,
    group  => $shibboleth::group,
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
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  file { "${shibboleth::idp_home}/conf/ldap.properties":
    ensure => file,
    content => template('shibboleth/ldap.properties.erb'),
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
  file { "${shibboleth::idp_home}/conf/logback.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/logback.xml",
  }
  concat { 'metadata providers':
    ensure => present,
    path   => "${shibboleth::idp_home}/conf/metadata-providers.xml",
    owner  => $shibboleth::user,
    group  => $shibboleth::group,
  }
  concat::fragment { 'metadata providers header':
    target  => 'metadata providers',
    content => template('shibboleth/metadata-providers-header.erb'),
    order   => '0',
  }
  concat::fragment { 'metadata providers footer':
    target  => 'metadata providers',
    content => "</MetadataProvider>\n",
    order   => '999',
  }
  file { "${shibboleth::idp_home}/conf/mvc-beans.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/mvc-beans.xml",
  }
  file { "${shibboleth::idp_home}/conf/relying-party.xml":
    ensure => file,
    content => template('shibboleth/relying-party.xml.erb'),
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
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
  file { "${shibboleth::idp_home}/logs":
    ensure => directory,
    owner   => $shibboleth::user,
    group   => $shibboleth::group,
  }
}
