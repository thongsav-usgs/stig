#!/bin/bash

# Check That Users Are Assigned Valid Home Directories
# Users can be defined in /etc/passwd without a home directory
# or with a home directory does not actually exist.
#
# If the user's home directory does not exist or is unassigned,
# the user will be placed in "/" and will not be able to write
# any files or have local environment variables set.

cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
        if [ $uid -ge 500 -a ! -d "$dir" -a $user != "nfsnobody" ]; then
                echo "The home directory ($dir) of user $user does not exist."
        fi
done