require 'spec_helper'

describe 'karabiner::set' do
  let(:title) { 'foobar' }
  let(:params) do
    { :value => 'xyz' }
  end

  it do
    should contain_karabiner__exec('karabiner::set foobar xyz').with({
      :command => "set foobar xyz",
      :unless  => "foobar=xyz",
      :exec_require => "select_by_name Default"
    })
  end

  context 'with identifier set to barfoo and value set to zyx' do
    let(:params) do
      { :identifier => 'barfoo', :value => 'zyx' }
    end

    it do
      should contain_karabiner__exec('karabiner::set barfoo zyx').with({
        :command => "set barfoo zyx",
        :unless  => "barfoo=zyx",
        :exec_require => "select_by_name Default"
      })
    end
  end

  context 'with identifier set to barfoo and value set to zyx and profile foobar' do
    let(:params) do
      { :identifier => 'barfoo', :value => 'zyx', :profile => 'foobar' }
    end

    it do
      should contain_karabiner__exec('karabiner::set barfoo zyx').with({
        :command => "set barfoo zyx",
        :unless  => "barfoo=zyx",
        :exec_require => "select_by_name foobar"
      })
    end
  end
end
