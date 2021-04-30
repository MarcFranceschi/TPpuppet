#
class influxdb::params {
<<<<<<< HEAD
  $version                                      = '0.9.4'
  $ensure                                       = 'present'
  $service_enabled                              = true
  $bind_address                                 = ':8088'
  $retention_autocreate                         = true
  $election_timeout                             = '1s'
  $heartbeat_timeout                            = '1s'
  $leader_lease_timeout                         = '500ms'
  $commit_timeout                               = '50ms'
  $data_dir                                     = '/var/opt/influxdb/data'
  $wal_dir                                      = '/var/opt/influxdb/wal'
  $meta_dir                                     = '/var/opt/influxdb/meta'
  $wal_enable_logging                           = true
  $wal_ready_series_size                        = 25600
  $wal_compaction_threshold                     = '0.6'
  $wal_max_series_size                          = 2097152
  $wal_flush_cold_interval                      = '10m'
  $wal_partition_size_threshold                 = 20971520
  $max_wal_size                                 = 104857600
  $wal_flush_interval                           = '10m'
  $wal_partition_flush_delay                    = '2s'
  $shard_writer_timeout                         = '5s'
  $cluster_write_timeout                        = '5s'
  $retention_enabled                            = true
  $retention_check_interval                     = '10m'
  $admin_enabled                                = true
  $admin_bind_address                           = ':8083'
  $admin_https_enabled                          = false
  $admin_https_certificate                      = '/etc/ssl/influxdb.pem'
  $http_enabled                                 = true
  $http_bind_address                            = ':8086'
  $http_auth_enabled                            = false
  $http_log_enabled                             = true
  $http_write_tracing                           = false
  $http_pprof_enabled                           = false
  $http_https_enabled                           = false
  $http_https_certificate                       = '/etc/ssl/influxdb.pem'
  $graphite_enabled                             = false
  $graphite_bind_address                        = ':2003'
  $graphite_protocol                            = 'tcp'
  $graphite_consistency_level                   = 'one'
  $graphite_separator                           = '.'
  $graphite_tags                                = []
  $graphite_templates                           = []
  $graphite_ignore_unnamed                      = true
  $collectd_enabled                             = false
  $collectd_bind_address                        = undef
  $collectd_database                            = undef
  $collectd_typesdb                             = undef
  $opentsdb_enabled                             = false
  $opentsdb_bind_address                        = undef
  $opentsdb_database                            = undef
  $opentsdb_retention_policy                    = undef
  $udp_options                                  = undef
  $monitoring_enabled                           = true
  $monitoring_write_interval                    = '24h'
  $continuous_queries_enabled                   = true
  $continuous_queries_recompute_previous_n      = 2
  $continuous_queries_recompute_no_older_than   = '10m'
  $continuous_queries_compute_runs_per_interval = 10
  $continuous_queries_compute_no_more_than      = '2m'
  $hinted_handoff_enabled                       = true
  $hinted_handoff_dir                           = '/var/opt/influxdb/hh'
  $hinted_handoff_max_size                      = 1073741824
  $hinted_handoff_max_age                       = '168h'
  $hinted_handoff_retry_rate_limit              = 0
  $hinted_handoff_retry_interval                = '1s'
  $reporting_disabled                           = false
  $conf_template                                = 'influxdb/influxdb.conf.erb'
  $config_file                                  = '/etc/opt/influxdb/influxdb.conf'
  $enable_snapshot                              = false
  $influxdb_stderr_log                          = '/var/log/influxdb/influxd.log'
  $influxdb_stdout_log                          = '/dev/null'
  $influxd_opts                                 = undef
  $manage_install                               = true

  case $::osfamily {
    'Debian': {
      $package_provider = 'dpkg'
      $package_source   = 'http://s3.amazonaws.com/influxdb/influxdb_'
      $influxdb_user    = 'influxdb'
      $influxdb_group   = 'influxdb'

      $package_suffix = $::architecture ? {
          /64/    => '_amd64.deb',
          default => '_i386.deb',
      }

      if $::operatingsystem == 'Ubuntu' {
        $service_provider = 'upstart'
      } else {
        $service_provider = undef
      }
=======
  $version               = 'installed'
  $ensure                = 'present'
  $service_enabled       = true
  $service_ensure        = 'running'
  $manage_service        = true

  $conf_template         = 'influxdb/influxdb.conf.erb'
  $startup_conf_template = 'influxdb/influxdb_default.erb'

  $config_file           = '/etc/influxdb/influxdb.conf'

  $influxdb_stderr_log   = '/var/log/influxdb/influxd.log'
  $influxdb_stdout_log   = '/var/log/influxdb/influxd.log'
  $influxd_opts          = undef
  $manage_install        = true

  $global_config = {
    'reporting-disabled' => true,
    'bind-address'       => ':8088',
  }

  $meta_config = {
    'dir'                  => '/var/lib/influxdb/meta',
    'retention-autocreate' => true,
    'logging-enabled'      => true,
  }

  $data_config = {
    'dir'                                => '/var/lib/influxdb/data',
    'wal-dir'                            => '/var/lib/influxdb/wal',
    'trace-logging-enabled'              => false,
    'query-log-enabled'                  => true,
    'cache-max-memory-size'              => 1048576000,
    'cache-snapshot-memory-size'         => 26214400,
    'cache-snapshot-write-cold-duration' => '10m',
    'compact-full-write-cold-duration'   => '4h',
    'max-series-per-database'            => 1000000,
    'max-values-per-tag'                 => 100000,
  }
  
  $logging_config = {
    'format'        => 'auto',
    'level'         => 'warn',
    'suppress-logo' => false,
  }

  $coordinator_config = {
    'write-timeout'          => '10s',
    'max-concurrent-queries' => 0,
    'query-timeout'          => '0s',
    'log-queries-after'      => '0s',
    'max-select-point'       => 0,
    'max-select-series'      => 0,
    'max-select-buckets'     => 0,
  }

  $retention_config = {
    'enabled'        => true,
    'check-interval' => '30m',
  }

  $shard_precreation_config = {
    'enabled'        => true,
    'check-interval' => '10m',
    'advance-period' => '30m',
  }

  $monitor_config = {
    'store-enabled'  => true,
    'store-database' => '_internal',
    'store-interval' => '10s',
  }

  # NOTE: As of Influx >= 1.2 the admin section is deprecated.
  # https://docs.influxdata.com/influxdb/v1.2/administration/config/#admin
  $admin_config = {
    'enabled'           => false,
    'bind-address'      => ':8083',
    'https-enabled'     => false,
    'https-certificate' => '/etc/ssl/influxdb.pem',
  }

  $http_config = {
    'enabled'              => true,
    'bind-address'         => ':8086',
    'auth-enabled'         => false,
    'realm'                => 'InfluxDB',
    'log-enabled'          => true,
    'write-tracing'        => false,
    'pprof-enabled'        => true,
    'https-enabled'        => false,
    'https-certificate'    => '/etc/ssl/influxdb.pem',
    'https-private-key'    => '',
    'shared-sercret'       => '',
    'max-row-limit'        => 0,
    'max-connection-limit' => 0,
    'unix-socket-enabled'  => false,
    'bind-socket'          => '/var/run/influxdb.sock',
  }

  $subscriber_config = {
    'enabled'              => true,
    'http-timeout'         => '30s',
    'insecure-skip-verify' => false,
    'ca-certs'             => '',
    'write-concurrency'    => 40,
    'write-buffer-size'    => 1000,
  }

  $graphite_config = {
    'default' => {
      'enabled'           => false,
      'database'          => 'graphite',
      'retention-policy'  => '',
      'bind-address'      => ':2003',
      'protocol'          => 'tcp',
      'consistency-level' => 'one',
      'batch-size'        => 5000,
      'batch-pending'     => 10,
      'batch-timeout'     => '1s',
      'udp-read-buffer'   => 0,
      'separator'         => '.',
      'tags'              => [],
      'templates'         => [],
    }
  }

  $collectd_config = {
    'default' => {
      'enabled'          => false,
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

  $opentsdb_config = {
    'default' => {
      'enabled'           => false,
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

  $udp_config = {
    'default' => {
      'enabled'          => false,
      'bind-address'     => ':8089',
      'database'         => 'udp',
      'retention-policy' => '',
      'batch-size'       => 5000,
      'batch-pending'    => 10,
      'batch-timeout'    => '1s',
      'read-buffer'      => 0,
    }
  }

  $continuous_queries_config = {
    'enabled'      => true,
    'log-enabled'  => true,
    'run-interval' => '1s',
  }

  # deprecated as of 1.x?
  $hinted_handoff_config = {}

  case $::osfamily {
    'Debian': {
      $startup_conf = '/etc/default/influxdb'
      $manage_repos = false
    }
    'RedHat': {
      $startup_conf = $::operatingsystemmajrelease ? {
        /7/     => '/etc/default/influxdb',
        default => '/etc/sysconfig/influxdb'
      }
      $manage_repos = false
    }
    'Archlinux': {
      $startup_conf = '/etc/default/influxdb'
      $manage_repos = false
>>>>>>> 891dd648f90a5ad265545c73d7abdd31770d7e09
    }
    'RedHat', 'Amazon': {
      $package_provider = 'rpm'
      $package_source = 'http://s3.amazonaws.com/influxdb/influxdb-'
      $influxdb_user    = 'influxdb'
      $influxdb_group   = 'influxdb'

      $package_suffix = $::architecture ? {
          /64/    => '-1.x86_64.rpm',
          default => '-1.i686.rpm',
        }
    }
  }
}
