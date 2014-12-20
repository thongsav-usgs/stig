# Use an MD5 hash for this. Ex: openssl passwd -1 ChangeMe
default['stig']['grub']['hashedpassword'] = "$1$ifTCDC.V$0VpmYkffVbzFkE8ElJrWU/" # Hashed "ChangeMe"

# 4.2.1.1 Configure Audit Log Storage Size (Not Scored)
default['stig']['auditd']['max_log_file'] = "6" #MB
# CIS 4.2.1.2 Disable System on Audit Log Full (Not Scored)
default['stig']['auditd']['space_left_action'] = "email"
default['stig']['auditd']['action_mail_acct'] = "root"
default['stig']['auditd']['admin_space_left_action'] = "halt" # YIKES!
# CIS 4.2.1.3 Keep All Auditing Information (Scored)
default['stig']['auditd']['max_log_file_action'] = "keep_logs"
# CIS 4.2.3 Enable Auditing for Processes That Start Prior to auditd (Scored)
default['stig']['auditd']['kernel_audit_grub'] = "audit=1"

# 1.1.18 - 1.1.24 - Removing support for unneeded filesystem types reduces 
# the local attack surface of the server. If this filesystem type is not 
# needed, disable it by setting this variable to true. Enable by setting to false
default['stig']['mount_disable']['cramfs'] = true
default['stig']['mount_disable']['freevxfs'] = true
default['stig']['mount_disable']['jffs2'] = true
default['stig']['mount_disable']['hfs'] = true
default['stig']['mount_disable']['hfsplus'] = true
default['stig']['mount_disable']['squashfs'] = true
default['stig']['mount_disable']['udf'] = true

# 3.16 Configure Mail Transfer Agent for Local-Only Mode
# If the system is intended to be a mail server, change from "localhost"
default['stig']['mail_transfer_agent']['inet_interfaces'] = "localhost"

# 3.3 Disable Avahi Server
# true / false
default["stig"]["network"]["zeroconf"] = true

# 4.1.1 Disable IP Forwarding
# false = IP forwarding disabled
# true = IP forwarding enabled
default["stig"]["network"]["ip_forwarding"] = false

# 4.1.2 Disable Send Packet Redirects
# false = Disable redirects
# true = Enable redirects
default["stig"]["network"]["packet_redirects"] = false

# 4.2.2 Disable ICMP Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default["stig"]["network"]["icmp_redirect_accept"] = false

# 4.2.4 Log Suspicious Packets
# true / false
default["stig"]["network"]["log_suspicious_packets"] = true

# 4.2.7 Enable RFC-recommended Source Route Validation
# true / false
default["stig"]["network"]["rfc_source_route_validation"] = true

# 4.4.2.2 Disable IPv6 Redirect Acceptance
# false = Disable redirect acceptance
# true = Enable redirect acceptance
default["stig"]["network"]["ipv6_redirect_accept"] = false

# 4.4.1 Disable IPv6
# no = disabled
# yes = enabled
default["stig"]["network"]["ipv6"] = "no"
