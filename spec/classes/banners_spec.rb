require 'spec_helper'

describe 'toughen::banners' do
  
  context 'on supported OS' do
    let (:facts) do { :osfamily => 'redhat' } end
    it { should { contain_file('/etc/motd').with_contents(/W A R N i N G/) } }
  end

  context 'on unsupported OS' do
    let (:facts) do { :osfamily => 'debian' } end
    it { expect { should raise_error (Puppet::Error) } }
  end

end
