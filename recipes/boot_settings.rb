# Cookbook Name:: stig
# Recipe:: boot_settings
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure boot settings
#
# CIS Benchmark Items
# RHEL6:  1.5.1, 1.5.2, 1.5.3, 1.5.4, 1.5.5, 1.5.6, 1.6.1, 1.6.2, 1.6.3, 1.6.4, 4.2.1, 4.2.2, 4.2.3
# CENTOS6: 1.4.1, 1.4.2, 1.4.3, 1.4.4, 1.4.5, 1.4.6, 1.5.1, 1.5.2, 1.5.3, 1.5.5, 5.2.1, 5.2.2, 5.2.3
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

needreboot = false

if %w{debian ubuntu}.include?(node["platform"])
  template "/etc/grub.d/40_custom" do
    source "etc_grubd_40_custom.erb"
    variables ({ :pass => node['stig']['grub']['hashedpassword'] })
    sensitive true
    notifies :run, "execute[update-grub]", :immediately
  end
  
  execute "update-grub" do
    action :nothing
  end
end

# This is not scored (or even suggested by CIS) in Ubuntu
if %w{rhel fedora centos}.include?(node["platform"])

  # 1.4.1
  execute "Remove selinux=0 from /etc/grub.conf" do
    command "sed -i 's/selinux=0//' /etc/grub.conf"
    only_if "grep -q 'selinux=0' /etc/grub.conf"
  end
  execute "Remove enforcing=0 from /etc/grub.conf" do
    command "sed -i 's/enforcing=0//' /etc/grub.conf"
    only_if "grep -q 'enforcing=0' /etc/grub.conf"
  end

  # 1.5.3
  if node['stig']['grub']['hashedpassword'] != ''
    password = node['stig']['grub']['hashedpassword']
    execute "Add password to grub" do
      command "sed -i '11i password --md5 #{password}' /etc/grub.conf"
      not_if "grep -q '#{password}' /etc/grub.conf"
    end
  else
    execute "Add password to grub" do
      command "sed -i '/password/d' /etc/grub.conf"
      only_if "grep -q 'password' /etc/grub.conf"
    end
  end
  
  enabled_selinux = node['stig']['selinux']['enabled']
  status_selinux = node['stig']['selinux']['status']
  type_selinux = node['stig']['selinux']['type']

  template "/etc/selinux/config" do
    source "etc_selinux_config.erb"
    owner "root"
    group "root"
    variables({
      :enabled_selinux => enabled_selinux,
      :status_selinux => status_selinux,
      :type_selinux => type_selinux
    })
    mode 0644
    sensitive true
    # notifies :run, "execute[restart_selinux]", :immediately
  end

  link "/etc/sysconfig/selinux" do
    to "/etc/selinux/config"
  end
  
   template "/selinux/enforce" do
    source "selinux_enforce.erb"
    owner "root"
    group "root"
    variables({
      :enforcing => (enabled_selinux ? 1 : 0)
    })
    only_if { ::File.directory?("/selinux/enforce") }
    mode 0644
  end

  execute "toggle_selinux" do
    command "setenforce #{(enabled_selinux ? 1 : 0)}"
    not_if "echo $(getenforce) | awk '{print tolower($0)}' | grep #{status_selinux}"
  end

  template "/etc/sysconfig/init" do
    source "etc_sysconfig_init.erb"
    owner "root"
    group "root"
    mode 0644
  end
end

package "setroubleshoot" do
  action :remove
end

package "mcstrans" do
  action :remove
end