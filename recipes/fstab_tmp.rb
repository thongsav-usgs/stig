#
# Cookbook Name:: stig
# Recipe:: fstab_tmp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Fix permissions for /tmp
#
# CIS Benchmark Items
# RHEL6: 1.1.2, 1.1.3, 1.1.4, 1.1.6
# CENTOS6: 1.1.2, 1.1.3, 1.1.4, 1.1.6
#
# - Set nodev option for /tmp Partition
# - Set nosuid option for /tmp Partition
# - Set noexec option for /tmp Partition
# - Bind Mount the /var/tmp directory to /tmp

var_tmp = "/var/tmp"
dev_shm = "/dev/shm"
tmp = "/tmp"

mount var_tmp do
  fstype   "tmpfs"
  device   tmp
  options  "bind"
end

mount dev_shm do
  fstype "tmpfs"
  device "none"
  options "remount,noexec,nodev,nosuid"
  mounted true
  enabled true
  action [:remount, :enable]
end





