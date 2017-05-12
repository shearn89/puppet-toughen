require 'spec_helper'

describe 'toughen::filesystem' do
  context 'with default parameters' do
    it { 
      should contain_file('/tmp').with( { 'mode' => '1777'} )
      should contain_kernel_parameter('nousb')
      should contain_sysctl('kernel.dmesg_restrict')
    }
  end

  context 'with custom tmp_options' do
    let (:params) do { :tmp_options => 'someoptions' } end
    it { should contain_mount('/tmp').with( { 'options' => 'someoptions' } ) }
  end

  context 'with ramdisk and custom ramdisk_options' do
    let (:params) do { :ramdisk_present => true, :ramdisk_options => 'someoptions' } end
    it { should contain_mount('/dev/shm').with( { 'options' => 'someoptions' } ) }
  end

  context 'with custom tmp_mode' do
    let (:params) do { :tmp_mode => '6666' } end
    it { should contain_file('/tmp').with( { 'mode' => '6666' } ) }
  end

  context 'with invalid tmp_options' do
    let (:params) do { :tmp_options => 'not options' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

  context 'with invalid ramdisk_options' do
    let (:params) do { :ramdisk_options => 'not options' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

  context 'with invalid tmp_mode' do
    let (:params) do { :tmp_mode => 'invalid' } end
    it { expect { should raise_error(Puppet::Error) } }
  end

  context 'without usb disabled' do
    let (:params) do { :usb_disabled => false } end
    it { should_not contain_kernel_parameter('nousb') }
  end

  context 'without dmesg disabled' do
    let (:params) do { :restrict_dmesg => false } end
    it { should_not contain_sysctl('kernel.dmesg_restrict') }
  end
end
