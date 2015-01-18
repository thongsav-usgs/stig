# Cookbook Name:: stig
# Recipe:: dhcp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Remove DHCP Server
#
# CIS Benchmark Items
# RHEL6:  3.5
# CENTOS6: 3.5

package "dhcp" do
  action :remove
  provider Chef::Provider::Package::Rpm
end