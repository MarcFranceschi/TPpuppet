node default {
  include lamp::apache
  include lamp::mysql
  include lamp::php
  include autre::grafana
}
