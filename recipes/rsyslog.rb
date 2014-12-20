# Cookbook Name:: stig
# Recipe:: rsyslog
# Author: Ivan Suftin <isuftin@usgs.gov>

# 5.1.3 Configure /etc/rsyslog.conf
# The /etc/rsyslog.conf file specifies rules for
# logging and which files are to be used to log
# certain classes of messages.
#
# A great deal of important security-related
# information is sent via rsyslog (e.g., successful
# and failed su attempts, failed login attempts,
# root login attempts, etc.).

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