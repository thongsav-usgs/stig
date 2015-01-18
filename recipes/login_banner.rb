# Cookbook Name:: stig
# Recipe:: login_banner
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Create login banners
#
# CIS Benchmark Items
# RHEL6:  8.1, 8.1.1
# CENTOS6: 8.1, 8.2
#
# - Set Warning Banner for Standard Login Services
# - Remove OS Information from Login Warning Banners

cookbook_file "motd" do
  path "/etc/motd"
  owner "root"
  group "root"
  mode 0644
end

cookbook_file "issue" do
  path "/etc/issue"
  owner "root"
  group "root"
  mode 0644
end

cookbook_file "issue.net" do
  path "/etc/issue.net"
  owner "root"
  group "root"
  mode 0644
end