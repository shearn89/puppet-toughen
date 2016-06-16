require 'spec_helper'

describe 'toughen::sudo' do

    context 'with default params' do
        it {
            should contain_file('/etc/sudoers').with_content(/domain/)
        }
    end

    context 'with package absent' do
        let :params do { :package_ensure => 'absent' } end
        it { should_not contain_file('/etc/sudoers') }
    end

    context 'with specified safety_id' do
        let :params do { :safety_id => 'wildbill' } end
        it { should contain_file('/etc/sudoers').with_content(/wildbill/) }
    end

    context 'with invalid package_ensure' do
        let :params do { :package_ensure => 'invalid' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

    context 'with invalid safety_id' do
        let :params do { :safety_id => 66 } end
        it { expect { should raise_error(Puppet::Error) } }
    end
end
