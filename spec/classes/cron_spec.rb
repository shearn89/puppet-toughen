require 'spec_helper'

describe 'toughen::cron' do

    context 'with default params' do
        it { should contain_file('/etc/cron.allow').with_content(/^root$/) }
    end

    context 'with additional users' do
	    let :params do { :allow_users => ['root','test'] } end
        it { should contain_file('/etc/cron.allow').with_content(/^test$/) }
    end

end
