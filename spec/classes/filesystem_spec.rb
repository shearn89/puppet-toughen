require 'spec_helper'

describe 'toughen::filesystem' do
  context 'with default parameters' do
    it { should contain_file('/tmp').with( { 'mode' => '1777'} ) }
  end

  context 'with custom tmp_options' do
    let (:params) do { :tmp_options => 'someoptions' } end
    it { should contain_mount('/tmp').with( { 'options' => 'someoptions' } ) }
  end

  context 'with custom ramdisk_options' do
    let (:params) do { :ramdisk_options => 'someoptions' } end
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
end
