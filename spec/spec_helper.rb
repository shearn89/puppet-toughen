require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
    c.default_facts = {
        :operatingsystem => 'CentOS',
        :operatingsystemmajrelease => '7',
        :kernel => 'Linux'
    }
end
