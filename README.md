# omsa

#### Table of Contents

1. [Description](#description)
1. [Usage](#usage)
  - [SNMP integration](#SNMP integration)
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
Be aware that until [this PR](https://github.com/razorsedge/puppet-snmp/pull/80) is not merged, you won't have StorageService OIDs enabled. Feel free to implement the patch in your `snmp` fork.

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
 Install components to manage the Dell Remote Access Card 4

 * `install_rac5`
 Install components to manage the Dell Remote Access Card 5

 * `enable_snmp`
 Enable SNMP integration by installing SNMP on the machine. Default: false

 * `force_install`
 Force OMSA installation even when $manufacturer is not Dell. Default: false

 * `install_idrac`
 Install the meta package-idrac package. Default: false
 
 * `install_idrac7`
 Install the meta package-idrac7 package. Default: false

 * `install_all`
 Install all srvadmin-packages available from the repository. Default: false


## Limitations

This module has been tested on real hardware by the author only on CentOS7, but
it should work with CentOS6 and RHEL6 and 7.
It has been tested in Vagrant with Ubuntu 14.04 LTS and it should work on bare metal with
Debian 7 and Debian 8 too, and Ubuntu 16.04 LTS.

## Development

If you find any bug (they are there for sure!) or if you have any new feature,
you are very warmly welcomed to submit an issue and if you can a PR. I promise
that I'll try to answer everything ASAP (I've been burnt by maintainers completely
ignoring bugs and PRs too, so I know how it is).

## Changelog

#### 0.2
- SNMP integration
- Start WS server when needed (thanks to @jschaeff)
- Make Vagrant testing easier

#### 0.1
- Initial release

