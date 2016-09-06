# Class: omsa
# ===========================
#
# Full description of class omsa here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `apt_key`
#  Hash containing the GPG key server and key id, as expected by
#  Puppetlabs apt module. Useful only if $manage_repo is true
#
# * `manage_repo`
#  Let this module manage the repositories for Dell OMSA installation
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'omsa':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Davide Ferrari <vide80@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Davide Ferrari, unless otherwise noted.
#
class omsa(
  $apt_key           = $::omsa::params::apt_key,
  $manage_repo       = true,
  $service_name      = $::omsa::params::service_name,
  $service_ensure    = $::omsa::params::service_ensure,
  $service_enable    = $::omsa::params::service_enable,
  $install_storage   = true,
  $install_webserver = false,
  $install_rac4      = false,
  $install_rac5      = true,
) inherits omsa::params {


  if str2bool("${manage_repo}") {
    class { '::omsa::repo':
      before => Class['::omsa::install'],
    }
  }

  contain ::omsa::install
  contain ::omsa::config
  contain ::omsa::service

  Class['::omsa::install'] ->
  Class['::omsa::config']  ->
  Class['::omsa::service']
}
