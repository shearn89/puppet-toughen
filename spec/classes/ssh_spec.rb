require 'spec_helper'

describe 'toughen::ssh' do

    context 'with supported OS' do
        let (:facts) do { :osfamily => 'redhat' } end
        it { should { contain_service('sshd').with({ :ensure => 'running' }) } }
    end

    context 'with unsupported OS' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with non-default port' do
        let (:params) do { :port => '2222' } end
        it { should { contain_selinux__port('ssh_port').with({ :port => 2222}) } }
    end

end
