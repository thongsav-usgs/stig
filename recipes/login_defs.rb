# Cookbook Name:: stig
# Recipe:: login_defs
# Author: Ivan Suftin <isuftin@usgs.gov>

# 7.2.1 Set Password Expiration Days
# The PASS_MAX_DAYS parameter in /etc/login.defs allows
# an administrator to force passwords to expire once they
# reach a defined age. It is recommended that the
# PASS_MAX_DAYS parameter be set to less than or equal to 90 days.
#
# The window of opportunity for an attacker to leverage compromised
# credentials or successfully compromise credentials via an online
# brute force attack is limited by the age of the password. Therefore,
# reducing the maximum age of a password also reduces an an attacker’s
# window of opportunity.

template "/etc/login.defs" do
  source "etc_login.defs.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :pass_max_days => node[:stig][:login_defs][:pass_max_days]
  )
end