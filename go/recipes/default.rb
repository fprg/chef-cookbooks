#
# Cookbook Name:: go
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'golang' do
  action :install
end

directory '/opt/go' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/profile.d/go.sh' do
  source 'go.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
