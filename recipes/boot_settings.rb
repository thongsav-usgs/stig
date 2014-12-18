# 1.5.1 Set the owner and group of /etc/grub.conf to the root user. (Scored)
# 1.5.2 Set permission on the /etc/grub.conf file to read and write for root only. (Scored)
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

# 1.5.4 Require Authentication for Single-User Mode. Since /etc/init determines 
# what run state the system is in, setting the entry in /etc/sysconfig/init will 
# force single user authentication.

ruby_block "insert_line_sulogin" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysconfig/init")
    file.insert_line_if_no_match("/SINGLE/s/sushell/sulogin/", "/SINGLE/s/sushell/sulogin/")
    file.write_file
  end
  not_if "grep -q /SINGLE/s/sushell/sulogin/ /etc/sysconfig/init"
end

ruby_block "insert_line_prompt" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysconfig/init")
    file.insert_line_if_no_match("/PROMPT/s/yes/no/", "/PROMPT/s/yes/no/")
    file.write_file
  end
  not_if "grep -q /PROMPT/s/yes/no/ /etc/sysconfig/init"
end

# 1.5.5 Disable Interactive Boot. The PROMPT option provides console users the 
# ability to interactively boot the system and select which services to start on 
# boot. Set the PROMPT parameter in /etc/sysconfig/init to no. PROMPT=no

ruby_block "set_prompt_no" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysconfig/init")
    file.search_file_replace_line("PROMPT=yes", "PROMPT=no")
    file.write_file
  end
  not_if "grep -q PROMPT=no /etc/sysconfig/init"
end
