# Cookbook Name:: stig
# Recipe:: audits
# Author: Ivan Suftin <isuftin@usgs.gov>

# 9.1.9 Find World Writable Files
# Unix-based systems support variable settings to control access to files.
# World writable files are the least secure. See the chmod(2) man page for
# more information.
#
# Data in world-writable files can be modified and compromised by any user
# on the system. World writable files may also indicate an incorrectly
# written script or program that could potentially be the cause of a larger
# compromise to the system's integrity.
bash "remove_world_writable_flag_from_files" do
  user "root"
  code "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002);do chmod o-w $fn;done"
  only_if "test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002)\"", :user => "root" 
end
  
# 9.1.10 Find Un-owned Files and Directories
# Sometimes when administrators delete users from the password file they
# neglect to remove all files owned by those users from the system.
#
# A new user who is assigned the deleted user's user ID or group ID may
# then end up "owning" these files, and thus have more access on the system
# than was intended.
bash "reclaim_ownership_of_orphaned_files_and_dirs" do
  user "root"
  code "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls | awk '{ printf $11\"\\n\" }'); do chown root:root $fn;done"
  only_if "test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls)\"", :user => "root"
end
  
  
# 9.1.11 Find Un-grouped Files and Directories
# Sometimes when administrators delete users from the password file they
# neglect to remove all files owned by those users from the system.
#
# A new user who is assigned the deleted user's user ID or group ID may
# then end up "owning" these files, and thus have more access on the system 
# than was intended.
bash "find group orphaned files and directories" do
  user "root"
  code "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup -ls | awk '{ printf $11\"\\n\" }'); do chown root:root $fn;done"
  only_if "test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup -ls)\"", :user => "root"
end
  
# 9.2.1 Ensure Password Fields are Not Empty
# An account with an empty password field means that anybody may log in as
# that user without providing a password.  
#
# All accounts must have passwords or be locked to prevent the account from
# being used by an unauthorized user.
bash "no_empty_passwd_fields" do
  user "root"
  code "for user in $(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\")' | cut -d':' -f1 $1);do /usr/bin/passwd -l $user;done"
  guard_interpreter :bash
  only_if "test -n \"$(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\" )')\"", :user => "root"
end

# 9.2.2 Verify No Legacy "+" Entries Exist in /etc/passwd File
# The character + in various files used to be markers for systems
#  to insert data from NIS maps at a certain point in a system
# configuration file. These entries are no longer required on 
# RHEL6/CentOS 6 systems, but may exist in files that have been
# imported from other platforms.
#
# These entries may provide an avenue for attackers to gain
# privileged access on the system.
bash "no legacy + entries exist in /etc/passwd" do
  user "root"
  code "sed -i '/^+/ d' /etc/passwd"
  guard_interpreter :bash
  only_if "test -n \"$(/bin/grep '^+' /etc/passwd)\"", :user => "root"
end

# 9.2.3 Verify No Legacy "+" Entries Exist in /etc/shadow File
# The character + in various files used to be markers for systems
# to insert data from NIS maps at a certain point in a system
# configuration file. These entries are no longer required on
# RHEL6/CentOS systems, but may exist in files that have been imported
# from other platforms.
#
# These entries may provide an avenue for attackers to gain privileged
# access on the system.
bash "no legacy + entries exist in /etc/shadow" do
  user "root"
  code "sed -i '/^+/ d' /etc/shadow"
  guard_interpreter :bash
  only_if "test -n \"$(/bin/grep '^+' /etc/shadow)\"", :user => "root"
end

# 9.2.4 Verify No Legacy "+" Entries Exist in /etc/group File
# The character + in various files used to be markers for systems
# to insert data from NIS maps at a certain point in a system
# configuration file. These entries are no longer required on
# RHEL6/CentOS systems, but may exist in files that have been
# imported from other platforms.
#
# These entries may provide an avenue for attackers to gain
# privileged access on the system.
bash "no legacy + entries exist in /etc/group" do
  user "root"
  code "sed -i '/^+/ d' /etc/group"
  guard_interpreter :bash
  only_if "test -n \"$(/bin/grep '^+' /etc/group)\"", :user => "root"
end

# 9.2.5 Verify No UID 0 Accounts Exist Other Than root
# Any account with UID 0 has superuser privileges on the system.
#
# This access must be limited to only the default root account
# and only from the system console. Administrative access must
# be through an unprivileged account using an approved mechanism
# as noted in Item 7.5 Restrict root Login to System Console.
bash "no UID 0 except root account exists" do
  user "root"
  code "for acct in $(/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' | grep -v \"root\"); do sed -i \"/^$acct:/ d\" /etc/passwd;done"
  guard_interpreter :bash
  only_if "/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' | grep -v \"root\"", :user => "root"
end