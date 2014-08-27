# Public: create & select profile the commandline
#
# Examples
#
#   # create & select foo
#   karabiner::profile { 'foo': }
#
define karabiner::profile(
  $index = 1
) {

  # create profile
  karabiner::exec { "karabiner::profile create ${name}":
    command => "append ${name}"
  }

  # select profile
  karabiner::exec { "karabiner::profile select ${name}":
    command      => "select_by_name ${name}",
    unless       => $index,
    exec_require => "append ${name}"
  }
}
