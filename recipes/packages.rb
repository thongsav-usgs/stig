# 3.5 Remove DHCP Server
#
# The Dynamic Host Configuration Protocol (DHCP) is 
# a service that allows machines to be dynamically 
# assigned IP addresses.
# 
# Unless a server is specifically set up to act as 
# a DHCP server, it is recommended that this service
# be deleted to reduce the potential attack surface.

package "dhcp" do
  action :remove
  provider Chef::Provider::Package::Rpm
end