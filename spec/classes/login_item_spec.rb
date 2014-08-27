require 'spec_helper'

describe 'karabiner::login_item' do
  let(:version) { '10.2.0' }

  it do
    should contain_class('karabiner::config')
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

