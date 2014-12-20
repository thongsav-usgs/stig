# 3.3 Disable Avahi Server
#
# Avahi is a free zeroconf implementation, including a system 
# for multicast DNS/DNS-SD service discovery. Avahi allows 
# programs to publish and discover services and hosts running 
# on a local network with no specific configuration. For 
# example, a user can plug a computer into a network and 
# Avahi automatically finds printers to print to, files to 
# look at and people to talk to, as well as network services 
# running on the machine.
#
# Since servers are not normally used for printing, this 
# service is not needed unless dependencies require it. If 
# this is the case, disable the service to reduce the potential
# attack surface. If for some reason the service is required on
# the server, follow the recommendations in sub-sections
# 3.2.1 - 3.2.5 to secure it.
#
# 4.4.1 Disable IPv6
# Although IPv6 has many advantages over IPv4, few organizations
# have implemented IPv6.
#
# If IPv6 is not to be used, it is recommended that it be disabled
# to reduce the attack surface of the system.

execute "chkconfig_avahi-daemon_off" do
  user "root"
  command "/sbin/chkconfig avahi-daemon off"
  action :run
  only_if "/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'"
end

template "/etc/sysconfig/network" do
  source "etc_sysconfig_network.erb"
  user "root"
  group "root"
  mode 0644
end

if node[:stig][:network][:ipv6] == "no"
  ipv6 = 1
  ipv6OnOff = "off"
else
  ipv6 = 0
  ipv6OnOff = "on"
end

template "/etc/modprobe.d/ipv6.conf" do
  source "etc_modprobe.d_ipv6.conf.erb"
  user "root"
  group "root"
  mode 0644
  variables(:ipv6 => ipv6)
  notifies :run, "execute[chkconfig_ip6tables_off]", :immediately
end

execute "chkconfig_ip6tables_off" do
  user "root"
  command "/sbin/chkconfig ip6tables #{ipv6OnOff}"
  action :nothing
end

