#!/bin/bash

# Find SGID System Executables
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

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000 -print