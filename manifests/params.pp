# == Class shibboleth::params
#
# This class is meant to be called from shibboleth.
# It sets variables according to platform.
#
class shibboleth::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $java_home = '/etc/alternatives/java_sdk'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
