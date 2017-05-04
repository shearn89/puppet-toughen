require 'spec_helper'

describe 'toughen::services' do

    context 'with supported OS' do
        let (:facts) do { :osfamily => 'redhat' } end
        it { should { 
	    contain_package('dhcp').with({ :ensure => 'absent' })
	    contain_service('sendmail').with({ :ensure => 'running' })
	} }
    end

    context 'with unsupported OS' do
        let (:facts) do { :osfamily => 'darwin' } end
        it { expect { should raise_error(Puppet::Error) } }
    end

  
    context 'with x_disabled false' do
	let (:params) do { :x_disabled => false } end
	it { should_not { contain_package('xorg-x11*') } }
    end
  
    context 'with avahi_disabled false' do
	let (:params) do { :avahi_disabled => false } end
	it { should_not { contain_service('avahi-daemon') } }
    end
  
    context 'with cups_disabled false' do
	let (:params) do { :cups_disabled => false } end
	it { should_not { contain_service('cups') } }
    end
  
    context 'with dhcp_disabled false' do
	let (:params) do { :dhcp_disabled => false } end
	it { should_not { contain_package('dhcp') } }
    end
  
    context 'with ldap_disabled false' do
	let (:params) do { :ldap_disabled => false } end
	it { should_not { contain_package('openldap-servers') } }
    end
  
    context 'with nfs_disabled false' do
	let (:params) do { :nfs_disabled => false } end
	it { should_not { contain_package('nfs-ganesha*') } }
    end
  
    context 'with rpc_disabled false' do
	let (:params) do { :rpc_disabled => false } end
	it { should_not { contain_package('rpcbind') } }
    end
  
    context 'with dns_disabled false' do
	let (:params) do { :dns_disabled => false } end
	it { should_not { contain_package('bind') } }
    end
  
    context 'with ftp_disabled false' do
	let (:params) do { :ftp_disabled => false } end
	it { should_not { contain_package('vsftpd') } }
    end
  
    context 'with http_disabled false' do
	let (:params) do { :http_disabled => false } end
	it { should_not { contain_package('httpd') } }
    end
  
    context 'with mail_disabled false' do
	let (:params) do { :mail_disabled => false } end
	it { should_not { contain_package('dovecot') } }
    end
  
    context 'with samba_disabled false' do
	let (:params) do { :samba_disabled => false } end
	it { should_not { contain_package('samba') } }
    end
  
    context 'with proxy_disabled false' do
	let (:params) do { :proxy_disabled => false } end
	it { should_not { contain_package('nginx') } }
    end
  
    context 'with snmp_disabled false' do
	let (:params) do { :snmp_disabled => false } end
	it { should_not { contain_package('net-snmp') } }
    end
  
    context 'with mta_local false' do
	let (:params) do { :mta_local => false } end
	it { should_not { contain_service('postfix') } }
    end

    context 'with postfix and sendmail installed' do
	let (:params) do { :mta_local => true } end
	let (:facts) do { :postfix_installed => true, :sendmail_installed => true } end
	it { should { contain_service('postfix') and contain_service('sendmail') } }
    end

    context 'with rsync_disabled false' do
	let (:params) do { :rsync_disabled => false } end
	it { should_not { contain_service('rsyncd') } }
    end

end
