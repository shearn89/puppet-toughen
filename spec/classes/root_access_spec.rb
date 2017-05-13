require 'spec_helper'

describe 'toughen::root_access' do

  context "with default parameters" do
    it { should contain_file('/etc/securetty') }
  end

end
