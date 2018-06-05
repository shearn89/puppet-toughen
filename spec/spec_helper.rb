require 'simplecov'
RSpec.configure do |c|
  c.mock_with :mocha
end

require 'puppetlabs_spec_helper/module_spec_helper'

SimpleCov.start do
  add_filter "/vendor/"
  add_filter "/spec/"
end

RSpec.configure do |c|
  c.default_facts = {
      :osfamily => 'redhat',
      :operatingsystem => 'CentOS',
      :operatingsystemrelease => '7',
      :operatingsystemmajrelease => '7',
      :operatingsystemminrelease => '5',
      :kernel => 'Linux'
  }
  # c.after(:suite) do
  #   RSpec::Puppet::Coverage.report!
  # end
end
