require 'spec_helper'

#if ['redhat', 'fedora', 'centos'].include?(host_inventory['platform'])
  
# CentOS: 1.1.2
# Ubuntu: 2.2
# TODO- For /tmp partition CIS recommendations, I either have to make a 
# kickstart file and a golden AMI in order to pre-create a /tmp partition 
# since the official CentOS and Ubuntu images does not come with one 
#
#describe command('grep /tmp /etc/fstab | grep nodev') do
#  its(:stdout) { should match /\/tmp/ }
#end
#describe command('mount | grep /tmp | grep nodev') do
#  its(:stdout) { should match /\tmp/ }
#end 

# CentOS: 1.1.3
# Ubuntu: 2.3
#describe command('grep /tmp /etc/fstab | grep suid') do
#  its(:stdout) { should match /\/tmp/ }
#end
#describe command('mount | grep /tmp | grep suid') do
#  its(:stdout) { should match /\tmp/ }
#end 

# CentOS: 1.1.4
# Ubuntu: 2.4
#describe command('grep /tmp /etc/fstab | grep noexec') do
#  its(:stdout) { should match /\/tmp/ }
#end
#describe command('mount | grep /tmp | grep noexec') do
#  its(:stdout) { should match /\tmp/ }
#end 

# CentOS: 1.1.6
# Ubuntu: 2.6
#describe command('grep -e "^/tmp" /etc/fstab | grep /var/tmp') do
#  its(:stdout) { should match /\/tmp/ }
#end
#describe command('mount | grep -e "^/tmp" | grep /var/tmp') do
#  its(:stdout) { should match /\tmp/ }
#end 

if ['debian','ubuntu'].include?(host_inventory['platform'])
  # Ubuntu 2.14
  describe command('grep /run/shm /etc/fstab | grep nodev') do
    its(:stdout) { should match /nodev/ }
  end
  describe command("mount | grep /run/shm | grep nodev") do
    its(:stdout) { should match /nodev/ }
  end

  # Ubuntu 2.15
  describe command('grep /run/shm /etc/fstab | grep nosuid') do
    its(:stdout) { should match /nosuid/ }
  end
  describe command("mount | grep /run/shm | grep nosuid") do
    its(:stdout) { should match /nosuid/ }
  end

  # Ubuntu 2.16
  describe command('grep /run/shm /etc/fstab | grep noexec') do
    its(:stdout) { should match /noexec/ }
  end
  describe command("mount | grep /run/shm | grep noexec") do
    its(:stdout) { should match /noexec/ }
  end
end

if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  # Ubuntu 2.14
  describe command('grep /dev/shm /etc/fstab | grep nodev') do
    its(:stdout) { should match /nodev/ }
  end
  describe command("mount | grep /dev/shm | grep nodev") do
    its(:stdout) { should match /nodev/ }
  end

  # Ubuntu 2.15
  describe command('grep /dev/shm /etc/fstab | grep nosuid') do
    its(:stdout) { should match /nosuid/ }
  end
  describe command("mount | grep /dev/shm | grep nosuid") do
    its(:stdout) { should match /nosuid/ }
  end

  # Ubuntu 2.16
  describe command('grep /dev/shm /etc/fstab | grep noexec') do
    its(:stdout) { should match /noexec/ }
  end
  describe command("mount | grep /dev/shm | grep noexec") do
    its(:stdout) { should match /noexec/ }
  end
end