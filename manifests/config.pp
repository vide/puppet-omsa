# Class: omsa::params
# ===========================
#
# Internal class to tweak OMSA configuration
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
class omsa::config(){

  if ( str2bool("${::omsa::install_storage}")) {
    if ( $::operatingsystem == 'CentOS' ) {
      # tune a ini file so "omreport storage" works with CentOS
      exec { 'storage INI file centos fix':
        path    => '/bin/:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
        cwd     => '/opt/dell/srvadmin/etc/srvadmin-storage/',
        command => 'sed -i "s/vil7=dsm_sm_psrvil/; vil7=dsm_sm_psrvil/g" stsvc.ini',
        unless  => 'grep -q "; vil7" stsvc.ini',
        notify  => Service[$::omsa::service_name],
      }
    }
  }
}
