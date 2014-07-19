# Public: Karabiner private.xml file
#
# content - the contents of the file
# source  - the source for the file
#
# either content or source must be specified.
define karabiner::private_xml(
  $content = undef,
  $source  = undef,
  $ensure  = 'present'
) {
  include karabiner::config

  file { $karabiner::config::private_xml_dir:
    ensure => 'directory'
  }

  file { $karabiner::config::private_xml_path:
    ensure  => $ensure,
    content => $content,
    source  => $source,
    require => File[$karabiner::config::private_xml_dir]
  }
}
