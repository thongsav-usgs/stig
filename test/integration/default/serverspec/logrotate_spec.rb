require 'spec_helper'

# CENTOS6: 4.3
# UBUNTU: 8.4

describe file('/etc/logrotate.d/syslog') do
  it { should be_file }
  its(:content) { should match /\/var\/log\/cron/ }
  its(:content) { should match /\/var\/log\/maillog/ }
  its(:content) { should match /\/var\/log\/secure/ }
  its(:content) { should match /\/var\/log\/spooler/ }
  its(:content) { should match /\/var\/log\/boot.log/ }
end