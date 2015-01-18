# Cookbook Name:: stig
# Recipe:: mail_transfer_agent
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Mail Transfer Agent for Local-Only Mode
#
# CIS Benchmark Items
# RHEL6:  3.1.16
# CENTOS6: 3.1.16

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[postfix]", :immediately
end

service "postfix" do
  action :nothing
end