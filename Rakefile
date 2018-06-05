require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet_blacksmith/rake_tasks' if Bundler.rubygems.find_name('puppet-blacksmith').any?

PuppetLint.configuration.send('disable_relative')
# PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp', 'vendor/**/*']

desc 'Run lint, validate, and spec tests.'
task :test do
  [:lint, :validate, :spec].each do |test|
    Rake::Task[test].invoke
  end
end

task :default => [:test]
