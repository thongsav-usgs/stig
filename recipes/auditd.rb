#
# Cookbook Name:: stig
# Recipe:: auditd
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the auditd cookbook with the CIS ruleset
#
# See: https://supermarket.chef.io/cookbooks/auditd

node.default["auditd"]["ruleset"] = "cis"
auditd_config_dir = "/etc/audit/"

directory auditd_config_dir

include_recipe "auditd::rules"

# Create auditd configuration file
template File.join(auditd_config_dir, "auditd.conf") do
  source "etc_audit_auditd.conf.erb"
  owner "root"
  group "root"
  mode 0640
  notifies :reload, "service[auditd]", :immediately
end
