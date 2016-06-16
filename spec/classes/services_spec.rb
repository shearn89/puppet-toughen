require 'spec_helper'

describe 'toughen::services' do

    context 'with supported OS' do
        let (:facts) do { :osfamily => 'redhat' } end
        it { should { contain_package('dhcpd').with({ :ensure => 'absent' }) } }
    end

    context 'with unsupported OS' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

end
