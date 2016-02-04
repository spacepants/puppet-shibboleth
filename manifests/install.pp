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
  }~>
  exec { 'bootstrap idp home':
    command => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/shib_install.sh",
    # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    environment => [
      "ANT_OPTS=\"
        -Didp.src.dir=/opt/staging/shibboleth-identity-provider-<%= @version %>
        -Didp.target.dir=<%= @idp_home %>
        -Didp.host.name=<%= @host_name %>
        -Didp.noprompt=yes
        -Didp.no.tidy=yes
        -Didp.keystore.password=<%= @keystore_pass %>
        -Didp.sealer.password=<%= @sealer_pass %>
        -Didp.merge.properties=/opt/staging/shibboleth-identity-provider-<%= @version %>/shibboleth.properties \"",
      "JAVA_HOME=${shibboleth::java_home}",
    ],
    refreshonly => true,
  }
}
