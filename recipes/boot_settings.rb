# Cookbook Name:: stig
# Recipe:: boot_settings
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure boot settings
#
# CIS Benchmark Items
# RHEL6:  1.5.1, 1.5.2, 1.5.3, 1.5.4, 1.5.5, 1.5.6, 1.6.1, 1.6.2, 1.6.3, 1.6.4, 4.2.1, 4.2.2, 4.2.3
# CENTOS6: 1.4.1, 1.4.2, 1.4.3, 1.4.4, 1.4.5, 1.4.6, 1.5.1, 1.5.2, 1.5.3, 1.5.5, 5.2.2, 5.2.3
# UBUNTU: 3.1, 3.2, 
# - Enable SELinux in /etc/grub.conf. 
# - Set SELinux state
# - Set SELinux policy
# - Remove SETroubleshoot
# - Remove MCS Translation Service
# - Check for unconfined daemons - NOTE: This doesn't have an action plan associated with it
# - Set User/Group Owner on /etc/grub.conf 
# - Set Permissions on /etc/grub.conf 
# - Set Boot Loader Password 
# - Require Authentication for Single-User Mode.
# - Disable Interactive Boot.
# - Disable Source Routed Packet Acceptance
# - Disable ICMP Redirect Acceptance
# - Disable Secure ICMP Redirect Acceptance

auditd_config_dir = "/etc/audit/"

template "/boot/grub/grub.conf" do
  source "etc_grub.conf.erb"
  owner "root"
  group "root"
  mode 0400
  sensitive true
end

# This is not scored (or even suggested by CIS) in Ubuntu
if %w{rhel fedora centos}.include?(node["platform"])
  template "/etc/selinux/config" do
    source "etc_selinux_config.erb"
    owner "root"
    group "root"
    mode 0644
    sensitive true
  end

  template "/etc/sysconfig/init" do
    source "etc_sysconfig_init.erb"
    owner "root"
    group "root"
    mode 0644
  end
end

# Create auditd configuration file
directory auditd_config_dir
template File.join(auditd_config_dir, "auditd.conf") do
  source "etc_audit_auditd.conf.erb"
  owner "root"
  group "root"
  mode 0640
end

package "setroubleshoot" do
  action :remove
end

package "mcstrans" do
  action :remove
end