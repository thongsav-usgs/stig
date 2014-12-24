# Cookbook Name:: stig
# Recipe:: audit_scripts
# Author: Ivan Suftin <isuftin@usgs.gov>

# Generate audit directory in /root
directory "/root/.audit" do
  owner "root"
  group "root"
  mode 0600
end

# 9.1.12 Find SUID System Executables
# The owner of a file can set the file’s permissions to run
# with the owner’s or group’s permissions, even if the user
# running the program is not the owner or a member of the group.
# The most common reason for a SUID program is to enable users
# to perform functions (such as changing their password) that
# require root privileges.
#
# There are valid reasons for SUID programs, but it is important
# to identify and review such programs to ensure they are legitimate.
cookbook_file "find_suid_system_executables.sh" do
  user "root"
  group "root"
  path "/root/.audit/find_suid_system_executables.sh"
  mode 0700
end

# 9.1.13 Find SGID System Executables
# The owner of a file can set the file’s permissions to run with
# the owner’s or group’s permissions, even if the user running the
# program is not the owner or a member of the group. The most
# common reason for a SGID program is to enable users to perform
# functions (such as changing their password) that require root privileges.
#
# There are valid reasons for SGID programs, but it is important to identify
# and review such programs to ensure they are legitimate. Review the files
# returned by the action in the audit section and check to see if system
# binaries have a different md5 checksum than what from the package. This
# is an indication that the binary may have been replaced. The following
# is an example of checking the "sudo" executable:
# $ rpm -V `rpm -qf /usr/bin/sudo`
#   .......T  /usr/bin/sudo
#   SM5....T  /usr/bin/sudoedit
cookbook_file "find_sgid_system_executables.sh" do
  user "root"
  group "root"
  path "/root/.audit/find_sgid_system_executables.sh"
  mode 0700
end

# 9.2.6 Ensure root PATH Integrity
# The root user can execute any command on the
# system and could be fooled into executing programs
# unemotionally if the PATH is not set correctly.
#
# Including the current working directory (.) or
# other writable directory in root's executable
# path makes it likely that an attacker can gain
# superuser access by forcing an administrator
# operating as root to execute a Trojan horse program.
cookbook_file "path_integrity_check.sh" do
  user "root"
  group "root"
  path "/root/.audit/path_integrity_check.sh"
  mode 0700
end

# 9.2.10 Check for Presence of User .rhosts Files
# While no .rhosts files are shipped with RHEL6/CentOS,
# users can easily create them.
#
# This action is only meaningful if .rhosts support is
# permitted in the file /etc/pam.conf. Even though the
# .rhosts files are ineffective if support is disabled in
# /etc/pam.conf, they may have been brought over from other
# systems and could contain information useful to an
# attacker for those other systems.
cookbook_file "rhosts_check.sh" do
  user "root"
  group "root"
  path "/root/.audit/rhosts_check.sh"
  mode 0700
end

# 9.2.11 Check Groups in /etc/passwd
# Over time, system administration errors and 
# changes can lead to groups being defined in 
# /etc/passwd but not in /etc/group.
#
# Groups defined in the /etc/passwd file but not
# in the /etc/group file pose a threat to system
# security since group permissions are not properly managed.
cookbook_file "check_groups_in_etc_passwd.sh" do
  user "root"
  group "root"
  path "/root/.audit/check_groups_in_etc_passwd.sh"
  mode 0700
end

# 9.2.12 Check That Users Are Assigned Valid Home Directories
# Users can be defined in /etc/passwd without a home directory
# or with a home directory does not actually exist.
#
# If the user's home directory does not exist or is unassigned,
# the user will be placed in "/" and will not be able to write
# any files or have local environment variables set.
cookbook_file "validate_users_homedirs.sh" do
  user "root"
  group "root"
  path "/root/.audit/validate_users_homedirs.sh"
  mode 0700
end

# 9.2.15 Check for Duplicate UIDs
# Although the useradd program will not let you create a
# duplicate User ID (UID), it is possible for an administrator
# to manually edit the /etc/passwd file and change the UID field.
#
# Users must be assigned unique UIDs for accountability and to
# ensure appropriate access protections.
cookbook_file "check_duplicate_uid.sh" do
  user "root"
  group "root"
  path "/root/.audit/check_duplicate_uid.sh"
  mode 0700
end

# 9.2.16 Check for Duplicate GIDs
# Although the groupadd program will not let you create a duplicate
# Group ID (GID), it is possible for an administrator to manually
# edit the /etc/group file and change the GID field.
#
# User groups must be assigned unique GIDs for accountability and
# to ensure appropriate access protections.
cookbook_file "check_duplicate_gid.sh" do
  user "root"
  group "root"
  path "/root/.audit/check_duplicate_gid.sh"
  mode 0700
end

# 9.2.18 Check for Duplicate User Names
# Although the useradd program will not let you create a duplicate
# user name, it is possible for an administrator to manually edit
# the /etc/passwd file and change the user name.
#
# If a user is assigned a duplicate user name, it will create and
# have access to files with the first UID for that username in
# /etc/passwd. For example, if "test4" has a UID of 1000 and a 
# subsequent "test4" entry has a UID of 2000, logging in as "test4"
# will use UID 1000. Effectively, the UID is shared, which is
# a security problem.
cookbook_file "check_duplicate_usernames.sh" do
  user "root"
  group "root"
  path "/root/.audit/check_duplicate_usernames.sh"
  mode 0700
end

# 9.2.19 Check for Duplicate Group Names
# Although the groupadd program will not let you create a duplicate
# group name, it is possible for an administrator to manually edit
# the /etc/group file and change the group name.
#
# If a group is assigned a duplicate group name, it will create and
# have access to files with the first GID for that group in /etc/group.
# Effectively, the GID is shared, which is a security problem.
cookbook_file "check_duplicate_groupnames.sh" do
  user "root"
  group "root"
  path "/root/.audit/check_duplicate_groupnames.sh"
  mode 0700
end
