# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include lamp::mysql
class lamp::mysql {
  class { '::mysql::server':
  root_password           => 'U3pkBDQf2',
  remove_default_accounts => true,
  restart                 => true,
  }
}
