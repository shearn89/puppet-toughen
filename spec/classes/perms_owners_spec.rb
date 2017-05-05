require 'spec_helper'

describe 'toughen::perms_owners' do

    context 'with supported OS' do
        let (:facts) do { :osfamily => 'redhat' } end
        it { should { contain_file('/etc/shadow').with({ :mode => '0000' }) } }
    end

end
