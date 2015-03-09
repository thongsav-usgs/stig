require 'spec_helper'

# UBUNTU: 6.4 
if ['debian','ubuntu'].include?(host_inventory['platform'])
  describe command('initctl show-config isc-dhcp-server | grep start') do
    its(:stdout) { should_not match /start/ }
  end
  describe command("initctl show-config isc-dhcp-server6 | grep start ") do
    its(:stdout) { should_not match /start/ }
  end
end

# CENTOS6: 3.5
if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  describe package('dhcp') do
    it { should_not be_installed }
  end
end