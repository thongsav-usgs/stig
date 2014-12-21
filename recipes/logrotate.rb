# Cookbook Name:: stig
# Recipe:: logrotate
# Author: Ivan Suftin <isuftin@usgs.gov>

# 5.3 Configure logrotate
# The system includes the capability of rotating log
# files regularly to avoid filling up the system with
# logs or making the logs unmanageable large. The file
# /etc/logrotate.d/syslog is the configuration file used
# to rotate log files created by syslog or rsyslog. These
# files are rotated on a weekly basis via a cron job and
# the last 4 weeks are kept.
#
# By keeping the log files smaller and more manageable,
# a system administrator can easily archive these files
# to another system and spend less time looking through
# inordinately large log files.

template "/etc/logrotate.d/syslog" do
  source "etc_logrotate.d_syslog.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
  :logrotate_items => node[:stig][:logging][:logrotate_items]
  )
end