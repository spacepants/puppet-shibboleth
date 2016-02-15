# Class: shibboleth
# ===========================
#
# Full description of class shibboleth here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class shibboleth (
  # Shibboleth settings
  $user                 = 'tomcat',
  $group                = 'tomcat',
  $version              = '3.2.1',
  $download_url         = 'https://shibboleth.net/downloads/identity-provider',
  $idp_home             = '/opt/shibboleth-idp',
  $java_home            = $::shibboleth::params::java_home,
  $host_name            = $::fqdn,
  $entity_id            = "https://${host_name}/idp/shibboleth",
  $scope                = $::domain,
  $data_connector       = 'ldap',
  $cas                  = false,
  $saml2                = true,
  $single_logout        = false,

  # Cert/key settings
  $keystore_pass        = undef,
  $sealer_pass          = undef,
  $backchannel_cert     = undef,
  $backchannel_key_path = undef,
  $encryption_cert      = undef,
  $encryption_key_path  = undef,
  $signing_cert         = undef,
  $signing_key_path     = undef,
  $sealer_keystore_path = undef,
  $sealer_keyver_path   = undef,

  $display_name         = "A Name for the IdP at ${::fqdn}",
  $description          = "Enter a description of your IdP at ${::fqdn}",
  $logo                 = "https://${::fqdn}/Path/To/Logo.png",

  $access_ips           = ['127.0.0.1/32', '::1/128'],

  # LDAP settings
  $ldap_url             = 'ldap://localhost:10389',
  $ldap_bind            = undef,
  $ldap_binddn          = 'uid=myservice,ou=system',
  $ldap_bind_password   = 'myServicePassword',
  $ldap_starttls        = 'true',
  $ldap_ssl             = 'false',
  $ldap_cert            = undef,
  $ldap_timeout         = '3000',
  $ldap_basedn          = 'ou=people,dc=example,dc=org',
  $ldap_user_filter     = '(uid={user})',
  $ldap_search_filter   = '(uid=$resolutionContext.principal)',
  $ldap_attributes      = 'cn,homephone,mail',

  # Install properties
  $install_properties = {
    'idp.entityID' => $entity_id,
    'idp.scope' => $scope,
  }

) inherits ::shibboleth::params {

  # validate parameters here

  class { '::shibboleth::install': } ->
  class { '::shibboleth::config': } ~>
  class { '::shibboleth::webapp': } ->
  Class['::shibboleth']
}
