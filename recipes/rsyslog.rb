# Cookbook Name:: stig
# Recipe:: rsyslog
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure /etc/rsyslog.conf
#
# CIS Benchmark Items
# RHEL6:  5.1.3
# CENTOS6: 4.1.3

template "/etc/rsyslog.conf" do
  source "etc_rsyslog.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :rsyslog_rules => node[:stig][:logging][:rsyslog_rules]
  )
  notifies :run, "execute[restart_syslog]", :immediately
end

execute "restart_syslog" do
  user "root"
  command "pkill -HUP rsyslogd"
  action :nothing
end