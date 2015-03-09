#!/bin/bash

# Check for Duplicate UIDs
# Although the useradd program will not let you create a
# duplicate User ID (UID), it is possible for an administrator
# to manually edit the /etc/passwd file and change the UID field.
#
# Users must be assigned unique UIDs for accountability and to
# ensure appropriate access protections.

echo "The Output for the Audit of Control 9.2.15 - Check for Duplicate UIDs is: "
cat /etc/passwd | cut -f3 -d":" | sort -n | /usr/bin/uniq -c |\
    while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        users=`gawk -F: '($3 == n) { print $1 }' n=$2 \
            /etc/passwd | xargs`
        echo "Duplicate UID ($2): ${users}"
    fi
done