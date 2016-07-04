require 'codeclimate-test-reporter'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.vendor/'
end

require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
    c.default_facts = {
        :operatingsystem => 'CentOS',
        :operatingsystemmajrelease => '7',
        :kernel => 'Linux'
    }
end
