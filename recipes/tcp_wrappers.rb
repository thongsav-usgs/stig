#
# Cookbook Name:: stig
# Recipe:: tcp_wrappers
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Install TCP Wrappers
#
# CIS Benchmark Items
#
# 
# Ubuntu 7.4.1
# CentOS 5.5.1
# Redhat 4.5

if %w{rhel fedora centos}.include?(node["platform"])
	package tcp_wrappers
end

if %w{debian ubuntu}.include?(node["platform"])
	package tcpd
end
