require 'spec_helper'

# CENTOS6: 7.1.1, 7.1.2, 7.1.3
# UBUNTU: 10.1.1, 10.1.2, 10.1.3

describe file('/etc/login.defs') do
  its(:content) { should match /PASS_MAX_DAYS   60/ }
end