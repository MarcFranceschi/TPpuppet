node default {

    Exec {
      path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
    }

    apache::vhost { 'agitated-blackwell.dgr.ovh':
        servername      => 'agitated-blackwell.dgr.ovh',
        port            => '80',
        docroot         => '/data/www/',
        redirect_status => 'permanent',
        redirect_dest   => 'https://188.165.89.60/graphs'
    }

    class { '::mysql::server':
        root_password => 'thepassword',
        restart       => true,
    }

    class { 'php':
        ensure       => 'present',
        manage_repos => false,
        fpm          => true,
        dev          => false,
        composer     => false,
        pear         => true,
        phpunit      => false,
        fpm_pools    => {},
    }

        Firewall {
            require => undef,
        }

    # Default firewall rules
        firewall { '000 accept ssh':
            proto  => 'ssh',
            action => 'accept',
        }
        firewall { '001 accept http':
            proto  => 'http',
            action => 'accept',
        }
        firewall { '002 accept https':
            proto  => 'https',
            action => 'accept',
        }
        firewall { '003 accept related established rules':
            proto  => 'all',
            state  => ['RELATED', 'ESTABLISHED'],
            action => 'accept',
        }

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
          password => '',
        },
        users    => {
          allow_sign_up => false,
        },
      },
    }

    class { 'influxdb' :}

    class { 'telegraf':
        hostname => $facts['s006858'],
        outputs  => {
            'influxdb' => [
                {
                'urls'     => [ "https://127.0.0.1" ],
                'database' => 'telegraf',
                'username' => 'telegraf',
                'password' => '',
                }
            ]
        },
    }
}
