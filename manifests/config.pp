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
}
