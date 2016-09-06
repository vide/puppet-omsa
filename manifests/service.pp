class omsa::service() inherits omsa::params {

  service { $::omsa::service_name:
    ensure     => $::omsa::service_ensure,
    enable     => $::omsa::service_enable,
    hasstatus  => $::omsa::params::service_hasstatus,
    hasrestart => $::omsa::params::service_hasrestart,
  }
}
