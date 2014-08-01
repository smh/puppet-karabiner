# Public: Installs Karabiner
#
# Usage:
#
#   include karabiner
#
# Parameters:
#
#   launch_on_login - will automatically launch and login. Defaults to
#                     true. Set this to false if you want to avoid
#                     automatically launching.
class karabiner(
  $launch_on_login = true,
) {
  include karabiner::config

  package { "Karabiner_${karabiner::config::version}":
    ensure   => installed,
    source   => $karabiner::config::dmg_url,
    provider => 'pkgdmg'
  }


  $launch_on_login_ensure = $launch_on_login ? {
    true    => present,
    default => absent
  }

  class { 'karabiner::login_item':
    ensure => $launch_on_login_ensure
  }
}
