# 1.5.1 Set the owner and group of /etc/grub.conf to the root user.
# 1.5.2 Set permission on the /etc/grub.conf file to read and write for root only.
# Note that default settings are compliant, this is reinforcing only.
file "/etc/grub.conf" do
  owner "root"
  group "root"
  mode "600"
  manage_symlink_source true
  action :create
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
  action :run
  not_if "grep -q /SINGLE/s/sushell/sulogin/ /etc/sysconfig/init"
end

ruby_block "insert_line_prompt" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysconfig/init")
    file.insert_line_if_no_match("/PROMPT/s/yes/no/", "/PROMPT/s/yes/no/")
    file.write_file
  end
  action :run
  not_if "grep -q /PROMPT/s/yes/no/ /etc/sysconfig/init"
end

# 1.5.5 Disable Interactive Boot. The PROMPT option provides console users the 
# ability to interactively boot the system and select which services to start on 
# boot. Set the PROMPT parameter in /etc/sysconfig/init to no. PROMPT=no
ruby_block "set_promp_no" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sysconfig/init")
    file.search_file_replace_line("PROMPT=yes", "PROMPT=no")
    file.write_file
  end
  action :run
  not_if "grep -q PROMPT=no /etc/sysconfig/init"
end

template "/boot/grub/grub.conf" do
  source "grub.conf.erb"
  owner "root"
  group "root"
  mode 0600
  sensitive true
end