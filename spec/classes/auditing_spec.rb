require 'spec_helper'

describe 'toughen::auditing' do

    context 'with unsupported OS family' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with unsupported OS' do
        let (:facts) do { :osfamily => 'debian', :operatingsystem => 'Ubuntu' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with unsupported OS maj release' do
        let (:facts) do { :operatingsystemmajrelease => '5' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with supported version' do
        let(:facts) do { :privileged_commands => '/usr/bin/fakebin1,/usr/bin/fakebin2' } end
        it { should compile }
        it { should contain_kernel_parameter('audit') }
        it { should contain_auditd__rule("-a always,exit -F path=/usr/bin/fakebin1 -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged") }
    end

end
