require 'spec_helper'

describe 'karabiner::exec' do
  let(:version) { '10.2.0' }
  cli = '/Applications/Karabiner.app/Contents/Library/bin/karabiner'

  context 'with command list' do
    let(:title) { 'list' }

    it do
      should contain_class('karabiner::config')

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
        :command => 'select 1',
        :exec_require => 'append foo'
      }
    end

    it do
      should contain_exec('karabiner::exec select 1').with({
        :command => "#{cli} select 1",
        :require => [ "Exec[launch karabiner#{version}]", "Exec[karabiner::exec append foo]" ],
        :unless  => "#{cli} selected | grep 1",
      })
    end
  end

  context 'with unless set to select_by_name foo' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'select_by_name foo',
        :unless  => 1,
      }
    end

    it do
      should contain_exec('karabiner::exec select_by_name foo').with({
        :command => "#{cli} select_by_name foo",
        :require => "Exec[launch karabiner#{version}]",
        :unless  => "#{cli} selected | grep 1"
      })
    end
  end

  context 'with command append' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'append foo',
      }
    end

    it do
      should contain_exec('karabiner::exec append foo').with({
        :command => "#{cli} append foo",
        :require => "Exec[launch karabiner#{version}]",
        :unless  => "#{cli} list | grep '^[0-9]*: foo$'"
      })
    end
  end

  context 'with command rename' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'rename 1 bar',
      }
    end

    it do
      should contain_exec('karabiner::exec rename 1 bar').with({
        :command => "#{cli} rename 1 bar",
        :require => "Exec[launch karabiner#{version}]",
        :unless  => "#{cli} list | grep '^1: bar$'"
      })
    end
  end

  context 'with command delete' do
    let(:title) { 'foobar' }
    let(:params) do
      {
        :command => 'delete 1',
      }
    end

    it do
      should contain_exec('karabiner::exec delete 1').with({
        :command => "#{cli} delete 1",
        :require => "Exec[launch karabiner#{version}]",
        :unless  => "#{cli} selected | grep -v 1"
      })
    end
  end
end
