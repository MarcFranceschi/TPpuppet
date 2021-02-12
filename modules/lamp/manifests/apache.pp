# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include lamp::apache
class lamp::apache {
  class { '::apache' :
      default_vhost => false,
  }
  apache::vhost { 'loving-raman.my-ni.fr':
  port    => '80',
  docroot => '/var/www',
  }
}
