#
# Cookbook Name:: stig
# Recipe:: aide
# Author: David Blodgett <dblodgett@usgs.gov>
#
# Description: Installs Advanced Intrusion Detection Environment (AIDE) and
# implements periodic file checking to comply with site policy
#
# CIS Benchmark Items
# RHEL6: 1.4.1, 1.4.2
# CENTOS6: 1.3.1, 1.3.2
#
# - Install AIDE
# - Implement Periodic Execution of File Integrity

package "aide" do
  action :install
end

execute "init_aide" do
  user "root"
  command "/usr/sbin/aide --init -B 'database_out=file:/var/lib/aide/aide.db.gz'"
  creates "/var/lib/aide/aide.db.gz"
  action :run
end

cron "aide_cron" do
  command "/usr/sbin/aide --check"
  minute "0"
  hour "5"
  day "*"
  month "*"
  action :create
end