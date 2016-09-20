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
class omsa::install() {

  package { 'srvadmin-base':
    ensure => installed,
  }

  if ( str2bool("${::omsa::install_storage}")) {
    package { 'srvadmin-storageservices':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( str2bool("${::omsa::install_webserver}")) {
    package { 'srvadmin-webserver':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( str2bool("${::omsa::install_rac4}")) {
    package { 'srvadmin-rac4':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( str2bool("${::omsa::install_rac5}")) {
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
}
