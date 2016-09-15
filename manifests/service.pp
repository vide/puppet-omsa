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
  }
  if ( str2bool($::omsa::install_webserver)) {
    service {'dsm_om_connsvc':
      ensure  => running,
      require => Package['srvadmin-webserver']
    }
  }
}
