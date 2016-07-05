require 'codeclimate-test-reporter'
require 'puppetlabs_spec_helper/module_spec_helper'

SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter.new([
        SimpleCov::Formatter::HTMLFormatter,
        CodeClimate::TestReporter::Formatter
    ])
end

RSpec.configure do |c|
    c.default_facts = {
        :operatingsystem => 'CentOS',
        :operatingsystemmajrelease => '7',
        :kernel => 'Linux'
    }
end
