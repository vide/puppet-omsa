# omsa

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

OMSA is the Dell OpenManage System Administrator and it's a useful tool
to check and configure your Dell HW  from within the operating system
This puppet module takes care of installing it from Dell's repos and
and creates a basic configuration

## Usage

The most easy way to install puppet-omsa is to simply include the main class:

```puppet
include ::omsa
```

This will install the basic package, the storage (RAID) module and the RAC5
module.

By default puppet-omsa enable external Dell's repositories (based on your OS),
but if you want you can disable this feature

```puppet
class { '::omsa':
  manage_repo => false,
}
```

## Reference

### `omsa` class

 * `apt_key`
  Hash containing the GPG key server and key id, as expected by
  Puppetlabs apt module. Useful only if `manage_repo` is true and if `$::osfamily`
  is Debian

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

## Limitations

This module has been tested on real hardware by the author only on CentOS7, but
it should work with CentOS6 and RHEL6 and 7.
It has been tested in Vagrant with Ubuntu 14.04 LTS and it should work on bare metal with
Debian 7 and Debian 8 too, and Ubuntu 16.04 LTS.

## Development

If you find any bug (they are there for sure!( or if you have any new feature,
you are very warmly welcomed to submit an issue and if you can a PR. I promise
that I'll try to answer everything ASAP (I've been burnt by maintainers completely
ignoring bugs and PRs too, so I know how it is).
