# Public: enable or disable remap identifier.
#
# identifier - the identifier to remap. Defaults to title.
# ensure - `present`: enable, `absent`: disable. Defaults to `present`.
#
# Examples
#
#   # enable the controlL2controlL_escape parameter
#   karabiner::remap { 'controlL2controlL_escape': }
#
#   # disable the controlL2controlL_escape parameter
#   karabiner::remap { 'controlL2controlL_escape': }
#     ensure => 'absent'
#   }
#
#   # explicitly specify the parameter
#   karabiner::remap { 'foobar': }
#     identifier => 'controlL2controlL_escape'
#   }
define karabiner::remap(
  $identifier = $title,
  $ensure = 'present'
) {

  case $ensure {
    'present': { $enable = 'enable' }
    'absent': { $enable = 'disable' }
    default: {
      fail('Define[karabiner::remap]: invalid ensure value')
    }
  }

  $unless_enabled = $enable ? {
    'enable' => "remap.${identifier}=1",
    default  => undef
  }

  $onlyif_enabled = $enable ? {
    'disable' => "remap.${identifier}=1",
    default  => undef
  }

  karabiner::exec { "karabiner::remap::${enable} ${identifier}":
    command => "${enable} remap.${identifier}",
    unless  => $unless_enabled,
    onlyif  => $onlyif_enabled
  }
}
