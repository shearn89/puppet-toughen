require 'spec_helper'

describe 'toughen', :type => 'class' do

  context "On an unknown OS with no posture specified" do
    let :facts do
      {
        :osfamily => 'Darwin'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

end
