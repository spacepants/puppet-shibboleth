# == Class shibboleth::webapp
#
# This class is meant to be called from shibboleth.
# It builds the idm.war webapp.
#
class shibboleth::webapp {

  exec { 'build idm.war':
    command => "/opt/staging/shibboleth-identity-provider-${shibboleth::version}/bin/build.sh",
    # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }
}
