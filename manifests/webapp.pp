# == Class shibboleth::webapp
#
# This class is meant to be called from shibboleth.
# It builds the idp.war webapp.
#
class shibboleth::webapp {

  exec { 'build idp.war':
    command => "${shibboleth::idp_home}/bin/build.sh",
    # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    environment => "JAVA_HOME=${shibboleth::java_home}",
    refreshonly => true,
  }
}
