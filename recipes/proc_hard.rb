#
# Cookbook Name:: stig
# Recipe:: proc_hard
# Author: David Blodgett <dblodgett@usgs.gov>

# 1.6.1 Restrict Core Dumps (Scored)
# A core dump is the memory of an executable program. It is generally used to 
# determine why a program aborted. It can also be used to glean confidential information 
# from a core file. The system provides the ability to set a soft limit for core dumps, 
# but this can be overridden by the user.

# 1.6.2 Configure ExecShield (Scored)
# Execshield is made up of a number of kernel features to provide protection against 
# buffer overflow attacks. These features include prevention of execution in memory 
# data space, and special handling of text buffers.

# 1.6.3 Enable Randomized Virtual Memory Region Placement (Scored)
# Set the system flag to force randomized virtual memory region placement.

template "/etc/security/limits.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

# 4.1.1 Disable IP Forwarding
# The net.ipv4.ip_forward flag is used to tell the server whether it can
# forward packets or not. If the server is not to be used as a router, set the flag to 0.

# 4.1.2 Disable Send Packet Redirects
# ICMP Redirects are used to send routing information to other hosts. As a host itself
# does not act as a router (in a host only configuration), there is no need to send redirects.
#
# An attacker could use a compromised host to send invalid ICMP redirects to other router
# devices in an attempt to corrupt routing and have users access a system set up by the
# attacker as opposed to a valid system.

template "/etc/sysctl.conf" do
  source "sysctl.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
