# Class: omsa::params
# ===========================
#
# Internal class to manage params defaults
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
class omsa::params {

  $apt_key = {
    id     => '42550ABD1E80D7C1BC0BAD851285491434D8786F',
    server => 'hkp://ha.pool.sks-keyservers.net:80',
  }

  $service_name = 'dataeng'
  $service_enable = true
  $service_ensure = 'running'

  case $::osfamily {
    'Debian': {
      $service_hasstatus  = true
      $service_hasrestart = true
    }
    'RedHat': {
      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        # systemd
        $service_hasstatus  = true
        $service_hasrestart = true
      }
    }
    default: {
      $service_hasstatus  = true
      $service_hasrestart = true
    }
  }
}
