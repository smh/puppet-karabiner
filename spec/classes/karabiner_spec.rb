require 'spec_helper'

describe 'karabiner' do
  let(:version) { '10.2.0' }

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

    should contain_class('karabiner::login_item').with({ :ensure => :present })
  end

  context 'with launch_on_login set to true' do
    let(:params) do
      { :launch_on_login => true }
    end
    it do
      should contain_class('karabiner::login_item').with({ :ensure => :present })
    end
  end

  context 'with launch_on_login set to false' do
    let(:params) do
      { :launch_on_login => false }
    end
    it do
      should contain_class('karabiner::login_item').with({ :ensure => :absent })
    end
  end
end
