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

template "/etc/sysctl.conf" do
  source "sysctl.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
