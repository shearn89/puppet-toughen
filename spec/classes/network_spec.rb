require 'spec_helper'

describe 'toughen::network' do

    context 'with unsupported OS' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'on Centos 6' do
        let (:facts) do { :operatingsystemmajrelease => 6 } end
        it { should compile }
    end

    context 'on Centos 7' do
        let (:facts) do { :operatingsystemmajrelease => 7 } end
        it { should compile }
    end

    context 'with invalid parameters' do
        let (:params) do { :ignore_bogus_messages => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :send_redirects => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :accept_source_route => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :accept_redirects => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :secure_redirects => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :log_martians => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :ignore_broadcasts => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :use_syncookies => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :ip_forward => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
        let (:params) do { :disable_ipv6 => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

end
