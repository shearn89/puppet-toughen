require 'spec_helper'

describe 'toughen::sssd' do

  context 'with invalid params' do
    let (:params) do { :memcache_timeout => 'invalid' } end
    it { expect { should raise_error(Puppet::Error) } }
    let (:params) do { :offline_cred_expiry => 'invalid' } end
    it { expect { should raise_error(Puppet::Error) } }
    let (:params) do { :known_hosts_timeout => 'invalid' } end
    it { expect { should raise_error(Puppet::Error) } }
    let (:params) do { :touch_config => 'invalid' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

  context 'with default params' do
    it { should compile }
    it { should contain_package('sssd') }
    it { should contain_service('sssd').with(:ensure => 'running') }
    it { should contain_augeas('sssd-security').with(
      :context => '/files/etc/sssd/sssd.conf/nss',
      :changes => [ 'set memcache_timeout 86400',
                    'set offline_credentials_expiration 1',
                    'set ssh_known_hosts_timeout 86400' ]
    ) }
    it { should contain_file('/etc/sssd/sssd.conf') }
  end

  context 'with touch_config false' do
    let (:params) do { :touch_config => false } end
    it { should_not contain_file('/etc/sssd/sssd.conf') }
  end

end
