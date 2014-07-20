# Public: sets up Karabiner to launch on login
#
# Will add a login item and launch the application.
#
# Usage:
#
#   include karabiner::login_item
#
# or to remove login-item:
#
#   class { 'karabiner::login_item':
#     ensure => 'absent'
#   }
#
# Parameters:
#
#   ensure - 'present' or 'absent'. Defaults to 'present'.
class karabiner::login_item(
  $ensure = 'present'
) {
  include karabiner::config

  osx_login_item { 'Karabiner':
    ensure  => $ensure,
    path    => $karabiner::config::app,
    require => Package["Karabiner_${karabiner::config::version}"]
  }

  exec { "launch karabiner${karabiner::config::version}":
    command     => "/usr/bin/open ${karabiner::config::app}",
    refreshonly => true,
    subscribe   => Package["Karabiner_${karabiner::config::version}"],
    require     => Osx_login_item['Karabiner']
  }
}

