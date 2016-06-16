require 'spec_helper'

describe 'toughen::updates' do

  let(:facts){ { :osfamily => 'redhat' } }

  context "with default parameters" do
    it {
      should contain_augeas('enable yum gpgcheck')
    }
  end

  context "with unsupported OS" do
      let :facts do
          {
              :osfamily => 'darwin'
          }
      end
      it {
          expect { should raise_error(Puppet::Error) }
      }
  end

  context "without gpgcheck" do
      let :params do
          {
              :use_gpg => false
          }
      end
      it {
        should_not contain_augeas('enable yum gpgcheck')
    }
  end


end
