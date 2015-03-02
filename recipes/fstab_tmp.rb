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
# UBUNTU: 2.2, 2.3, 2.4, 2.14, 2.15, 2.16
# TODO: UBUNTU 2.1 - Need to figure out LVM to create new /tmp partition
# since a separate /tmp partition does not exist by default
#
# - Set nodev option for /tmp Partition
# - Set nosuid option for /tmp Partition
# - Set noexec option for /tmp Partition
# - Bind Mount the /var/tmp directory to /tmp

var_tmp = "/var/tmp"
tmp = "/tmp"

if %w{debian ubuntu}.include?(node["platform"])
  mount "/run/shm" do
    fstype "tmpfs"
    device "none"
    options "remount,noexec,nodev,nosuid"
    mounted false
    enabled true
    action [:mount, :enable]
  end
end

if %w{rhel fedora centos}.include?(node["platform"])
  mount var_tmp do
    fstype   "tmpfs"
    device   tmp
    options  "bind"
  end
  
  mount "/dev/shm" do
    fstype "tmpfs"
    device "none"
    options "remount,noexec,nodev,nosuid"
    mounted false
    enabled true
    action [:mount, :enable]
  end
end
