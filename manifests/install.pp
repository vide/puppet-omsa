# Class: omsa::install
# ===========================
#
# Internal class to install packages
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
class omsa::install( 
$srvadmin_all      = $::omsa::install_all,
) {

  package { 'srvadmin-base':
    ensure => installed,
  }
  
  if ( str2bool("${::omsa::install_all}")) {
    package { 'srvadmin-all':
      ensure  => installed,
    }
  }
  
  if ( (str2bool("${::omsa::install_storage}")) and (str2bool("$srvadmin_all")) != true ) {
    package { 'srvadmin-storageservices':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( ( str2bool("${::omsa::install_webserver}")) and (str2bool("$srvadmin_all")) != true ) {
    package { 'srvadmin-webserver':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( ( str2bool("${::omsa::install_rac4}")) and (str2bool("$srvadmin_all")) != true ) {
    package { 'srvadmin-rac4':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( (str2bool("${::omsa::install_rac5}")) and (str2bool("$srvadmin_all")) != true ) {
    package { 'srvadmin-rac5':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( str2bool("${::omsa::enable_snmp}")) {
    # external dependency
    contain ::snmp
    package { 'srvadmin-server-snmp':
      ensure  => installed,
      require => [ Package['srvadmin-base'], Class[::snmp] ],
    }
    if ( str2bool("${::omsa::install_storage}")) {
      package { 'srvadmin-storageservices-snmp':
        ensure  => installed,
        require => Package['srvadmin-server-snmp'],
      }
    }
  }
  
  if ( str2bool("${::omsa::install_idrac}")) {
    package { 'srvadmin-idrac':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }
  
  if ( str2bool("${::omsa::install_idrac7}")) {
    package { 'srvadmin-idrac7':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }
}

