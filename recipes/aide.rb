#
# Cookbook Name:: stig
# Recipe:: aide
# Author: David Blodgett <dblodgett@usgs.gov>
#
# Description: Advanced Intrusion Detection Environment (AIDE)
# 1.3.1 In some installations, AIDE is not installed automatically.

# 1.3.2 Implement periodic file checking, in compliance with site policy.

package "aide" do
  action :install
end

cron "aide_cron" do
  command "/usr/sbin/aide --check"
  minute "0"
  hour "5"
  day "*"
  month "*"
  action :create
end