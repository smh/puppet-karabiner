# Public: call the commandline
#
# command = the command to pass to the commandline. Defaults to the title.
#
# Examples
#
#   # set the repeat.wait parameter to 30
#   karabiner::exec { 'set repeat.wait 30': }
#
#   # don't execute unless repeat.wait is already set to 30
#   karabiner::exec { 'set repeat.wait 30':
#     unless => 'repeat.wait=30'
#   }
#
#   # explicitly specify the commandline
#   karabiner::exec { 'foobar':
#     command => 'enable remap.shiftL2commandL'
#   }
define karabiner::exec($command = $title, $unless = undef, $onlyif = undef) {
  include karabiner::config

  $unless_changed = $unless ? {
    undef   => undef,
    default => "${karabiner::config::cli} changed | grep ${unless}"
  }

  $onlyif_changed = $onlyif ? {
    undef   => undef,
    default => "${karabiner::config::cli} changed | grep ${onlyif}"
  }

  exec { "karabiner::exec ${command}":
    command => "${karabiner::config::cli} ${command}",
    require => Exec["launch karabiner${karabiner::config::version}"],
    unless  => $unless_changed,
    onlyif  => $onlyif_changed
  }
}
