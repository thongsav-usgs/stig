#!/bin/bash
# Check for Presence of User .rhosts Files
#
# While no .rhosts files are shipped with
# RHEL/CentOS 6, users can easily create them.
# 
# This action is only meaningful if .rhosts
# support is permitted in the file /etc/pam.conf.
# Even though the .rhosts files are ineffective
# if support is disabled in /etc/pam.conf, they
# may have been brought over from other systems
# and could contain information useful to an
# attacker for those other systems.

for dir in `cat /etc/passwd | egrep -v '(root|halt|sync|shutdown)' |\
    awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
    for file in $dir/.rhosts; do
        if [ ! -h "$file" -a -f "$file" ]; then
            echo ".rhosts file in $dir"
        fi
    done
done