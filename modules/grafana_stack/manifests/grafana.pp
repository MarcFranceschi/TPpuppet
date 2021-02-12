# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include grafana::grafana
class grafana_stack::grafana {
  class { 'grafana':
      cfg => {
        app_mode => 'production',
        server   => {
          http_port     => 8080,
        },
        database => {
          type     => 'mysql',
          host     => '127.0.0.1:3306',
          name     => 'grafana',
          user     => 'root',
          password => 'U3pkBDQf2',
        },
        users    => {
          allow_sign_up => false,
        },
      },
    }
}
