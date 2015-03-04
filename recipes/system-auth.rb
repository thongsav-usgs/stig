# Cookbook Name:: stig
# Recipe:: system-auth
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Sysauth
#
# CIS Benchmark Items
# RHEL6:  6.3.6
# CENTOS6: 6.3.4
# UBUNTU: 9.2.3
#
# - Limit Password Reuse

template "/etc/pam.d/system-auth" do
  source "etc_pam.d_system-auth.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :pass_reuse_limit => node["stig"]["system_auth"]["pass_reuse_limit"] 
  )
end