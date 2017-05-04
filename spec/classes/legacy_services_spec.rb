require 'spec_helper'

describe 'toughen::legacy_services' do

    context 'with default settings' do
        it { should { contain_package('telnet').with({ :ensure => 'absent' }) } }
    end
    
    context 'with xinet enabled' do
        let (:params) do { :xinetd_ensure => 'installed' } end
        it { should {
            contain_package('xinetd').with({ :ensure => 'installed' })
            contain_service('xinetd').with({ :ensure => 'running' })
            contain_file('/etc/xinetd.d/time-dgram').with({ :ensure => 'absent' })
        } }
    end

    context 'with invalid parameter for telnet' do
        let (:params) do { :telnet_ensure => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid parameter for xinetd' do
        let (:params) do { :xinetd_ensure => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end
end
