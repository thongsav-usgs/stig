require 'spec_helper'

# CENTOS6: 6.3.4
# UBUNTU: 9.2.3

if ['debian','ubuntu'].include?(host_inventory['platform'])
  describe file('/etc/pam.d/common-password') do
    its(:content) { should match /remember=[0-9]+/ }
  end
end

if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  describe file('/etc/pam.d/system-auth') do
    its(:content) { should match /remember=[0-9]+/ }
  end
end