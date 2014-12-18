#
# Cookbook Name:: stig
# Recipe:: fstab_tmp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: 
# 1.1.2 Set nodev option for /tmp Partition (Scored)  
# The nodev mount option specifies that the filesystem cannot contain special devices.
#
# Since the /tmp filesystem is not intended to support devices, set this option to ensure that users cannot attempt to create block or character special devices in /tmp.
#
# 1.1.3 Set nosuid option for /tmp Partition (Scored)
# The nosuid mount option specifies that the filesystem cannot contain set userid files.
#
# Since the /tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot create set userid files in /tmp.
# 
# 1.1.4 Set noexec option for /tmp Partition (Scored)
# The noexec mount option specifies that the filesystem cannot contain executable binaries.
#
# Since the /tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot run executable binaries from /tmp.
#
# 1.1.6 Bind Mount the /var/tmp directory to /tmp (Scored)
# The /var/tmp directory is normally a standalone directory in the /var file system. Binding /var/tmp to /tmp establishes an unbreakable link to /tmp 
# that cannot be removed (even by the root user). It also allows /var/tmp to inherit the same mount options that /tmp owns, allowing /var/tmp to be 
# protected in the same /tmp is protected. It will also prevent /var from filling up with temporary files as the contents of /var/tmp will actually 
# reside in the file system containing /tmp.i
#
# All programs that use /var/tmp and /tmp to read/write temporary files will always be written to the /tmp file system, preventing a user from 
# running the /var file system out of space or trying to perform operations that have been blocked in the /tmp filesystem.

vartmp = "/var/tmp"
tmp = "/tmp"

# 1.1.2, 1.1.3, 1.1.4 
mount tmp do
  fstype   "tmpfs"
  device   "/dev/shm"
  options  "remount,noexec,nodev,nosuid"
  mounted  true
  enabled  true
  action   [:remount, :enable]
end

# 1.1.6 
mount vartmp do
  fstype   "tmpfs"
  device   tmp
  options  "bind"
end
