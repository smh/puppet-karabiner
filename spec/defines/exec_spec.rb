require 'spec_helper'

describe 'karabiner::exec' do
  let(:version) { '10.0.0' }
  cli = '/Applications/Karabiner.app/Contents/Library/bin/karabiner'

  context 'with defaults' do
    let(:title) { 'list' }

    it do
      should include_class('karabiner::config')

      should contain_exec('karabiner::exec list').with({
        :command => "#{cli} list",
        :require => "Exec[launch karabiner#{version}]"
      })
    end
  end

  context 'with command set to select 1' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'select 1'
      }
    end

    it do
      should contain_exec('karabiner::exec select 1').with({
        :command => "#{cli} select 1",
        :require => "Exec[launch karabiner#{version}]",
        :unless  => nil
      })
    end
  end

  context 'with unless set to select=1' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'select 1',
        :unless  => 'select=1'
      }
    end

    it do
      should contain_exec('karabiner::exec select 1').with({
        :command => "#{cli} select 1",
        :require => "Exec[launch karabiner#{version}]",
        :unless => "#{cli} changed | grep select=1"
      })
    end
  end

  context 'with onlyif set to select=1' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'select 1',
        :onlyif  => 'select=1'
      }
    end

    it do
      should contain_exec('karabiner::exec select 1').with({
        :command => "#{cli} select 1",
        :require => "Exec[launch karabiner#{version}]",
        :onlyif => "#{cli} changed | grep select=1"
      })
    end
  end
end
