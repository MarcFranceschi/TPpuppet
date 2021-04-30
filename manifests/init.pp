node default {
  include lamp::apache
  include lamp::mysql
  include lamp::php
  include grafana_stack::grafana
  include influxdb
  include grafana_stack::telegraf

  #Firewall firewall rules
  firewall {'Allow http https and ssh':
    dport  => [80, 443, 22],
    proto  => 'tcp',
    action => 'accept',
  }
}
