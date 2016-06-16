require 'spec_helper'

describe 'toughen::mandatory_access' do

    let (:facts) { { :osfamily => 'redhat' } }

    context 'with default OS and params' do
        it {
            should contain_augeas('selinux-mode')
            should contain_augeas('selinux-policy')
            should contain_package('setroubleshoot')
            should contain_package('mcstrans')
        }
    end

    context 'with invalid mode' do
        let (:params) do { :mode => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid policy' do
        let (:params) do { :policy => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid setroubleshoot' do
        let (:params) do { :setroubleshoot_ensure => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid mcstrans' do
        let (:params) do { :mcstrans_ensure => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid OS family' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with mode set to permissive' do
        let (:params) do { :mode => 'permissive' } end
        it { should contain_augeas('selinux-mode').with({:changes => 'set SELINUX permissive'})
        }
    end

    context 'with policy set to multiuser' do
        let (:params) do { :policy => 'multiuser' } end
        it { should contain_augeas('selinux-policy').with({:changes => 'set SELINUXTYPE multiuser'}) }
    end

    context 'with setroubleshoot installed' do
        let (:params) do { :setroubleshoot_ensure => 'installed' } end
        it { should contain_package('setroubleshoot').with({:ensure => 'installed'}) }
    end

    context 'with mcstrans installed' do
        let (:params) do { :mcstrans_ensure => 'installed' } end
        it { should contain_package('mcstrans').with({:ensure => 'installed'}) }
    end
end
