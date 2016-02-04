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
    content => $shibboleth::backchannel_cert,
  }
  file { "${shibboleth::idp_home}/credentials/idp-backchannel.p12":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::backchannel_key_path,
  }
  file { "${shibboleth::idp_home}/credentials/idp-encryption.crt":
    ensure  => file,
    mode    => '0644',
    content => $shibboleth::encryption_cert,
  }
  file { "${shibboleth::idp_home}/credentials/idp-encryption.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::encryption_key_path,
  }
  file { "${shibboleth::idp_home}/credentials/idp-signing.crt":
    ensure  => file,
    mode    => '0644',
    content => $shibboleth::signing_cert,
  }
  file { "${shibboleth::idp_home}/credentials/idp-signing.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::signing_key_path,
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
  }
  file { "${shibboleth::idp_home}/conf/authn":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/authn",
  }
  file { "${shibboleth::idp_home}/conf/c14n":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/c14n",
  }
  file { "${shibboleth::idp_home}/conf/intercept":
    ensure => directory,
    recurse => true,
    source  => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/intercept",
  }
  file { "${shibboleth::idp_home}/conf/access-control.xml":
    ensure => file,
    content => template('shibboleth/access-control.xml.erb'),
  }
  file { "${shibboleth::idp_home}/conf/attribute-filter.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/attribute-filter.xml",
  }
  file { "${shibboleth::idp_home}/conf/attribute-resolver.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/attribute-resolver.xml",
  }
  file { "${shibboleth::idp_home}/conf/audit.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/audit.xml",
  }
  file { "${shibboleth::idp_home}/conf/cas-protocol.xml":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/cas-protocol.xml",
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
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/idp.properties",
  }
  file { "${shibboleth::idp_home}/conf/ldap.properties":
    ensure => file,
    source => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/ldap.properties",
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
}
