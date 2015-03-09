#!/bin/bash

# Check for Duplicate GIDs
# Although the groupadd program will not let you create a duplicate
# Group ID (GID), it is possible for an administrator to manually
# edit the /etc/group file and change the GID field.
#
# User groups must be assigned unique GIDs for accountability and
# to ensure appropriate access protections.

echo "The Output for the Audit of Control 9.2.16 - Check for Duplicate GIDs is: "
cat /etc/group | cut -f3 -d":" | sort -n | uniq -c |\
    while read x ; do
    [ -z "${x}" ] && break
    set - $x
        if [ $1 -gt 1 ]; then
            grps=`gawk -F: '($3 == n) { print $1 }' n=$2 \
                /etc/group | xargs`
            echo "Duplicate GID ($2): ${grps}"
        fi
    done