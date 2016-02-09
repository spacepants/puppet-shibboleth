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
  $shibboleth_user       = $::shibboleth::params::shibboleth_user,
  $shibboleth_group      = $::shibboleth::params::shibboleth_group,
  $version               = $::shibboleth::params::version,
  $download_url          = $::shibboleth::params::download_url,
  $java_home             = $::shibboleth::params::java_home,
  $idp_home              = $::shibboleth::params::idp_home,
  $host_name             = $::shibboleth::params::host_name,
  $entity_id             = $::shibboleth::params::entity_id,
  $scope                 = $::shibboleth::params::scope,
  $keystore_pass         = $::shibboleth::params::keystore_pass,
  $sealer_pass           = $::shibboleth::params::sealer_pass,
  $backchannel_cert      = $::shibboleth::params::backchannel_cert,
  $backchannel_cert_path = $::shibboleth::params::backchannel_cert_path,
  $backchannel_key_path  = $::shibboleth::params::backchannel_key_path,
  $encryption_cert       = $::shibboleth::params::encryption_cert,
  $encryption_cert_path  = $::shibboleth::params::encryption_cert_path,
  $encryption_key_path   = $::shibboleth::params::encryption_key_path,
  $signing_cert          = $::shibboleth::params::signing_cert,
  $signing_cert_path     = $::shibboleth::params::signing_cert_path,
  $signing_key_path      = $::shibboleth::params::signing_key_path,
  $sealer_keystore_path  = $::shibboleth::params::sealer_keystore_path,
  $sealer_keyver_path    = $::shibboleth::params::sealer_keyver_path,
  $display_name          = $::shibboleth::params::display_name,
  $description           = $::shibboleth::params::description,
  $logo                  = $::shibboleth::params::logo,
  $manage_ui_info        = $::shibboleth::params::manage_ui_info,
  $single_logout         = $::shibboleth::params::single_logout,
  $saml2                 = $::shibboleth::params::saml2,
  $access_ips            = $::shibboleth::params::access_ips,
  $data_connector        = $::shibboleth::params::data_connector,
  $ldap_url              = $::shibboleth::params::ldap_url,
  $ldap_bind             = $::shibboleth::params::ldap_bind,
  $ldap_binddn           = $::shibboleth::params::ldap_binddn,
  $ldap_bind_password    = $::shibboleth::params::ldap_bind_password,
  $ldap_starttls         = $::shibboleth::params::ldap_starttls,
  $ldap_ssl              = $::shibboleth::params::ldap_ssl,
  $ldap_cert_path        = $::shibboleth::params::ldap_cert_path,
  $ldap_timeout          = $::shibboleth::params::ldap_timeout,
  $ldap_basedn           = $::shibboleth::params::ldap_basedn,
  $ldap_user_filter      = $::shibboleth::params::ldap_user_filter,
  $ldap_search_filter    = $::shibboleth::params::ldap_search_filter,
  $ldap_attributes       = $::shibboleth::params::ldap_attributes,
  $cas                   = $::shibboleth::params::cas,
) inherits ::shibboleth::params {

  # validate parameters here

  class { '::shibboleth::install': } ->
  class { '::shibboleth::config': } ~>
  class { '::shibboleth::webapp': } ->
  Class['::shibboleth']
}
