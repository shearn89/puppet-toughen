require 'spec_helper'

describe 'toughen::modprobe' do
  context 'with custom blacklist name' do
    let (:params) do { :blacklist_confname => 'testing' } end
    it { should contain_file('/etc/modprobe.d/testing.conf') }
  end

  context 'with default parameters' do
    it { should contain_file('/etc/modprobe.d/CIS.conf') }
  end
end
