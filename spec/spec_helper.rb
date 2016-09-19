require 'codeclimate-test-reporter'
require 'puppetlabs_spec_helper/module_spec_helper'

SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter.new([
        SimpleCov::Formatter::HTMLFormatter,
        CodeClimate::TestReporter::Formatter
    ])
    add_filter "/vendor/"
    add_filter "/spec/"
end

RSpec.configure do |c|
    c.default_facts = {
        :osfamily => 'redhat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '7',
        :operatingsystemmajrelease => '7',
        :operatingsystemminrelease => '2',
        :kernel => 'Linux'
    }
end
