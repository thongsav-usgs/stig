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

# 4.2.2 Disable ICMP Redirect Acceptance
# ICMP redirect messages are packets that convey routing information and tell your host
# (acting as a router) to send packets via an alternate path. It is a way of allowing an
# outside routing device to update your system routing tables. By
# setting net.ipv4.conf.all.accept_redirects to 0, the system will not accept any ICMP
# redirect messages, and therefore, won’t allow outsiders to update the system’s routing tables.
#
# Attackers could use bogus ICMP redirect messages to maliciously alter the system routing
# tables and get them to send packets to incorrect networks and allow your system packets to be captured.

# 4.2.4 Log Suspicious Packets
# When enabled, this feature logs packets with un-routable source addresses to the kernel log.
#
# Enabling this feature and logging these packets allows an administrator to investigate the
# possibility that an attacker is sending spoofed packets to their server.

# 4.2.7 Enable RFC-recommended Source Route Validation
# Setting net.ipv4.conf.all.rp_filter and net.ipv4.conf.default.rp_filter to 1 forces the
# Linux kernel to utilize reverse path filtering on a received packet to determine if the
# packet was valid. Essentially, with reverse path filtering, if the return packet does
# not go out the same interface that the corresponding source packet came from, the packet
# is dropped (and logged if log_martians is set).
#
# Setting these flags is a good way to deter attackers from sending your server bogus
# packets that cannot be responded to. One instance where this feature breaks down is
# if asymmetrical routing is employed. This is would occur when using dynamic routing
# protocols (bgp, ospf, etc) on your system. If you are using asymmetrical routing on
# your server, you will not be able to enable this feature without breaking the routing.

# 4.4.2.2 Disable IPv6 Redirect Acceptance
# This setting prevents the system from accepting ICMP redirects. ICMP redirects tell
# the system about alternate routes for sending traffic.
#
# It is recommended that systems not accept ICMP redirects as they could be tricked
# into routing traffic to compromised machines. Setting hard routes within the system
# (usually a single default route to a trusted router) protects the system from bad routes.

if node[:stig][:network][:ip_forwarding]
  ip_forwarding = 1
else
  ip_forwarding = 0
end

if node[:stig][:network][:packet_redirects]
  send_redirects = 1
else
  send_redirects = 0
end

if node[:stig][:network][:icmp_redirect_accept]
  icmp_redirect_accept = 1
else
  icmp_redirect_accept = 0
end

if node[:stig][:network][:log_suspicious_packets]
  log_suspicious_packets = 1
else
  log_suspicious_packets = 0
end

if node[:stig][:network][:rfc_source_route_validation]
  rfc_source_route_validation = 1
else
  rfc_source_route_validation = 0
end

if node[:stig][:network][:ipv6_redirect_accept]
  ipv6_redirect_accept = 1
else
  ipv6_redirect_accept = 0
end

template "/etc/sysctl.conf" do
  source "sysctl.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :ip_forwarding => ip_forwarding,
    :send_redirects => send_redirects,
    :icmp_redirect_accept => icmp_redirect_accept,
    :log_suspicious_packets => log_suspicious_packets,
    :rfc_source_route_validation => rfc_source_route_validation,
    :ipv6_redirect_accept => ipv6_redirect_accept
    )
  notifies :run, "execute[sysctl_ip_forward]", :immediately
  notifies :run, "execute[sysctl_send_redirects]", :immediately
  notifies :run, "execute[sysctl_icmp_redirect_accept]", :immediately
  notifies :run, "execute[sysctl_log_suspicious_packets]", :immediately
  notifies :run, "execute[sysctl_rfc_source_route_validation]", :immediately
  notifies :run, "execute[sysctl_ipv4_flush]", :immediately
end

execute "sysctl_ip_forward" do
  user "root"
  command "/sbin/sysctl -w net.ipv4.ip_forward=#{ip_forwarding}"
  action :nothing
end

execute "sysctl_send_redirects" do
  user "root"
  command "/sbin/sysctl -w net.ipv4.conf.all.send_redirects=#{send_redirects}; /sbin/sysctl -w net.ipv4.conf.default.send_redirects=#{send_redirects}"
  action :nothing
end

execute "sysctl_icmp_redirect_accept" do
  user "root"
  command "/sbin/sysctl -w net.ipv4.conf.all.accept_redirects=#{icmp_redirect_accept}; /sbin/sysctl -w net.ipv4.conf.default.accept_redirects=#{icmp_redirect_accept}"
  action :nothing
end

execute "sysctl_log_suspicious_packets" do
  user "root"
  command "/sbin/sysctl -w net.ipv4.conf.all.log_martians=#{log_suspicious_packets}; /sbin/sysctl -w net.ipv4.conf.all.log_martians=#{log_suspicious_packets}"
  action :nothing
end

execute "sysctl_rfc_source_route_validation" do
  user "root"
  command "/sbin/sysctl -w net.ipv4.conf.all.rp_filter=#{rfc_source_route_validation}; /sbin/sysctl -w net.ipv4.conf.default.rp_filter=#{rfc_source_route_validation}"
  action :nothing
end

execute "sysctl_ipv6_redirect_accept" do
  user "root"
  command "/sbin/sysctl -w net.ipv6.conf.default.accept_redirects=#{ipv6_redirect_accept}; /sbin/sysctl -w net.ipv6.route.flush=#{ipv6_redirect_accept}"
  action :nothing
end

execute "sysctl_ipv4_flush" do
  user "root"
  command "/sbin/sysctl -w net.ipv4.route.flush=1"
  action :nothing
end
