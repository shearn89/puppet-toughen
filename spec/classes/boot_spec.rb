require 'spec_helper'

describe 'toughen::boot' do

  let (:facts) { { :osfamily => 'redhat', :operatingsystemmajrelease => '7'  } }

  context 'with default parameters' do
    it { should contain_augeas('sysconfig-umask').with({:changes => 'set UMASK 027'}) }
  end

  context 'with custom umask' do
    let (:params) do { :umask => '666' } end
    it { should contain_augeas('sysconfig-umask').with({:changes => 'set UMASK 666'}) }
  end

  context 'with invalid osfamily' do
    let (:facts) do { :osfamily => 'darwin' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

  context 'with invalid osmajrelease' do
    let (:facts) do { :operatingsystemmajrelease => '5' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

  context 'with invalid umask' do
    let (:params) do { :umask => 'invalid' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

end
