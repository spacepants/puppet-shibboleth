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
  }
  $defaults = {
    'path' => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/shibboleth.properties",
    'key_val_separator' => '=',
    'require' => File["/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/shibboleth.properties"],
    'notify' => Exec['bootstrap idp home'],
  }
  create_ini_settings({ '' => $::shibboleth::install_properties }, $defaults)
  exec { 'bootstrap idp home':
    command => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/bin/install.sh",
    # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    environment => [
      "ANT_OPTS=-Didp.src.dir=/opt/staging/shibboleth-identity-provider-${shibboleth::version} -Didp.target.dir=${shibboleth::idp_home} -Didp.host.name=${shibboleth::host_name} -Didp.noprompt=yes -Didp.no.tidy=yes -Didp.keystore.password=${shibboleth::keystore_pass} -Didp.sealer.password=${shibboleth::sealer_pass} -Didp.merge.properties=/opt/staging/shibboleth-identity-provider-${shibboleth::version}/conf/shibboleth.properties",
      "JAVA_HOME=${shibboleth::java_home}",
    ],
    refreshonly => true,
  }
}
