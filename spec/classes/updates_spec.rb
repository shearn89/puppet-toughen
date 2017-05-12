require 'spec_helper'

describe 'toughen::updates' do

  let(:facts){ { :osfamily => 'redhat' } }

  context "with default parameters" do
    it {
      should contain_augeas('enable yum gpgcheck')
    }
  end

  context "with unsupported OS" do
      let :facts do { :osfamily => 'darwin' } end
      it { expect { should raise_error(Puppet::Error) } }
  end

  context "without gpgcheck" do
      let :params do { :use_gpg => false } end
      it { should_not contain_augeas('enable yum gpgcheck') }
  end
  context "without clean_on_update" do
      let :params do { :clean_on_update => false } end
      it { should_not contain_augeas('clean pkgs on update') }
  end
  context "without local_gpgcheck" do
      let :params do { :local_gpgcheck => false } end
      it { should_not contain_augeas('check gpg for local pkgs') }
  end
  context "without repo_gpgcheck" do
      let :params do { :repo_gpgcheck => false } end
      it { should_not contain_augeas('check gpg for repo metadata') }
  end

  context "with invalid params" do
      let :params do { :use_gpg => 1 } end
      it { expect { should raise_error(Puppet::Error) } }
      let :params do { :clean_on_update => 1 } end
      it { expect { should raise_error(Puppet::Error) } }
      let :params do { :local_gpgcheck => 1 } end
      it { expect { should raise_error(Puppet::Error) } }
      let :params do { :repo_gpgcheck => 1 } end
      it { expect { should raise_error(Puppet::Error) } }
  end

end
