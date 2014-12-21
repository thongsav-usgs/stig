#!/bin/bash

# Check Groups in /etc/passwd

# Over time, system administration errors and 
# changes can lead to groups being defined in 
# /etc/passwd but not in /etc/group.
#
# Groups defined in the /etc/passwd file but not
# in the /etc/group file pose a threat to system
# security since group permissions are not properly managed.

for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
  grep -q -P "^.*?:x:$i:" /etc/group
  if [ $? -ne 0 ]; then
    echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
  fi
done