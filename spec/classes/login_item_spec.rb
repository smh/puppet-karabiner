require 'spec_helper'

describe 'karabiner::login_item' do
  let(:version) { '10.0.0' }

  it do
    should include_class('karabiner::config')

    should contain_exec("launch karabiner#{version}").with({
      :command     => '/usr/bin/open /Applications/Karabiner.app',
      :refreshonly => true,
      :subscribe   => "Package[Karabiner_#{version}]",
      :require     => 'Osx_login_item[Karabiner]'
    })
  end

  context 'with ensure defaulted' do
    it do
      should contain_osx_login_item('Karabiner').with({
        :ensure  => 'present',
        :path    => '/Applications/Karabiner.app',
        :require => "Package[Karabiner_#{version}]"
      })
    end
  end

  context 'with ensure set to present' do
    let(:params) do
      {
        :ensure => 'present'
      }
    end

    it do
      should contain_osx_login_item('Karabiner').with({
        :ensure  => 'present',
        :path    => '/Applications/Karabiner.app',
        :require => "Package[Karabiner_#{version}]"
      })
    end
  end

  context 'with ensure set to absent' do
    let(:params) do
      {
        :ensure => 'absent'
      }
    end

    it do
      should contain_osx_login_item('Karabiner').with({
        :ensure  => 'absent',
        :path    => '/Applications/Karabiner.app',
        :require => "Package[Karabiner_#{version}]"
      })
    end
  end
end

