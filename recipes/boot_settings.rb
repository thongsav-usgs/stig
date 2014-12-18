# 1.5.1 Set the owner and group of /etc/grub.conf to the root user.

# 1.5.2 Set permission on the /etc/grub.conf file to read and write for root only.

# 1.5.3 Setting the boot loader password will require that the person who is 
# rebooting the must enter a password before being able to set command line boot parameters.

# 1.5.4 Require Authentication for Single-User Mode. Since /etc/init determines 
# what run state the system is in, setting the entry in /etc/sysconfig/init will 
# force single user authentication.

# 1.5.5 Disable Interactive Boot. The PROMPT option provides console users the 
# ability to interactively boot the system and select which services to start on 
# boot. Set the PROMPT parameter in /etc/sysconfig/init to no. PROMPT=no 