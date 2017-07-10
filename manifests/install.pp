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

  if ( str2bool("${::omsa::install_all}")) {
    package { 'srvadmin-all':
      ensure  => installed,
    }
  } else {
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

    # rac* packages only exist as .rpm
    if ( str2bool("${::omsa::install_rac4}")) {
      if ($::osfamily == 'RedHat') {
        package { 'srvadmin-rac4':
          ensure  => installed,
          require => Package['srvadmin-base'],
        }
      } else {
        fail("${::omsa::install_rac5} package is only supported under RedHat")
      }
    }

    if ( str2bool("${::omsa::install_rac5}")) {
      if ($::osfamily == 'RedHat') {
        package { 'srvadmin-rac5':
          ensure  => installed,
          require => Package['srvadmin-base'],
        }
      } else {
        fail("${::omsa::install_rac5} package is only supported under RedHat")
      }
    }

    if ( str2bool("${::omsa::install_idrac}")) {
      package { $::omsa::params::idrac6_package:
        ensure  => installed,
        require => Package['srvadmin-base'],
      }
    }

    if ( str2bool("${::omsa::install_idrac7}")) {
      package { $::omsa::params::idrac7_package:
        ensure  => installed,
        require => Package['srvadmin-base'],
      }
    }

    # idrac8 package currently exists only as .deb
    if ($::osfamily == 'Debian') {
      package { $::omsa::params::idrac8_package:
        ensure  => installed,
        require => Package['srvadmin-base'],
      }
    } else {
      fail("${::omsa::params::idrac8_package} package is only supported under Debian family")
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
}
