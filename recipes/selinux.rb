# 1.4.1 Remove all instances of selinux=0 and enforcing=0 from /etc/grub.conf. 
# Already passing.

# 1.4.2 Set SELinux to enable when the system is booted. Edit the /etc/selinux/config 
# file to set the SELINUX parameter: SELINUX=enforcing Already passing.

# 1.4.3 Configure SELinux to meet or exceed the default targeted policy, which 
# constrains daemons and system software only. Edit the /etc/selinux/config file to 
# set the SELINUXTYPE parameter: SELINUXTYPE=targeted Already Passing.

# 1.4.4 The SETroubleshoot service notifies desktop users of SELinux denials 
# through a user- friendly interface. The service provides important information 
# around configuration errors, unauthorized intrusions, and other potential errors. 
# yum erase setroubleshoot. Already passing.

# 1.4.5 The mcstransd daemon provides category label information to client processes 
# requesting information. The label translations are defined in 
# /etc/selinux/targeted/setrans.conf yum erase mcstrans Already passing.

# 1.4.6 Daemons that are not defined in SELinux policy will inherit the security 
# context of their parent process. Already passing, no remediation recommended
# if not failing.