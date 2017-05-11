source 'https://rubygems.org'

group :test do
    gem 'puppetlabs_spec_helper', :require => false
    gem 'simplecov', :require => false
end

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 2.7']
gem 'puppet', puppetversion

gem 'facter'
gem 'metadata-json-lint'
gem 'rubocop'
gem 'json'
