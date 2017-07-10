
class { '::omsa':
  enable_snmp     => true,
  install_storage => true,
  force_install   => true,
  install_idrac7  => true,
}
