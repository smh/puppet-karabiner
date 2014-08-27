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
define karabiner::exec(
  $command = $title,
  $unless = undef,
  $onlyif = undef,
  $exec_require = undef
) {

  require karabiner
  include karabiner::config

  $sub_command = $command ? {
    /^select [\d]+$/         => 'selected',
    /^select_by_name [\w]+$/ => 'selected',
    /^rename [\d]+ [\w]+$/   => 'list',
    /^append [\w]+$/         => 'list',
    /^delete [\d]+$/         => 'selected',
    default                  => 'changed'
  }

  $params = split($command, ' ')
  $unless_ = $command ? {
    /^select [\d]+$/       => $params[1],
    /^rename [\d]+ [\w]+$/ => "'^${params[1]}: ${params[2]}$'",
    /^append [\w]+$/       => "'^[0-9]*: ${params[1]}$'",
    /^delete [\d]+$/       => "-v ${params[1]}",
    default                => $unless
  }

  $unless_command = $unless_ ? {
    undef   => undef,
    default => "${karabiner::config::cli} ${sub_command} | grep ${unless_}"
  }

  $onlyif_ = $command ? {
    default => $onlyif
  }

  $onlyif_command = $onlyif_ ? {
    undef   => undef,
    default => "${karabiner::config::cli} ${sub_command} | grep ${onlyif_}"
  }

  exec { "karabiner::exec ${command}":
    command => "${karabiner::config::cli} ${command}",
    unless  => $unless_command,
    onlyif  => $onlyif_command
  }

  if $exec_require == undef {
    Exec["karabiner::exec ${command}"] {
      require +> Exec["launch karabiner${karabiner::config::version}"]
    }
  } else {
    Exec["karabiner::exec ${command}"] {
      require +> [
                  Exec["launch karabiner${karabiner::config::version}"],
                  Exec["karabiner::exec ${exec_require}"]
                  ]
    }
  }
}
