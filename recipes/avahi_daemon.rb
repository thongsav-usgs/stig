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

execute "chkconfig_avahi-daemon_off" do
  user "root"
  command "/sbin/chkconfig avahi-daemon off"
  action :run
  only_if "/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'"
end

ruby_block "insert_line_nozeroconf" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysconfig/network")
    file.insert_line_if_no_match("NOZEROCONF*", "NOZEROCONF=true")
    file.write_file
  end
  not_if "grep NOZEROCONF -i /etc/sysconfig/network"
end
