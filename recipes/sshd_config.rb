# Cookbook Name:: stig
# Recipe:: sshd_config
# Author: Ivan Suftin <isuftin@usgs.gov>

# 6.2.2 Set LogLevel to INFO
# The INFO parameter specifices that record login and
# logout activity will be logged.
#
# SSH provides several logging levels with varying amounts
# of verbosity. DEBUG is specifically not recommended other
# than strictly for debugging SSH communications since it
# provides so much data that it is difficult to identify
# important security information. INFO level is the basic
# level that only records login activity of SSH users. In
# many situations, such as Incident Response, it is important
# to determine when a particular user was active on a system.
# The logout record can eliminate those users who disconnected,
# which helps narrow the field.

# 6.2.3 Set Permissions on /etc/ssh/sshd_config
# The /etc/ssh/sshd_config file contains configuration specifications
# for sshd. The command below sets the owner and group of the file to root.
#
# The /etc/ssh/sshd_config file needs to be protected from unauthorized
# changes by non-priliveged users, but needs to be readable as this
# information is used with many non- privileged programs.

# 6.2.5 Set SSH MaxAuthTries to 4 or Less
# The MaxAuthTries parameter specifies the maximum number of authentication
# attempts permitted per connection. When the login failure count reaches
# half the number, error messages will be written to the syslog file
# detailing the login failure.
#
# Setting the MaxAuthTries parameter to a low number will minimize the
# risk of successful brute force attacks to the SSH server. While the
# recommended setting is 4, it is set the number based on site policy.

# 6.2.6 Set SSH IgnoreRhosts to Yes
# The IgnoreRhosts parameter specifies that .rhosts and .shosts files
# will not be used in RhostsRSAAuthentication or HostbasedAuthentication.
#
# Setting this parameter forces users to enter a password when authenticating with ssh.

# 6.2.7 Set SSH HostbasedAuthentication to No
# The HostbasedAuthentication parameter specifies if authentication is 
# allowed through trusted hosts via the user of .rhosts, or /etc/hosts.equiv,
# along with successful public key client host authentication. This option
# only applies to SSH Protocol Version 2.
#
# Even though the .rhosts files are ineffective if support is disabled in
# /etc/pam.conf, disabling the ability to use .rhosts files in SSH
# provides an additional layer of protection .

# 6.2.8 Disable SSH Root Login
# The PermitRootLogin parameter specifies if the root user can log in
# using ssh(1). The default is no.
#
# Disallowing root logins over SSH requires server admins to
# authenticate using their own individual account, then escalating
# to root via sudo or su. This in turn limits opportunity for
# non-repudiation and provides a clear audit trail in the event of
# a security incident

# 6.2.9 Set SSH PermitEmptyPasswords to No
# The PermitEmptyPasswords parameter specifies if the server allows
# login to accounts with empty password strings.
#
# Disallowing remote shell access to accounts that have an empty
# password reduces the probability of unauthorized access to the system

# 6.2.10 Do Not Allow Users to Set Environment Options
# The PermitUserEnvironment option allows users to present environment
# options to the ssh daemon.
#
# Permitting users the ability to set environment variables through the
#  SSH daemon could potentially allow users to bypass security controls
# (e.g. setting an execution path that has ssh executing trojan’d programs)

if node[:stig][:sshd_config][:ignore_rhosts]
  ignore_rhosts = "yes"
else
  ignore_rhosts = "no"
end

if node[:stig][:sshd_config][:host_based_auth]
  host_based_auth = "yes"
else
  host_based_auth = "no"
end

if node[:stig][:sshd_config][:permit_root_login]
  permit_root_login = "yes"
else
  permit_root_login = "no"
end

if node[:stig][:sshd_config][:permit_empty_passwords]
  permit_empty_passwords = "yes"
else
  permit_empty_passwords = "no"
end

if node[:stig][:sshd_config][:allow_users_set_env_opts]
  allow_users_set_env_opts = "yes"
else
  allow_users_set_env_opts = "no"
end

template "/etc/ssh/sshd_config" do
  source "etc_ssh_sshd_config.erb"
  mode 0600
  owner "root"
  group "root"
  variables(
    :log_level => node[:stig][:sshd_config][:log_level],
    :max_auth_tries => node[:stig][:sshd_config][:max_auth_tries],
    :ignore_rhosts => ignore_rhosts,
    :host_based_auth => host_based_auth,
    :permit_root_login => permit_root_login,
    :permit_empty_passwords => permit_empty_passwords,
    :allow_users_set_env_opts => allow_users_set_env_opts
  )
end