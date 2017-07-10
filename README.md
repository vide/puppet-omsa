# omsa

## Table of Contents

1. [Description](#description)
1. [Usage](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [Changelog](#changelog)

## Description

OMSA is the Dell OpenManage System Administrator and it's a useful tool
to check and configure your Dell HW from within the operating system
This puppet module takes care of installing it from Dell's repos and
and creates a basic configuration

This module was sponsored by [Billy Mobile Performance Network](http://www.billymob.com/en/)
By the way, [we are hiring!](http://www.billymob.com/en/careers.html)

## Usage

The most easy way to install puppet-omsa is to simply include the main class:

```puppet
include ::omsa
```

This will install the basic package, the storage (RAID) module and the RAC5
module.

**NOTE**: if you are installing OMSA with a manual puppet run, you have to log out
and log in again to have `omreport` and `omconfig` executables in your path

By default puppet-omsa enable external Dell's repositories (based on your OS),
but if you want you can disable this feature

```puppet
class { '::omsa':
  manage_repo => false,
}
```

#### SNMP integration

SNMP integration, if you enable the `enable_snmp` flag, is done with [razorsedge-snmp Puppet module](https://forge.puppet.com/razorsedge/snmp), which takes care of installing snmpd in your machine.

To enable integration between OMSA and SNMP you have to change a couple of default parameters in the `snmp` module:
```yaml
snmp::openmanage_enable: true
snmp::views:
    - 'systemview included .1.3.6.1.2.1.1'
    - 'systemview included .1.3.6.1.2.1.25.1.1'
    # add Dell's OIDs to the default view
    - 'systemview included .1.3.6.1.4.1.674.10892'
    - 'systemview included .1.3.6.1.4.1.674.10893'
```

As a last note, you should know that if you want to customize the SNMP installation (read-only community, traps etc.), **you must use Hiera** because this `omsa` module does not support passing all the parameters down to the `snmp` module.

## Reference

### `omsa` class

 * `apt_key`
  Hash containing the GPG key server and key id, as expected by
  Puppetlabs apt module. Useful only if `manage_repo` is true and if `$::osfamily`
  is Debian. Defaults should be sane though.

 * `manage_repo`
  Let this module manage the repositories for Dell OMSA installation

 * `service_name`
 The service name used to start OMSA. Default: dataeng

 * `service_ensure`
 Controls whether the service should be running or not. Default: running

 * `service_enable`
 Controls whether the service should be enabled at boot. Default: enabled

 * `install_storage`
 If true, enable the "omreport storage" subset. Default: true

 * `install_webserver`
 If true, enable the OMSA local webserver

 * `install_rac4`
 Install components to manage the Dell Remote Access Card 4 (RedHat only)

 * `install_rac5`
 Install components to manage the Dell Remote Access Card 5 (RedHat only)

 * `enable_snmp`
 Enable SNMP integration by installing SNMP on the machine. Default: false

 * `force_install`
 Force OMSA installation even when $manufacturer is not Dell. Default: false

 * `install_idrac`
 Install the idrac meta package for iDRAC6. Default: false (RedHat only)
 
 * `install_idrac7`
 Install the idrac7 meta package for iDRAC7. Default: false

 * `install_idrac8`
 Install the idrac8 meta package for iDRAC8. Default: false (Debian only)

 * `install_all`
 Install all srvadmin-packages available from the repository. Default: false

## Limitations

**This module is for Puppet3!** It should work with Puppet>=4 but it forces
dependencies that are known to work well with Puppet3, since the author is 
still on Puppet3.

This module has been tested on real hardware by the author only on CentOS7, but
it should work with CentOS6 and RHEL6 and 7.
It has been tested in Vagrant with Ubuntu 14.04 LTS and it should work on bare metal with
Debian 7 and Debian 8 too, and Ubuntu 16.04 LTS.

Missing components on a distribution basis are not author's choiches, it's an
upstream packagement issue. Please complain to Dell :)

## Development

If you find any bug (they are there for sure!) or if you have any new feature,
you are very warmly welcomed to submit an issue and if you can a PR. I promise
that I'll try to answer everything ASAP (I've been burnt by maintainers completely
ignoring bugs and PRs too, so I know how it is).

#### Testing your changes

Install the needed gems with `bundle install` and check your code with:
- `bundle exec rake validate`
- `bundle exec rake lint` (don't worry about string containing only one 
variables warnings, they are due to the `str2bool()` use)

If you have Vagrant + VirtualBox installed, you can run a VM to test the code with:

```bash
$ librarian-puppet install
$ vagrant up centos|ubuntu|debian
```

#### Opening a PR

Please open the PR against the `development` branch, not against master. Thanks!

## Changelog

#### 0.4
- Add iDRAC8 packages under Debian, removed racadm packages always under Debian (fixes #4)
- Updated documentation and testing

#### 0.3
- Add iDRAC7 packages installation (thanks to @palsveningson)
- Add srvadmin-all package installation (thanks to @palsveningson)
- Slightly changed contribution workflow

#### 0.2
- SNMP integration
- Start WS server when needed (thanks to @jschaeff)
- Vagrant testing made easier

#### 0.1
- Initial release

