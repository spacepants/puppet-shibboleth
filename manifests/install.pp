# == Class shibboleth::install
#
# This class is called from shibboleth for install.
#
class shibboleth::install {
  staging::deploy { "shibboleth-identity-provider-${shibboleth::version}.tar.gz":
    target => '/opt/staging',
    source => "${shibboleth::download_url}/${shibboleth::version}/shibboleth-identity-provider-${shibboleth::version}.tar.gz",
    staging_path => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}.tar.gz",
    creates => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}",
  }->
  file { "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/shibboleth.properties":
    ensure  => file,
    content => template('shibboleth/shibboleth.properties.erb'),
    notify  => Exec['bootstrap idp home'],
  }->
  file { "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/shib_install.sh":
    ensure  => file,
    mode    => '0400',
    content => template('shibboleth/shib_install.sh.erb'),
  }~>
  exec { 'bootstrap idp home':
    command => "/bin/sh /opt/staging/shibboleth-identity-provider-${shibboleth::version}/shib_install.sh",
    # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }
}
