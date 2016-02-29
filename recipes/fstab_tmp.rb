#
# Cookbook Name:: stig
# Recipe:: fstab_tmp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Update mounts to comply with CIS reccomendations
#
# CIS Benchmark Items
# RHEL6: 1.1.2, 1.1.3, 1.1.4, 1.1.6, 1.14, 1.1.15, 1.1.16
# CENTOS6: 1.1.2, 1.1.3, 1.1.4, 1.1.6, 1.1.14, 1.1.15, 1.1.16
# CENTOS7: 1.1.2, 1.1.3, 1.1.4, 1.1.6, 1.1.14, 1.1.15, 1.1.16
# UBUNTU: 2.2, 2.3, 2.4, 2.6, 2.14, 2.15, 2.16
# TODO: UBUNTU 2.1 - Need to figure out LVM to create new /tmp partition
# since a separate /tmp partition does not exist by default
#
# - Set nodev option for /tmp Partition
# - Set nosuid option for /tmp Partition
# - Set noexec option for /tmp Partition
# - Bind Mount the /var/tmp directory to /tmp

var_tmp = "/var/tmp"
tmp = "/tmp"

mount var_tmp do
  fstype   "tmpfs"
  device   tmp
  options  "bind"
  not_if 'mount | grep /var/tmp'
end

if %w{debian ubuntu}.include?(node["platform"])
  mount "/run/shm" do
    fstype "tmpfs"
    device "none"
    options "rw,nodev,nosuid,noexec"
    action [:mount, :enable]
    notifies :run, "execute[remount]", :immediately
  end
  
  # The initial mount for whatever reason doesn't seem to mount
  # with the noexec flag. I need to remount after noexec is written 
  # to fstab
  execute "remount" do
    command "mount -o remount /run/shm"
    action :nothing
  end
end

if %w{rhel fedora centos}.include?(node["platform"])
  mount "/dev/shm" do
    fstype "tmpfs"
    device "none"
    options "remount,nodev,nosuid,noexec"
    mounted false
    enabled true
    action [:mount, :enable]
  end
end
