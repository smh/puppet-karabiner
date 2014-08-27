require 'spec_helper'

describe 'karabiner::profile' do
  let(:title) { 'foobar' }

  it do
    should contain_karabiner__exec('karabiner::profile create foobar').with({
      :command => "append foobar",
    })
    should contain_karabiner__exec('karabiner::profile select foobar').with({
      :command      => "select_by_name foobar",
      :exec_require => "append foobar"
    })
  end
end
