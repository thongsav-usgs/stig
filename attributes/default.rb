default['stig']['grub']['password'] = 'ChangeMe'
md5hash = `openssl passwd -1 #{node.default['stig']['grub']['password']}`
default['stig']['grub']['hashedpassword'] = md5hash

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