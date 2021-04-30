# InfluxDB

#### Table of Contents

1.  [Overview](#overview)
2.  [Module Description - What the module does and why it is useful](#module-description)
3.  [Installation](#installation)
4.  [Setup - The basics of getting started with influxdb](#setup)
5.  [Usage - Configuration options and additional functionality](#usage)
6.  [Reference - An under-the-hood peek at what the module is doing and how](#reference)
7.  [Limitations - OS compatibility, etc.](#limitations)
8.  [Development - Guide for contributing to the module](#development)
9.  [License](#License)

## Overview

This module manages InfluxDB installation.

[![Build Status](https://travis-ci.org/n1tr0g/golja-influxdb.png)](https://travis-ci.org/n1tr0g/golja-influxdb) [![Puppet Forge](http://img.shields.io/puppetforge/v/golja/influxdb.svg)](https://forge.puppetlabs.com/golja/influxdb)

## Module Description

The InfluxDB module manages both the installation and configuration of InfluxDB.
I am planning to extend it to allow management of InfluxDB resources,
such as databases, users, and privileges.

## Deprecation Warning

<<<<<<< HEAD
=======
Notes for version 5.0.0+:

This module was a refactor of the 4.x version to handle influxdb >= 1.x.
Due to the changes in influxdb 1.x, this module should now support
future change more easily due to thew way the configuration files are
now managed.

Highlights
==========

* The module layout out has changed significantly from previous versions.
* A new fact was added `influxdb_version`.
* The influxdb.conf.erb file was refactored.
* Added and fixed a lot of rspec puppet tests.
* Fixed all the beaker tests, they work now.
* This module now supports influxdb >= 1.x < 2.x
* Major change to the original class parameters now hashes vs individual items.


Notes for version 4.0.0+:

influxdb 1.0.0 contains [breaking changes](https://github.com/influxdata/influxdb/blob/master/CHANGELOG.md#v100-2016-09-08)
which require changing the `data_logging_enabled` config attribute to `trace_logging_enabled`.
The other configuration changes are managed by the `influxdb.conf.erb` template already.

Notes for versions older than 3.1.1:

>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09
This release is a major refactoring of the module which means that the API
changed in backwards incompatible ways. If your project depends on the old API
and you need to use influxdb prior to 0.9.X, please pin your module
dependencies to 0.1.2 version to ensure your environments don't break.

*NOTE*: Until 1.0.0 release the API may change,
however I will try my best to avoid it.

## Installation

`puppet module install golja/influxdb`

## Setup

### What InfluxDB affects

*   InfluxDB packages
*   InfluxDB configuration files
*   InfluxDB service

### Beginning with InfluxDB

If you just want a server installed with the default options you can
run include `'::influxdb'`.

## Usage

All interaction for the server is done via `influxdb::server`.

Install influxdb

```puppet
class {'influxdb':}
```

<<<<<<< HEAD
Enable Graphite plugin

```puppet
class {'influxdb::server':
  graphite_enabled => true,
  graphite_tags    => ['region=us-east', 'zone=1c'],
=======
```puppet

# These are defaults, but demonstrates how you can change sections of data
$global_config => {
  'bind-address'       => ':8088',
  'reporting-disabled' => false,
}

class {'influxdb':
  global_config  => $global_config,
  manage_repos   => true,
  manage_service => true,
  version        => '1.2.0',
}
```

Enable Graphite plugin with one database

```puppet

# Most of these will be defaults, unless otherwise noted.
$graphite_config = {
  'default' => {
    'enabled'           => true, # not default
    'database'          => "graphite",
    'retention-policy'  => '',
    'bind-address'      => ':2003',
    'protocol'          => 'tcp',
    'consistency-level' => 'one',
    'batch-size'        => 5000,
    'batch-pending'     => 10,
    'batch-timeout'     => '1s',
    'udp-read-buffer'   => 0,
    'separator'         => '.',
    'tags'              => [ "region=us-east", "zone=1c"],
    'templates'         => [ "*.app env.service.resource.measurement" ],
  }
}

class { 'influxdb':
  manage_repos    => true,
  graphite_config => $graphite_config,
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09
}
```

Enable Collectd plugin

```puppet
<<<<<<< HEAD
class {'influxdb::server':
  collectd_enabled      => true,
  collectd_bind_address => ':2004',
  collectd_database     => 'collectd',
=======

# most of these are defaults, unless otherwise noted
$collectd_config = {
  'default' => {
    'enabled'          => true, # not default
    'bind-address'     => ':25826',
    'database'         => 'collectd',
    'retention-policy' => '',
    'typesdb'          => '/usr/share/collectd/types.db',
    'batch-size'       => 5000,
    'batch-pending'    => 10,
    'batch-timeout'    => '10s',
    'read-buffer'      => 0,
  }
}

class {'influxdb':
  manage_repos    => true,
  collectd_config => $collectd_config,
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09
}
```

Enable UDP listener

```puppet
<<<<<<< HEAD
$udp_options = [
    { 'enabled'       => true,
      'bind-address'  => '":8089"',
      'database'      => '"udp_db1"',
      'batch-size'    => 10000,
      'batch-timeout' => '"1s"',
      'batch-pending' => 5,
    },
    { 'enabled'       => true,
      'bind-address'  => '":8090"',
      'database'      => '"udp_db2"',
      'batch-size'    => 10000,
      'batch-timeout' => '"1s"',
      'batch-pending' => 5,
    },
]

class {'influxdb::server':
	reporting_disabled    => true,
	http_auth_enabled     => true,
	version               => '0.9.4.2',
	shard_writer_timeout  => '10s',
	cluster_write_timeout => '10s',
	udp_options           => $udp_options,
}
```

=======


# most of these are defaults unless otherwise noted.
$udp_config = {
  'default' => {
    'enabled'          => true, # not default
    'bind-address'     => ':8089',
    'database'         => 'udp',
    'retention-policy' => '',
    'batch-size'       => 5000,
    'batch-pending'    => 10,
    'batch-timeout'    => '1s',
    'read-buffer'      => 0,
  }
}

class {'influxdb':
  manage_repos => true,
  udp_config   => $udp_config
}
```

Enable opentsdb

```puppet

# most of these are defaults unless otherwise noted
$opentsdb_config = {
  'default' => {
    'enabled'           => true, # not default
    'bind-address'      => ':4242',
    'database'          => 'opentsdb',
    'retention-policy'  => '',
    'consistency-level' => 'one',
    'tls-enabled'       => false,
    'certificate'       => '/etc/ssl/influxdb.pem',
    'log-point-errors'  => true,
    'batch-size'        => 1000,
    'batch-pending'     => 5,
    'batch-timeout'     => '1s'
  }
}


class {'influxdb':
  manage_repos    => true,
  opentsdb_config => $opentsdb_config,
}
```
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

## Reference

### Classes

#### Public classes

*   `influxdb`: Installs and configures InfluxDB.

#### Private classes

*   `influxdb::install`: Installs packages.
*   `influxdb::config`: Configures InfluxDB.
*   `influxdb::repo`: Manages install repo.
*   `influxdb::service`: Manages service.

### Parameters

#### influxdb

##### `ensure`

Allows you to install or remove InfluxDB. Can be 'present' or 'absent'.

##### `version`

Version of InfluxDB.
Default: installed

*NOTE*: installed (will install the latest version if the package repo if not already installed).
        It is highly recommended that you manage this param with a specific version.

##### `config_file`

Path to the config file.
Default: /etc/influxdb/influxdb.conf

##### `conf_template`

The path to the template file that puppet uses to generate the influxdb.conf
Default: influxdb/influxdb.conf.erb

##### `startup_conf_template`

The path to the template file that puppet uses to generate the start config.
Default: influxdb/influxdb_default.erb

<<<<<<< HEAD
##### `hostname`

Server hostname used for clustering.
Default: undef

##### `bind_address`

This setting can be used to configure InfluxDB to bind to and listen for
connections from applications on this address.
If not specified, the module will use the default for your OS distro.
=======
##### `service_enabled`

Boolean to decide if the service should be enabled.
Default: true

##### `service_ensure`

String to decide if the service should be running|stopped.
Default: running

##### `manage_service`

Boolean to decide if the service should be managed with puppet or not.
Default: true
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

##### `manage_repos`

Boolean to decide if the package repos should be managed by puppet.
Default: false

##### `manage_install`

Boolean to decide if puppet should manage the install of packages.
Default: true

##### `influxdb_stderr_log`

Where influx will log stderr messages
Default: /var/log/influxdb/influxd.log


##### `influxdb_stdout_log`

Where influx will log stdout messages
Default: /var/log/influxdb/influxd.log


##### `influxd_opts`

String of startup config options that need to be present.
Default: undef

<<<<<<< HEAD
Wal dir for the storage engine 0.9.3+
Default: /var/opt/influxdb/wal
=======
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

##### `global_config`

<<<<<<< HEAD
Location of the meta dir
Default: /var/opt/influxdb/meta
=======
A hash of global configuration options for `influxdb.conf`
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs.

[Influx Global Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#global-options)

<<<<<<< HEAD
##### `wal_ready_series_size`

When a series in the WAL in-memory cache reaches this size in bytes it is
marked as ready to flush to the index.
NEW in 0.9.3+
Default: 25600

##### `wal_compaction_threshold`

Flush and compact a partition once this ratio of series are over the ready size.
NEW in 0.9.3+
Default: 0.6

##### `wal_max_series_size`

Force a flush and compaction if any series in a partition
gets above this size in bytes.
NEW in 0.9.3+
Default: 2097152

##### `wal_flush_cold_interval`

Force a flush of all series and full compaction if there have been
no writes in this amount of time.
This is useful for ensuring that shards that are cold for writes
don't keep a bunch of data cached in memory and in the WAL.
NEW in 0.9.3+
Default: 10m

##### `wal_partition_size_threshold`

Force a partition to flush its largest series if it reaches
this approximate size in bytes.
Remember there are 5 partitions so you'll need at least
5x this amount of memory. The more memory you have, the bigger this can be.
NEW in 0.9.3+Default: 20971520

##### `max_wal_size`

Maximum size the WAL can reach before a flush.
*DEPRECATED* since version 0.9.3.
Default: 100MB

##### `wal_flush_interval`

Maximum time data can sit in WAL before a flush.
*DEPRECATED* since version 0.9.3.
Default: 10m

##### `wal_partition_flush_delay`

The delay time between each WAL partition being flushed.
*DEPRECATED* since version 0.9.3.
Default: 2s

##### `shard_writer_timeout`
=======
[params.pp](manifests/params.pp#L21)
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09


##### `meta_config`

A hash of meta configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Meta Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#meta)

[params.pp](manifests/params.pp#26)


##### `data_config`

A hash of data configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Data Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#data)

[params.pp](manifests/params.pp#32)

##### `logging_config`

A hash of logging configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.5.x of the influx docs

[Influx Logging Options](https://docs.influxdata.com/influxdb/v1.5/administration/config/#logging-settings-logging)

[params.pp](manifests/params.pp#43)

##### `coordinator_config`

A hash of coordinator configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Coordinator Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#coordinator)

[params.pp](manifests/params.pp#45)


##### `retention_config`

A hash of retention configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Retention Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#retention)

[params.pp](manifests/params.pp#55)


##### `shard_precreation_config`

A hash of shard_precreation configuration options for `influxdb.conf`

<<<<<<< HEAD
##### `graphite_enabled`

Controls one or many listeners for Graphite data.
Default: false

##### `graphite_bind_address`

Default: :2003

##### `graphite_protocol`

Default: tcp

##### `graphite_consistency_level`

Default: one

##### `graphite_separator`

Default: .

##### `graphite_tags`

The "measurement" tag is special and the corresponding field
will become the name of the metric.
Default: \[undef\]

##### `graphite_templates`

Default: false

##### `graphite_ignore_unnamed`

If set to true, when the input metric name has more fields than `name-schema`
specified, the extra fields will be ignored.
Default: true

##### `collectd_enabled`

Controls the listener for collectd data.
Default: false

##### `collectd_bind_address`

Default: undef

##### `collectd_database`

Default: undef

##### `collectd_typesdb`

Default: undef

##### `opentsdb_enabled`

Controls the listener for OpenTSDB data.
Default: false

##### `opentsdb_bind_address`

Default: undef

##### `opentsdb_database`

Default: undef

##### `opentsdb_retention_policy`

Default: undef
=======
*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Shard Precreation Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#shard-precreation)

[params.pp](manifests/params.pp#60)


##### `monitor_config`

A hash of monitor configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Monitor Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#monitor)

[params.pp](manifests/params.pp#66)


##### `admin_config`

A hash of admin configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Admin Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#admin)

[params.pp](manifests/params.pp#74)

>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

##### `http_config`

A hash of http configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx HTTP Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#http)

[params.pp](manifests/params.pp#81)


<<<<<<< HEAD
##### `continuous_queries_enabled`
=======
##### `subscriber_config`

A hash of subscriber configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

[Influx Subscriber Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#subscriber)

<<<<<<< HEAD
##### `continuous_queries_recompute_previous_n`

Default: 2

##### `continuous_queries_recompute_no_older_than`

Default: 10m

##### `continuous_queries_compute_runs_per_interval`

Default: 10

##### `continuous_queries_compute_no_more_than`

Default: 2m
=======
[params.pp](manifests/params.pp#99)


##### `graphite_config`

A hash of graphite configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Graphite Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#graphite)
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

[params.pp](manifests/params.pp#108)


##### `collectd_config`

<<<<<<< HEAD
Default: OS specific
=======
A hash of collectd configuration options for `influxdb.conf`
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Collectd Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#collectd)

[params.pp](manifests/params.pp#126)


##### `opentsdb_config`

A hash of opentsdb configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Opentsdb Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#opentsdb)

[params.pp](manifests/params.pp#140)


##### `udp_config`

A hash of udp configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

[Influx Udp Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#udp)

<<<<<<< HEAD
##### `enable_snapshot`

Default: false

##### `influxdb_stderr_log`
=======
[params.pp](manifests/params.pp#156)
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09


##### `continuous_queries_config`

A hash of continuous queries configuration options for `influxdb.conf`

*NOTE*: The default for this hash is what is in 1.2.0 of the influx docs

<<<<<<< HEAD
enable/disable installation of the influxdb packages
Default: true
=======
[Influx Continuous Queries Options](https://docs.influxdata.com/influxdb/v1.2/administration/config/#continuous-queries)

[params.pp](manifests/params.pp#169)

>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09

##### `hinted_handoff_config`

This is depcreated as of influxdb >= 1.0
Default: {}

## Limitations

This module has been tested on:

*   Ubuntu 12.04
*   Ubuntu 14.04
*   CentOS 6/7

## Development

In order to better facilitate beaker testing, the Gemfile was modified to
support environment variables.  You must set this enviroment variable
before running `bundle exec *`.  The Gemfile will automatically set this
for you but you can also override it.
```
export BEAKER_VERSION=3.10.0 # assumes ruby >= 2.2.5
```

Please see CONTRIBUTING.md

### Todo

*   Add native types for managing users and databases
*   Add more rspec tests
*   Add beaker/rspec tests

## License

See LICENSE file
