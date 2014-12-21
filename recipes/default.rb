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
include_recipe "stig::cis"

# 3.3
include_recipe "stig::avahi_daemon"

# 3.5
include_recipe "stig::packages"

# 3.16
include_recipe "stig::mail_transfer_agent"

# 4.5.1 - 4.5.4
include_recipe "stig::hosts"

# 5.1.3
include_recipe "stig::rsyslog"

# 5.3 
include_recipe "stig::logrotate"

# 6.2.2 - 6.2.13
include_recipe "stig::sshd_config"

# 6.3.6
include_recipe "stig::system-auth"

# 7.2.1
include_recipe "stig::login_defs"

# 8.1
include_recipe "stig::login_banner"

# 6.1.3 - 6.1.10, 9.1.1 - 9.1.8
include_recipe "stig::file_permissions"

include_recipe "stig::audits"
