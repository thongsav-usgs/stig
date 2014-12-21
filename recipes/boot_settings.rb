# Cookbook Name:: stig
# Recipe:: boot_settings
# Author: Ivan Suftin <isuftin@usgs.gov>

# 1.5.1 Set the owner and group of /etc/grub.conf to the root user. (Scored)
# 1.5.2 Set permission on the /etc/grub.conf file to read and write for root only. (Scored)
# 1.5.3 Set Boot Loader Password (Scored)
# 
# Setting the boot loader password will require that the person who is 
# rebooting the must enter a password before being able to set command line boot 
# parameters.
#
# Requiring a boot password upon execution of the boot loader will prevent an 
# unauthorized user from entering boot parameters or changing the boot partition.
# This prevents users from weakening security (e.g. turning off SELinux at boot time).
#
# 1.5.4 Require Authentication for Single-User Mode. Since /etc/init determines 
# what run state the system is in, setting the entry in /etc/sysconfig/init will 
# force single user authentication.
#
# 1.5.5 Disable Interactive Boot. The PROMPT option provides console users the 
# ability to interactively boot the system and select which services to start on 
# boot. Set the PROMPT parameter in /etc/sysconfig/init to no. PROMPT=no

# Also applies CIS 4.2.3
template "/boot/grub/grub.conf" do
  source "etc_grub.conf.erb"
  owner "root"
  group "root"
  mode 0600
  sensitive true
end

template "/etc/sysconfig/init" do
  source "init.erb"
  owner "root"
  group "root"
  mode 0644
end

# 4.2.1-3
template "/etc/audit/auditd.conf" do
  source "etc_audit_auditd.conf.erb"
  owner "root"
  group "root"
  mode 0640
end