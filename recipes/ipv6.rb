#
# Cookbook Name:: stig
# Recipe:: ipv6
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Disable IPv6
#
# CIS Benchmark Items
# RHEL6:  4.4.1
# CENTOS6: 5.4
#
# - Disable IPv6

template "/etc/sysconfig/network" do
  source "etc_sysconfig_network.erb"
  user "root"
  group "root"
  mode 0644
end

if node["stig"]["network"]["ipv6"] == "no"
  ipv6 = 1
  ipv6OnOff = "off"
else
  ipv6 = 0
  ipv6OnOff = "on"
end

template "/etc/modprobe.d/ipv6.conf" do
  source "etc_modprobe.d_ipv6.conf.erb"
  user "root"
  group "root"
  mode 0644
  variables(:ipv6 => ipv6)
  notifies :run, "execute[chkconfig_ip6tables_off]", :immediately
end

execute "chkconfig_ip6tables_off" do
  user "root"
  command "/sbin/chkconfig ip6tables #{ipv6OnOff}"
  action :nothing
end

