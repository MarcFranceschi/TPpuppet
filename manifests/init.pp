node default {
  include lamp::apache
  include lamp::mysql
  include lamp::php
  include grafana_stack::grafana
  include influxdb
  include grafana_stack::telegraf

  class my_fw::pre {
    Firewall {
      require => undef,
    }
    # Default firewall rules
      firewall { 'allow http https and ssh access':
      dport  => [80, 443, 22],
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
