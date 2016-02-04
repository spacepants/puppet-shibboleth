# == Class shibboleth::config
#
# This class is called from shibboleth for service config.
#
class shibboleth::config {
  file { "${idp_home}/metadata/idp-metadata.xml":
    ensure  => file,
    mode    => '0644',
    content => template('shibboleth/idp-metadata.xml.erb'),
  }
  file { "${idp_home}/credentials/idp-backchannel.crt":
    ensure  => file,
    mode    => '0644',
    content => $shibboleth::backchannel_cert,
  }
  file { "${idp_home}/credentials/idp-backchannel.p12":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::backchannel_key_path,
  }
  file { "${idp_home}/credentials/idp-encryption.crt":
    ensure  => file,
    mode    => '0644',
    content => $shibboleth::encryption_cert,
  }
  file { "${idp_home}/credentials/idp-encryption.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::encryption_key_path,
  }
  file { "${idp_home}/credentials/idp-signing.crt":
    ensure  => file,
    mode    => '0644',
    content => $shibboleth::signing_cert,
  }
  file { "${idp_home}/credentials/idp-signing.key":
    ensure  => file,
    mode    => '0600',
    source => $shibboleth::signing_key_path,
  }
  file { "${idp_home}/credentials/sealer.jks":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::sealer_keystore_path,
  }
  file { "${idp_home}/credentials/sealer.kver":
    ensure  => file,
    mode    => '0644',
    source => $shibboleth::sealer_keyver_path,
  }
}
