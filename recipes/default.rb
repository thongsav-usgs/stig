#
# Cookbook Name:: stig
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# 1.1.2, 1.1.3, 1.1.4
include_recipe "stig::fstab_tmp"

# 1.3.1, 1.3.2
include_recipe "stig::aide"

# 1.4.*
# Already passing at default install. notes are in "stig::selinux.rb"

# 1.5.1-5
include_recipe "stig::boot_settings"

# 1.6.1-3
include_recipe "stig::proc_hard"

# 1.1.18 - 1.1.24
include_recipe "stig::mount_disable"

# 3.3
include_recipe "stig::avahi_daemon"

# 3.5
include_recipe "stig::packages"
