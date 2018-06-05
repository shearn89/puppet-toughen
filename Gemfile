source 'https://rubygems.org'

group :test do
    gem 'puppetlabs_spec_helper', :require => false
    gem 'simplecov', :require => false
    gem 'metadata-json-lint'
    gem 'rubocop'
end

ruby_version_segments = Gem::Version.new(RUBY_VERSION.dup).segments
minor_version = ruby_version_segments[0..1].join('.')

group :system_tests do
  gem "puppet-module-posix-system-r#{minor_version}",                            require: false, platforms: [:ruby]
  gem "beaker"
  gem "beaker-abs"
  gem "beaker-pe",                                                               require: false
  gem "beaker-hostgenerator"
  gem "beaker-rspec"
end

gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~>4'
gem 'puppet-blacksmith'
gem 'facter'
gem 'json'
gem 'semantic_puppet'
gem 'rake'
