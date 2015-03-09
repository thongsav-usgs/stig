require 'spec_helper'

# CENTOS6: 4.1.3
# UBUNTU: 8.2.3

describe file('/etc/rsyslog.conf') do
  it { should be_file }
end