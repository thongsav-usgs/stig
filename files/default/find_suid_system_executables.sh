#!/bin/bash

# Find SUID System Executables
# The owner of a file can set the file’s permissions to run
# with the owner’s or group’s permissions, even if the user
# running the program is not the owner or a member of the group.
# The most common reason for a SUID program is to enable users
# to perform functions (such as changing their password) that
# require root privileges.
#
# There are valid reasons for SUID programs, but it is important
# to identify and review such programs to ensure they are legitimate.

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -4000 -print