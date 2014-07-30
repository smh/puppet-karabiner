require 'spec_helper'

describe 'karabiner' do
  let(:version) { '10.1.0' }

  it do
    should contain_class('karabiner::config')

    should contain_package("Karabiner_#{version}").with({
      :ensure   => 'installed',
      :source   => "https://pqrs.org/osx/karabiner/files/Karabiner-#{version}.dmg",
      :provider => 'pkgdmg'
    })
  end
end
