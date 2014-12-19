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
