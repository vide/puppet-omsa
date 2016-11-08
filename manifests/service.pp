# Class: omsa::service
# ===========================
#
# Internal class to manage OMSA services
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
class omsa::service() inherits omsa::params {

  service { $::omsa::service_name:
    ensure     => $::omsa::service_ensure,
    enable     => $::omsa::service_enable,
    hasstatus  => $::omsa::params::service_hasstatus,
    hasrestart => $::omsa::params::service_hasrestart,
    require    => Class['::omsa::install'],
  }
  if ( str2bool($::omsa::install_webserver) or str2bool("${::omsa::install_all}")) {
    service {'dsm_om_connsvc':
      ensure  => $::omsa::service_ensure,
      enable  => $::omsa::service_enable,
      require => Class['::omsa::install'],
    }
  }
}
