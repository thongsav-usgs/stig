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

# 7.2.2 Set Password Change Minimum Number of Days
# The PASS_MIN_DAYS parameter in /etc/login.defs allows an
# administrator to prevent users from changing their password until
# a minimum number of days have passed since the last time the user
# changed their password. It is recommended that PASS_MIN_DAYS
# parameter be set to 7 or more days.
#
# By restricting the frequency of password changes, an administrator
# can prevent users from repeatedly changing their password in
# an attempt to circumvent password reuse controls.

template "/etc/login.defs" do
  source "etc_login.defs.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :pass_max_days => node[:stig][:login_defs][:pass_max_days],
    :pass_min_days => node[:stig][:login_defs][:pass_min_days]
  )
end