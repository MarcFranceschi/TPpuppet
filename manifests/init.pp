node default {
  include lamp::apache
  include lamp::mysql
  include lamp::php
  include grafana_stack::grafana
  include influxdb
  include grafana_stack::telegraf

  #Firewall firewall rules
  firewall { '100 allow http and https access':
    dport  => [80, 443],
    proto  => 'tcp',
    action => 'accept',
  }
}
