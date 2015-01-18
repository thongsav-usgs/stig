# Cookbook Name:: stig
# Recipe:: logrotate
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Update log rotation policy
#
# CIS Benchmark Items
# RHEL6:  5.3
# CENTOS6: 4.3
#
# - Configure logrotate

template "/etc/logrotate.d/syslog" do
  source "etc_logrotate.d_syslog.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
  :logrotate_items => node[:stig][:logging][:logrotate_items]
  )
end