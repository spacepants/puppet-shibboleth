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
  $version              = $::shibboleth::params::version,
  $download_url         = $::shibboleth::params::download_url,
  $java_home            = $::shibboleth::params::java_home,
  $idp_home             = $::shibboleth::params::idp_home,
  $host_name            = $::shibboleth::params::host_name,
  $entity_id            = $::shibboleth::params::entity_id,
  $scope                = $::shibboleth::params::scope,
  $keystore_pass        = $::shibboleth::params::keystore_pass,
  $sealer_pass          = $::shibboleth::params::sealer_pass,
  $backchannel_cert     = $::shibboleth::params::backchannel_cert,
  $backchannel_key_path = $::shibboleth::params::backchannel_key_path,
  $encryption_cert      = $::shibboleth::params::encryption_cert,
  $encryption_key_path  = $::shibboleth::params::encryption_key_path,
  $signing_cert         = $::shibboleth::params::signing_cert,
  $signing_key_path     = $::shibboleth::params::signing_key_path,
  $sealer_keystore_path = $::shibboleth::params::sealer_keystore_path,
  $sealer_keyver_path   = $::shibboleth::params::sealer_keyver_path,
  $display_name         = $::shibboleth::params::display_name,
  $description          = $::shibboleth::params::description,
  $logo                 = $::shibboleth::params::logo,
  $manage_ui_info       = manage_ui_info,
  $saml2                = saml2,
) inherits ::shibboleth::params {

  # validate parameters here

  class { '::shibboleth::install': } ->
  class { '::shibboleth::config': } ~>
  class { '::shibboleth::webapp': } ->
  Class['::shibboleth']
}
