require 'spec_helper'

describe 'toughen::aide' do

  context "with default parameters" do
    it {
      should contain_cron('aide-check').with( { 'hour' => 5, 'minute' => 0 } )
    }
  end

  context "with package disabled" do
      let :params do
          {
              :package_ensure => 'absent'
          }
      end
      it {
          should_not contain_cron('aide-check')
      }
  end

  context "with custom cron parameters" do
      let :params do
          {
              :check_hour => 9,
              :check_minute => 7
          }
      end
      it {
        should contain_cron('aide-check').with( { 'hour' => 9, 'minute' => 7 } )
      }
  end

  context "with invalid check_hour" do
      let :params do
          {
              :check_hour => 'words'
          }
      end
      it {
          expect { should raise_error(Puppet::Error) }
      }
  end

  context "with invalid check_minute" do
      let :params do
          {
              :check_minute => 'words'
          }
      end
      it {
          expect { should raise_error(Puppet::Error) }
      }
  end

  context "with invalid package_ensure" do
      let :params do
          {
              :package_ensure => 'invalid'
          }
      end
      it {
          expect { should raise_error(Puppet::Error) }
      }
  end

end
