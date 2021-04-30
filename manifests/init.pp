node default {
  include lamp::apache
  include lamp::mysql
  include lamp::php
  include grafana_stack::grafana
  include influxdb
  include grafana_stack::telegraf
}
