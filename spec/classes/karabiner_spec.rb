require 'spec_helper'

describe 'karabiner' do
  let(:version) { '10.1.0' }

  it do
    should contain_class('karabiner::config')

    should contain_exec("launch karabiner#{version}").with({
      :command     => '/usr/bin/open /Applications/Karabiner.app',
      :refreshonly => true,
      :subscribe   => "Package[Karabiner_#{version}]"
    })

    should contain_package("Karabiner_#{version}").with({
      :ensure   => 'installed',
      :source   => "https://pqrs.org/osx/karabiner/files/Karabiner-#{version}.dmg",
      :provider => 'pkgdmg'
    })
  end
end
