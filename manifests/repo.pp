# Class: omsa::repos
# ===========================
#
# This class activate the needed Dell repositories to install OMSA
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
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
class omsa::repo() inherits omsa::params {

  Exec {
    path      => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd       => '/',
  }

  case $::osfamily {
    'Debian': {

      include ::apt

      apt::source { 'dell-system-update':
        location    => 'deb http://linux.dell.com/repo/community/ubuntu',
        release     => $::lsbdistcodename,
        repos       => 'openmanage',
        key         => $::omsa::apt_key,
        include_src => false,
      }
    }
    'RedHat': {

      yumrepo { 'dsu-system-independent':
        descr    => 'dell-system-update_independent',
        baseurl  => 'http://linux.dell.com/repo/hardware/dsu/os_independent/',
        gpgcheck => 1,
        gpgkey   => 'http://linux.dell.com/repo/hardware/dsu/public.key',
        enabled  => 1,
        exclude  => 'dell-system-update*.i386',
      }

      yumrepo { 'dsu-system-dependent':
        descr    => 'dell-system-update_dependent',
        baseurl  => 'http://linux.dell.com/repo/hardware/dsu/mirrors.cgi?osname=el$releasever&basearch=$basearch&native=1',
        gpgcheck => 1,
        gpgkey   => 'http://linux.dell.com/repo/hardware/dsu/public.key',
        enabled  => 1,
      }
    }
    default: {
      fail('Operating system not (yet) supported by this OMSA module')
    }
  }
}
