# == Class shibboleth::params
#
# This class is meant to be called from shibboleth.
# It sets variables according to platform.
#
class shibboleth::params {
  $shibboleth_user       = 'tomcat'
  $shibboleth_group      = 'tomcat'
  $version               = '3.2.1'
  $download_url          = 'https://shibboleth.net/downloads/identity-provider'
  $java_home             = '/etc/alternatives/java_sdk'
  $idp_home              = '/opt/shibboleth-idp'
  $host_name             = $::fqdn
  $entity_id             = "https://${host_name}/idp/shibboleth"
  $scope                 = $::domain
  $keystore_pass         = undef
  $sealer_pass           = undef
  $backchannel_cert      = undef
  $backchannel_cert_path = undef
  $backchannel_key_path  = undef
  $encryption_cert       = undef
  $encryption_cert_path  = undef
  $encryption_key_path   = undef
  $signing_cert          = undef
  $signing_cert_path     = undef
  $signing_key_path      = undef
  $sealer_keystore_path  = undef
  $sealer_keyver_path    = undef
  $display_name          = "A Name for the IdP at ${::fqdn}"
  $description           = "Enter a description of your IdP at ${::fqdn}"
  $logo                  = "https://${::fqdn}/Path/To/Logo.png"
  $manage_ui_info        = false
  $saml2                 = true
  $single_logout         = false
  $access_ips            = ['127.0.0.1/32', '::1/128']
  $cas                   = false
  $data_connector        = 'ldap'
  $ldap_bind             = false
  $ldap_binddn           = 'uid=myservice,ou=system'
  $ldap_bind_password    = 'myServicePassword'
  $ldap_url              = 'ldap://localhost:10389'
  $ldap_starttls         = 'true'
  $ldap_ssl              = 'false'
  $ldap_cert_path        = undef
  $ldap_timeout          = '3000'
  $ldap_basedn           = 'ou=people,dc=example,dc=org'
  $ldap_user_filter      = '(uid={user})'
  $ldap_search_filter    = '(uid=$resolutionContext.principal)'
  $ldap_attributes       = 'cn,homephone,mail'
}
