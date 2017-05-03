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
        let (:facts) do {
          :osfamily => 'redhat',
          :operatingsystem => 'CentOS',
          :operatingsystemmajrelease => '7',
          :privileged_commands => ['/usr/bin/fakebin'],
        } end
        it { should contain_kernel_parameter('audit') }
    end

end
