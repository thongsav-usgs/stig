require 'spec_helper'

# CENTOS
if ['redhat', 'fedora', 'centos', 'rhel'].include?(host_inventory['platform'])
  
  # CENTOS 1.6.2
  describe command('sysctl kernel.exec-shield') do
    its(:stdout) { should match /kernel.exec-shield = 1/ }
  end
end

# UBUNTU
if ['debian','ubuntu'].include?(host_inventory['platform'])  
  # UBUNTU 7.3.3
  describe command('ip addr | grep inet6') do
    its(:stdout) { should match /^$/ }
  end
end

# CENTOS6 1.6.1
# UBUNTU 4.1
describe command('grep "hard core" /etc/security/limits.conf') do
  its(:stdout) { should match /\* hard core 0/ }
end
describe command('sysctl fs.suid_dumpable') do
  its(:stdout) { should match /fs.suid_dumpable = 0/ }
end

# CENTOS 1.6.3
# UBUNTU 4.3
describe command('sysctl kernel.randomize_va_space') do
  its(:stdout) { should match /kernel.randomize_va_space = 2/ }
end

# CENTOS 5.1.1
# UBUNTU 7.1.1
describe command('/sbin/sysctl net.ipv4.ip_forward') do
  its(:stdout) { should match /net.ipv4.ip_forward = 0/ }
end

# CENTOS 5.1.2
# UBUNTU 7.1.2
describe command('/sbin/sysctl net.ipv4.conf.all.send_redirects') do
  its(:stdout) { should match /net.ipv4.conf.all.send_redirects = 0/ }
end
describe command('/sbin/sysctl net.ipv4.conf.default.send_redirects') do
  its(:stdout) { should match /net.ipv4.conf.default.send_redirects = 0/ }
end

# CENTOS6 5.2.2
# UBUNTU 7.2.2
describe command('/sbin/sysctl net.ipv4.conf.all.accept_redirects') do
  its(:stdout) { should match /net.ipv4.conf.all.accept_redirects = 0/ }
end
describe command('/sbin/sysctl net.ipv4.conf.default.accept_redirects') do
  its(:stdout) { should match /net.ipv4.conf.default.accept_redirects = 0/ }
end

# CENTOS6 5.2.3
# UBUNTU 7.2.3
describe command('/sbin/sysctl net.ipv4.conf.all.secure_redirects') do
  its(:stdout) { should match /net.ipv4.conf.all.secure_redirects = 0/ }
end
describe command('/sbin/sysctl net.ipv4.conf.default.secure_redirects') do
  its(:stdout) { should match /net.ipv4.conf.default.secure_redirects = 0/ }
end

# CENTOS6 5.2.4
# UBUNTU 7.2.4
describe command('/sbin/sysctl net.ipv4.conf.all.log_martians') do
  its(:stdout) { should match /net.ipv4.conf.all.log_martians = 1/ }
end
describe command('/sbin/sysctl net.ipv4.conf.default.log_martians') do
  its(:stdout) { should match /net.ipv4.conf.default.log_martians = 1/ }
end

# CENTOS6 5.2.7
# UBUNTU 7.2.7
describe command('/sbin/sysctl net.ipv4.conf.all.rp_filter') do
  its(:stdout) { should match /net.ipv4.conf.all.rp_filter = 1/ }
end
describe command('/sbin/sysctl net.ipv4.conf.default.rp_filter') do
  its(:stdout) { should match /net.ipv4.conf.default.rp_filter = 1/ }
end

# CENTOS6 5.4.1.1
# UBUNTU 7.3.1
describe command('/sbin/sysctl net.ipv6.conf.all.accept_ra') do
  its(:stdout) { should match /net.ipv6.conf.all.accept_ra = 0/ }
end
describe command('/sbin/sysctl net.ipv6.conf.default.accept_ra') do
  its(:stdout) { should match /net.ipv6.conf.default.accept_ra = 0/ }
end

# CENTOS6 5.4.1.2
# UBUNTU 7.3.2
describe command('/sbin/sysctl net.ipv6.conf.all.accept_redirects | tr -d "\n"') do
  its(:stdout) { should match /net.ipv6.conf.all.accept_redirects = 0/ }
end
describe command('/sbin/sysctl net.ipv6.conf.default.accept_redirects | tr -d "\n"') do
  its(:stdout) { should match /net.ipv6.conf.default.accept_redirects = 0/ }
end