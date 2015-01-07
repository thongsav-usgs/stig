# Cookbook Name:: stig
# Recipe:: login_banner
# Author: Ivan Suftin <isuftin@usgs.gov>

# 8.1 Set Warning Banner for Standard Login Services
# The contents of the /etc/issue file are displayed prior
# to the login prompt on the system's console and serial
# devices, and also prior to logins via telnet. The contents
# of the/etc/motd file is generally displayed after all
# successful logins, no matter where the user is logging
# in from, but is thought to be less useful because it only
# provides notification to the user after the machine has been accessed.
#
# Warning messages inform users who are attempting to login to the
# system of their legal status regarding the system and must include
# the name of the organization that owns the system and any monitoring
# policies that are in place. Consult with your organization’s legal
# counsel for the appropriate wording for your specific organization.

# 8.1.1 Remove OS Information from Login Warning Banners
# Unix-based systems have typically displayed information about the OS
# release and patch level upon logging in to the system. This information
# can be useful to developers who are developing software for a particular
# OS platform. If mingetty(8) supports the following options, they
# display operating system information:
# \m - machine architecture (uname -m)
# \r - operating system release (uname -r)
# \s - operating system name
# \v – operating system version (uname –v)
#
# Displaying OS and patch level information in login banners also has
# the side effect of providing detailed system information to attackers
# attempting to target specific exploits of a system. Authorized users
# can easily get this information by running the “uname –a” command once
# they have logged in.

# This is a new comment. -- Chad

cookbook_file "motd" do
  path "/etc/motd"
  owner "root"
  group "root"
  mode 0644
end

cookbook_file "issue" do
  path "/etc/issue"
  owner "root"
  group "root"
  mode 0644
end

cookbook_file "issue.net" do
  path "/etc/issue.net"
  owner "root"
  group "root"
  mode 0644
end