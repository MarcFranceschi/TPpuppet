# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include grafana_stack::influxdb
class grafana_stack::influxdb {
  class {'influxdb::server':
  meta_bind_address      => "${::fqdn}:8088",
  meta_http_bind_address => "${::fqdn}:8091",
  http_bind_address      => "${::fqdn}:8086",
  graphite_options       => {
    enabled           => true,
    database          => graphite,
    bind-address      => ':2003',
    protocol          => tcp,
    consistency-level => 'one',
    name-separator    => '.',
    batch-size        => 1000,
    batch-pending     => 5,
    batch-timeout     => '1s',
    udp-read-buffer   => 0,
    name-schema       => 'type.host.measurement.device',
    templates         => [ "*.app env.service.resource.measurement" ],
    tags              => [ "region=us-east", "zone=1c"],
    },
  }
}
