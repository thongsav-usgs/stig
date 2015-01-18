#
# Cookbook Name:: stig
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe "stig::fstab_tmp"

include_recipe "stig::aide"

include_recipe "stig::boot_settings"

include_recipe "stig::proc_hard"

include_recipe "stig::cis"

include_recipe "stig::avahi_daemon"

include_recipe "stig::ipv6"

include_recipe "stig::dhcp"

include_recipe "stig::mail_transfer_agent"

include_recipe "stig::hosts"

include_recipe "stig::rsyslog"

include_recipe "stig::logrotate"

include_recipe "stig::sshd_config"

include_recipe "stig::system-auth"

include_recipe "stig::login_defs"

include_recipe "stig::login_banner"

include_recipe "stig::file_permissions"

include_recipe "stig::audits"

include_recipe "stig::audit_scripts"

