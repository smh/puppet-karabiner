require 'spec_helper'

describe 'karabiner::private_xml' do
  let(:title) { 'foobar' }
  let(:facts) do
    {
      :boxen_user => 'smh'
    }
  end

  it do
    should contain_class('karabiner::config')
  end

  context 'with source set to whatever' do
    let(:params) do
      {
        :source => 'whatever'
      }
    end

    it do
      should contain_file('/Users/smh/Library/Application Support/Karabiner/private.xml').with({
        :source => 'whatever'
      })
    end
  end

  context 'with content set to whatever' do
    let(:params) do
      {
        :content => 'whatever'
      }
    end

    it do
      should contain_file('/Users/smh/Library/Application Support/Karabiner/private.xml').with({
        :content => 'whatever'
      })
    end
  end
end

