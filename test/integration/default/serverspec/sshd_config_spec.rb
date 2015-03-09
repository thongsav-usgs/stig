require 'spec_helper'

# CENTOS6: 6.2.2, 6.2.3, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.2.9, 6.2.10, 6.2.13, 6.2.14
# UBUNTU: 9.3.1, 9.3.2, 9.3.5, 9.3.3, 9.3.6, 9.3.7, 9.3.8, 9.3.9, 9.3.10, 9.3.13, 9.3.14

# CENTOS6: 6.2.2
# UBUNTU: 9.3.1
describe command('grep "^Protocol" /etc/ssh/sshd_config') do
  its(:stdout) { should match /Protocol 2/ }
end

# CENTOS6: 6.2.3
# UBUNTU: 9.3.2
describe command('grep "^LogLevel" /etc/ssh/sshd_config') do
  its(:stdout) { should match /LogLevel INFO/ }
end

# CENTOS: 6.2.5
# UBUNTU: 9.3.5
describe command('grep "^MaxAuthTries" /etc/ssh/sshd_config') do
  its(:stdout) { should match /MaxAuthTries [1-4]/ }
end

# CENTOS: 6.2.6
# UBUNTU: 9.3.6
describe command('grep "^IgnoreRhosts" /etc/ssh/sshd_config') do
  its(:stdout) { should match /IgnoreRhosts yes/ }
end

# CENTOS: 6.2.7
# UBUNTU: 9.3.7
describe command('grep "^HostbasedAuthentication" /etc/ssh/sshd_config') do
  its(:stdout) { should match /HostbasedAuthentication no/ }
end

# CENTOS: 6.2.8
# UBUNTU: 9.3.8
describe command('grep "^PermitRootLogin" /etc/ssh/sshd_config') do
  its(:stdout) { should match /PermitRootLogin no/ }
end

# CENTOS: 6.2.9
# UBUNTU: 9.3.9
describe command('grep "^PermitEmptyPasswords" /etc/ssh/sshd_config') do
  its(:stdout) { should match /PermitEmptyPasswords no/ }
end

# CENTOS: 6.2.10
# UBUNTU: 9.3.10
describe command('grep PermitUserEnvironment /etc/ssh/sshd_config') do
  its(:stdout) { should match /PermitUserEnvironment no/ }
end

# CENTOS: 6.2.13
# UBUNTU: 9.3.13
describe command('grep "^AllowUsers" /etc/ssh/sshd_config') do
  its(:stdout) { should match /^$/ }
end
describe command('grep "^AllowGroups" /etc/ssh/sshd_config') do
  its(:stdout) { should match /^$/ }
end
describe command('grep "^DenyUsers" /etc/ssh/sshd_config') do
  its(:stdout) { should match /^$|DenyUsers/ }
end
describe command('grep "^DenyGroups" /etc/ssh/sshd_config') do
  its(:stdout) { should match /^$/ }
end

# CENTOS: 6.2.14
# UBUNTU: 9.3.14
describe command('grep "^Banner" /etc/ssh/sshd_config') do
  its(:stdout) { should match /Banner \/etc\/issue/ }
end