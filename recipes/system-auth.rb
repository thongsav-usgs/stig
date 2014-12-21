# Cookbook Name:: stig
# Recipe:: system-auth
# Author: Ivan Suftin <isuftin@usgs.gov>

# 6.3.6 Limit Password Reuse
# The /etc/security/opasswd file stores the users’ old
# passwords and can be checked to ensure that users are
# not recycling recent passwords.
#
# Forcing users not to reuse their past 5 passwords
# make it less likely that an attacker will be able to guess the password.
# Note that these change only apply to accounts configured on the local system.

template "/etc/pam.d/system-auth" do
  source "etc_pam.d_system-auth.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :pass_reuse_limit => node[:stig][:system_auth][:pass_reuse_limit] 
  )
end