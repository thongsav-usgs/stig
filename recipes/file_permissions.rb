# Cookbook Name:: stig
# Recipe:: file_permissions
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: File permission configuration 
#
# CIS Benchmark Items
# RHEL6:  6.1.3, 6.1.4, 6.1.5, 6.1.6, 6.1.7, 6.1.8, 6.1.9, 6.1.10, 9.1.1, 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8
# CENTOS6: 6.1.3, 6.1.4, 6.1.5, 6.1.6, 6.1.7, 6.1.8, 6.1.9, 6.1.10, 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8, 9.1.9
#
# - Set User/Group Owner and Permission on /etc/anacrontab
# - Set User/Group Owner and Permission on /etc/crontab
# - Set User/Group Owner and Permission on /etc/cron.hourly
# - Set User/Group Owner and Permission on /etc/cron.daily
# - Set User/Group Owner and Permission on /etc/cron.weekly
# - Set User/Group Owner and Permission on /etc/cron.monthly
# - Set User/Group Owner and Permission on /etc/cron.d
# - Restrict at Daemon
# - Verify Permissions on /etc/passwd
# - Verify Permissions on /etc/shadow
# - Verify User/Group Ownership on /etc/passwd
# - Verify User/Group Ownership on /etc/shadow
# - Verify Permissions on /etc/gshadow
# - Verify User/Group Ownership on /etc/gshadow
# - Verify Permissions on /etc/group
# - Verify User/Group Ownership on /etc/group

file "/etc/anacrontab" do
  owner "root"
  group "root"
  mode 0600
end

file "/etc/crontab" do
  owner "root"
  group "root"
  mode 0600
end

directory "/etc/cron.hourly" do
  owner "root"
  group "root"
  mode 0700
end

directory "/etc/cron.daily" do
  owner "root"
  group "root"
  mode 0700
end

directory "/etc/cron.weekly" do
  owner "root"
  group "root"
  mode 0700
end

directory "/etc/cron.monthly" do
  owner "root"
  group "root"
  mode 0700
end

directory "/etc/cron.d" do
  owner "root"
  group "root"
  mode 0700
end

file "/etc/at.deny" do
  owner "root"
  group "root"
  mode 0700
end

file "/etc/at.allow" do
  action :delete
end

file "/etc/passwd" do
  owner "root"
  group "root"
  mode 0644
end

file "/etc/shadow" do
  owner "root"
  group "root"
  mode 0000
end

file "/etc/gshadow" do
  owner "root"
  group "root"
  mode 0000
end

file "/etc/group" do
  owner "root"
  group "root"
  mode 0644
end
