
class { '::omsa':
  install_webserver => true,
  install_rac4      => true,
  enable_snmp       => true,
  install_storage   => true,
  force_install     => true,
  install_idrac7    => true,
}
