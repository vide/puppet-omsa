# Class: omsa
# ===========================
#
# OMSA is the Dell OpenManage System Administrator and it's a useful tool
# to check and configure your Dell HW  from within the operating system
# This puppet module takes care of installing it from Dell's repos and
# and creates a basic configuration
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
# * `service_name`
# The service name used to start OMSA. Default: dataeng
#
# * `service_ensure`
# Controls whether the service should be running or not. Default: running
#
# * `service_enable`
# Controls whether the service should be enabled at boot. Default: enabled
#
# * `install_storage`
# If true, enable the "omreport storage" subset. Default: true
#
# * `install_webserver`
# If true, enable the OMSA local webserver. Default: false
#
# * `install_rac4`
# Install components to manage the Dell Remote Access Card 4. Default: false
#
# * `install_rac5`
# Install components to manage the Dell Remote Access Card 5. Default: true
#
# * `enable_snmp`
# Enable SNMP integration by installing SNMP on the machine. Default: false
#
# * `force_install`
# Force OMSA installation even when $manufacturer is not Dell. Default: false
#
# Examples
# --------
#
# Example: install OMSA with RAID support but disable service autostart
#    class { 'omsa':
#      service_ensure => 'stopped',
#      install_storage => 'true',
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
  $enable_snmp       = false,
  $force_install     = false,
  $install_idrac     = false,
  $install_idrac7    = false,
  $install_all       = false,
) inherits omsa::params {

  if (( $::manufacturer =~ /^Dell.*/ ) or $force_install ) {
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
  } else {
    warning("OMSA works only on Dell hardware. Your HW is by ${::manufacturer}")
  }

}
