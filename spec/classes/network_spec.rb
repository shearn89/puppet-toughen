require 'spec_helper'

describe 'toughen::network' do

    context 'with supported OS' do
        let (:facts) do { :osfamily => 'redhat' } end
        it { should { contain_package('dhcpd').with({ :ensure => 'absent' }) } }
    end

    context 'with unsupported OS' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'on Centos 6' do
        let (:facts) do { :operatingsystemmajrelease => 6 } end
        it { should { contain_sysctl('kernel.exec-shield').with({ :value => '1'}) } }
    end

    context 'on Centos 7' do
        let (:facts) do { :operatingsystemmajrelease => 7 } end
        it { should_not { contain_sysctl('kernel.exec-shield').with({ :value => '1'}) } }
    end

    context 'with invalid bogus_messages parameter' do
        let (:params) do { :ignore_bogus_messages => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid send_redirects' do
        let (:params) do { :send_redirects => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid accept_source_route' do
        let (:params) do { :accept_source_route => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid accept_redirects' do
        let (:params) do { :accept_redirects => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid secure_redirects' do
        let (:params) do { :secure_redirects => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid log_martians' do
        let (:params) do { :log_martians => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid ignore_broadcasts' do
        let (:params) do { :ignore_broadcasts => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

end
