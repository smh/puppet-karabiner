# configuration for karabiner
#
# $dmg_url - where to download the dmg
# $app - location of installed application
# $cli - location of command-line interface to the application
# $private_xml_path - location of private.xml
class karabiner::config {
  $version = '10.2.0'
  $base_url = 'https://pqrs.org/osx/karabiner/files'
  $dmg_url = "${base_url}/Karabiner-${version}.dmg"
  $app = '/Applications/Karabiner.app'
  $cli = "${app}/Contents/Library/bin/karabiner"
  $private_xml_dir = "/Users/${::boxen_user}/Library/Application Support/Karabiner"
  $private_xml_path = "/Users/${::boxen_user}/Library/Application Support/Karabiner/private.xml"
}
