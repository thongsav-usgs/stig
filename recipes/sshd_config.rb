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

template "/etc/ssh/sshd_config" do
  source "etc_ssh_sshd_config.erb"
  mode 0600
  owner "root"
  group "root"
  variables(
    :loglevel => node[:stig][:logging][:log_level]
  )
end