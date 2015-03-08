require 'spec_helper'

if ['debian','ubuntu'].include?(host_inventory['platform'])
  describe package('avahi-daemon') do
    it { should_not be_installed }
  end
end

if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  describe package('avahi') do
    it { should_not be_installed }
  end
end