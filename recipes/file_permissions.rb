# Cookbook Name:: stig
# Recipe:: hosts
# Author: Ivan Suftin <isuftin@usgs.gov>

# 6.1.3 Set User/Group Owner and Permission on /etc/anacrontab
# The /etc/anacrontab file is used by anacron to control its own
# jobs. The commands in this item make sure that root is the user
# and group owner of the file and is the only user that can read
# and write the file.
#
# This file contains information on what system jobs are run by
# anacron. Write access to these files could provide unprivileged
# users with the ability to elevate their privileges. Read access
# to these files could provide users with the ability to gain insight
# on system jobs that run on the system and could provide them a way
# to gain unauthorized privileged access.
file "/etc/anacrontab" do
  owner "root"
  group "root"
  mode 0600
end

# 6.1.4 Set User/Group Owner and Permission on /etc/crontab
# The /etc/crontab file is used by cron to control its own jobs.
# The commands in this item make here sure that root is the user
# and group owner of the file and is the only user that can read
# and write the file.
#
# This file contains information on what system jobs are run by
# cron. Write access to these files could provide unprivileged
# users with the ability to elevate their privileges. Read access
# to these files could provide users with the ability to gain insight
# on system jobs that run on the system and could provide them a way
# to gain unauthorized privileged access.
file "/etc/crontab" do
  owner "root"
  group "root"
  mode 0600
end

# 6.1.5 Set User/Group Owner and Permission on /etc/cron.hourly
# This directory contains system cron jobs that need to run on
# an hourly basis. The files in this directory cannot be
# manipulated by the crontab command, but are instead edited by
#system administrators using a text editor. The commands below
# restrict read/write and search access to user and group root,
# preventing regular users from accessing this directory.
#
# Granting write access to this directory for non-privileged
# users could provide them the means for gaining unauthorized
# elevated privileges. Granting read access to this directory
# could give an unprivileged user insight in how to gain elevated
# privileges or circumvent auditing controls.
directory "/etc/cron.hourly" do
  owner "root"
  group "root"
  mode 0700
end

# 6.1.6 Set User/Group Owner and Permission on /etc/cron.daily
# The /etc/cron.daily directory contains system cron jobs that
# need to run on a daily basis. The files in this directory
# cannot be manipulated by the crontab command, but are instead
# edited by system administrators using a text editor. The
# commands below restrict read/write and search access to user
# and group root, preventing regular users from accessing this
# directory.
#
# Granting write access to this directory for non-privileged
# users could provide them the means for gaining unauthorized
# elevated privileges. Granting read access to this directory
# could give an unprivileged user insight in how to gain
# elevated privileges or circumvent auditing controls.
directory "/etc/cron.daily" do
  owner "root"
  group "root"
  mode 0700
end

# 6.1.7 Set User/Group Owner and Permission on /etc/cron.weekly
# The /etc/cron.weekly directory contains system cron jobs that
# need to run on a weekly basis. The files in this directory
# cannot be manipulated by the crontab command, but are instead
# edited by system administrators using a text editor. The
# commands below restrict read/write and search access to
# user and group root, preventing regular users from accessing
# this directory.
#
# Granting write access to this directory for non-privileged
# users could provide them the means for gaining unauthorized
# elevated privileges. Granting read access to this directory
# could give an unprivileged user insight in how to gain elevated
# privileges or circumvent auditing controls.
directory "/etc/cron.weekly" do
  owner "root"
  group "root"
  mode 0700
end

# 6.1.8 Set User/Group Owner and Permission on /etc/cron.monthly
# The /etc/cron.monthly directory contains system cron jobs that
# need to run on a monthly basis. The files in this directory
# cannot be manipulated by the crontab command, but are instead
# edited by system administrators using a text editor. The commands
# below restrict read/write and search access to user and group
# root, preventing regular users from accessing this directory.
#
# Granting write access to this directory for non-privileged
# users could provide them the means for gaining unauthorized
# elevated privileges. Granting read access to this directory
# could give an unprivileged user insight in how to gain elevated
# privileges or circumvent auditing controls.
directory "/etc/cron.monthly" do
  owner "root"
  group "root"
  mode 0700
end

# 6.1.9 Set User/Group Owner and Permission on /etc/cron.d
# The /etc/cron.d directory contains system cron jobs that need
# to run in a similar manner to the hourly, daily weekly and 
# monthly jobs from /etc/crontab, but require more granular
# control as to when they run. The files in this directory
# cannot be manipulated by the crontab command, but are 
# instead edited by system administrators using a text
# editor. The commands below restrict read/write and
# search access to user and group root, preventing regular
# users from accessing this directory.
#
# Granting write access to this directory for non-privileged
# users could provide them the means for gaining unauthorized
# elevated privileges. Granting read access to this directory
# could give an unprivileged user insight in how to gain
# elevated privileges or circumvent auditing controls.
directory "/etc/cron.d" do
  owner "root"
  group "root"
  mode 0700
end

# 6.1.10 Restrict at Daemon
# The at daemon works with the cron daemon to allow
# non-privileged users to submit one time only jobs
# at their convenience. There are two files that
# control at: /etc/at.allow and /etc/at.deny. If
# /etc/at.allow exists, then users listed in the file
# are the only ones that can create at jobs. If
# /etc/at.allow does not exist and /etc/at.deny
# does exist, then any user on the system, with the
# exception of those listed in /etc/at.deny, are
# allowed to execute at jobs. An empty /etc/at.deny
# file allows any user to create at jobs. If neither
# /etc/at.allow nor /etc/at.deny exist, then only
# superuser can create at jobs. The commands below remove
# the /etc/at.deny file and create an empty /etc/at.allow
# file that can only be read and modified by user and group
# root.
#
# Granting write access to this directory for non-privileged users
# could provide them the means to gain unauthorized elevated privileges.
# Granting read access to this directory could give an unprivileged
# user insight in how to gain elevated privileges or circumvent
# auditing controls. In addition, it is a better practice to create
# a white list of users who can execute at jobs versus a blacklist of
# users who can’t execute at jobs as a system administrator will always
# know who can create jobs and does not have to worry about remembering
# to add a user to the blacklist when a new user id is created.

# NOTE: Using /etc/at.deny here like solaris and removing /etc/at.allow if exists
file "/etc/at.deny" do
  owner "root"
  group "root"
  mode 0700
end

file "/etc/at.allow" do
  action :delete
end