# Public: enable identifier
#
# identifier - the identifier to enable. Defaults to title.
#
# Examples
#
#   # don't remap external keyboards
#   karabiner::enable { 'general.dont_remap_external': }
#
#   # explicitly specify the identifier
#   karabiner::enable { 'use dvorak, make your hands happy':
#     identifier => 'remap.qwerty2dvorak'
#   }
define karabiner::enable($identifier = $title)
{
  karabiner::exec { "karabiner::enable ${identifier}":
    command => "enable ${identifier}",
    unless  => "${identifier}=1"
  }
}
