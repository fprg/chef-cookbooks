#
# Cookbook Name:: go
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

directory '/opt/ogx' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/opt/gox/Gomfile' do
  source 'gox_Gomfile.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

script 'install gox' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    cd /opt/gox/
    gom install
  EOH
end