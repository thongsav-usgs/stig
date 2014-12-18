u
# Cookbook Name:: stig
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# 1.1.2, 1.1.3, 1.1.4
include_recipe "stig::fstab_tmp"

# 1.3.1, 1.3.2
include_recipe "stig::aide"

# 1.5.3
include_recipe "stig::grub"
