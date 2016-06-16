require 'spec_helper'

describe 'toughen::process' do

    context 'with redhat 6' do
        let (:facts) do { :osfamily => 'redhat', :operatingsystemmajversion => '6' } end
        it { should { contain_sysctl('kernel.exec-shield') } }
    end

    context 'without redhat 6' do
        let (:facts) do { :osfamily => 'redhat', :operatingsystemmajversion => '6' } end
        it { should_not { contain_sysctl('kernel.exec-shield') } }
    end
end
