# 1.5.3 Set Boot Loader Password (Scored)
# 
# Setting the boot loader password will require that the person who is 
# rebooting the must enter a password before being able to set command line boot 
# parameters.
#
# Requiring a boot password upon execution of the boot loader will prevent an 
# unauthorized user from entering boot parameters or changing the boot partition.
# This prevents users from weakening security (e.g. turning off SELinux at boot time).

template "/boot/grub/grub.conf" do
  source "grub.conf.erb"
  owner "root"
  group "root"
  mode 0600
  sensitive true
end