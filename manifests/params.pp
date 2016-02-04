# == Class shibboleth::params
#
# This class is meant to be called from shibboleth.
# It sets variables according to platform.
#
class shibboleth::params {
  $version              = '3.2.1'
  $download_url         = 'https://shibboleth.net/downloads/identity-provider/latest/'
  $java_home            = '/etc/alternatives/java_sdk'
  $idp_home             = '/opt/shibboleth-idp'
  $host_name            = $::fqdn
  $entity_id            = "https://${host_name}/idp/shibboleth"
  $scope                = $::domain
  $keystore_pass        = undef
  $sealer_pass          = undef
  $backchannel_cert     = undef
  $backchannel_key_path = undef
  $encryption_cert      = undef
  $encryption_key_path  = undef
  $signing_cert         = undef
  $signing_key_path     = undef
  $sealer_keystore_path = undef
  $sealer_keyver_path   = undef
  $display_name         = "A Name for the IdP at ${::fqdn}"
  $description          = "Enter a description of your IdP at ${::fqdn}"
  $logo                 = "https://${::fqdn}/Path/To/Logo.png"
  $manage_ui_info       = false
  $saml2                = false
}
