require 'spec_helper'

describe 'karabiner::enable' do
  let(:title) { 'foobar' }

  it do
    should contain_karabiner__exec('karabiner::enable foobar').
      with({ :command => "enable foobar" })
  end
end
