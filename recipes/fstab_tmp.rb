#
# Cookbook Name:: stig
# Recipe:: fstab_tmp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: 
# 1.1.2 Set nodev option for /tmp Partition (Scored) 
# 
# The nodev mount option specifies that the filesystem cannot contain special devices.
# Since the /tmp filesystem is not intended to support devices, set this option to ensure that users cannot attempt to create block or character special devices in /tmp.
#
# 1.1.3 Set nosuid option for /tmp Partition (Scored)
# The nosuid mount option specifies that the filesystem cannot contain set userid files.
# Since the /tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot create set userid files in /tmp.

mount "/tmp" do
  fstype   "tmpfs"
  device   "/dev/shm"
  options  "remount,nodev,nosuid"
  mounted  true
  enabled  true
  action   [:remount, :enable]
end
