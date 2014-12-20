# Cookbook Name:: stig
# Recipe:: hosts
# Author: Ivan Suftin <isuftin@usgs.gov>

# 4.5.1 Create /etc/hosts.allow
#
# The /etc/hosts.allow file specifies which IP addresses
# are permitted to connect to the host. It is intended to
# be used in conjunction with the /etc/hosts.deny file.
#
# The /etc/hosts.allow file supports access control by IP
# and helps ensure that only authorized systems can connect
# to the server.

# 4.5.2 Verify Permissions on /etc/hosts.allow
#
# The /etc/hosts.allow file contains networking information
# that is used by many applications and therefore must be
# readable for these applications to operate.
#
# It is critical to ensure that the /etc/hosts.allow file
# is protected from unauthorized write access. Although it
# is protected by default, the file permissions could be
# changed either inadvertently or through malicious actions.

# 4.5.3 Create /etc/hosts.deny
#
# The /etc/hosts.deny file specifies which IP addresses are
# not permitted to connect to the host. It is intended to be
# used in conjunction with the /etc/hosts.allow file.
#
# The /etc/hosts.deny file serves as a failsafe so that any
# host not specified in /etc/hosts.allow is denied access to
# the server.

# 4.5.4 Verify Permissions on /etc/hosts.deny
#
# The /etc/hosts.deny file contains network information that
# is used by many system applications and therefore must be
# readable for these applications to operate.
#
# It is critical to ensure that the /etc/hosts.deny file is
# protected from unauthorized write access. Although it is
# protected by default, the file permissions could be changed
# either inadvertently or through malicious actions.

template "/etc/hosts.allow" do
  owner "root"
  group "root"
  mode 0644
  source "etc_hosts.allow.erb"
  variables(
    :hosts_allow => node["stig"]["network"]["hosts_allow"]
  )
end

template "/etc/hosts.deny" do
  owner "root"
  group "root"
  mode 0644
  source "etc_hosts.deny.erb"
  variables(
    :hosts_deny => node["stig"]["network"]["hosts_deny"]
  )
end

