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

  if ( str2bool("$::omsa::install_webserver")) {
    package { 'srvadmin-webserver':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( str2bool("$::omsa::install_rac4")) {
    package { 'srvadmin-rac4':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }

  if ( str2bool("$::omsa::install_rac5")) {
    package { 'srvadmin-rac5':
      ensure  => installed,
      require => Package['srvadmin-base'],
    }
  }
}
