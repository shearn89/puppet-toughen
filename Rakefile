require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'

if RUBY_VERSION >= '1.9'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp', 'vendor/**/*']

desc 'Validate manifests, templates, and ruby files'
task :validate do
  manifests = Dir['{manifests,spec/classes,spec/unit}/**/*.pp'].join(' ')
  sh "puppet parser validate --noop #{manifests}"
  rubyfiles = Dir['spec/**/*.rb', 'lib/**/*.rb'].select{ |a| !(a =~ /fixtures/)}.join(' ')
  sh "ruby -c #{rubyfiles}"
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

desc 'Run metadata_lint, lint, validate, and spec tests.'
task :test do
  [:metadata_lint, :lint, :validate, :spec].each do |test|
    Rake::Task[test].invoke
  end
end

task :default => [:test]
