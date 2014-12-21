#!/bin/bash

# Check for Duplicate Group Names
# Although the groupadd program will not let you create a duplicate
# group name, it is possible for an administrator to manually edit
# the /etc/group file and change the group name.
#
# If a group is assigned a duplicate group name, it will create and
# have access to files with the first GID for that group in /etc/group.
# Effectively, the GID is shared, which is a security problem.

echo "The Output for the Audit of Control 9.2.19 - Check for Duplicate Group Names is"
cat /etc/group | cut -f1 -d":" | /bin/sort -n | /usr/bin/uniq -c |\
    while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        gids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 \
            /etc/group | xargs`
        echo "Duplicate Group Name ($2): ${gids}"
    fi
done