# Public: set identifier to value
#
# identifier - the identifier to set. Defaults to title.
# value - the value to set.
#
# Examples
#
#   # set the parameter.keyoverlaidmodifier_timeout to 300
#   karabiner::set { 'parameter.keyoverlaidmodifier_timeout':
#     value => '300'
#   }
#
#   # explicitly specify the identifier
#   karabiner::set { 'foobar':
#     identifier => 'parameter.keyoverlaidmodifier_timeout',
#     value      => '300'
#   }
define karabiner::set(
  $value,
  $identifier = $title,
  $profile = 'Default'
) {

  karabiner::exec { "karabiner::set ${identifier} ${value}":
    command      => "set ${identifier} ${value}",
    unless       => "${identifier}=${value}",
    exec_require => "select_by_name ${profile}"
  }
}
