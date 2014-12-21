#!/bin/bash

# Check for Duplicate User Names
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

echo "The Output for the Audit of Control 9.2.18 - Check for Duplicate User Names is"
cat /etc/passwd | cut -f1 -d":" | /bin/sort -n | /usr/bin/uniq -c |\
while read x ; do
    [ -z "${x}" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        uids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 \
            /etc/passwd | xargs`
        echo "Duplicate User Name ($2): ${uids}"
    fi
done