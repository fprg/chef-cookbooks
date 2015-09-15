#
# Cookbook Name:: consul
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

############
# install consul
############
package 'zlib' do
  action :install
end

remote_file '/tmp/consul.zip' do
  owner 'root'
  group 'root'
  mode '0644'
  source "https://dl.bintray.com/mitchellh/consul/#{node.consul.install_version}_linux_amd64.zip"
end

script 'setup consul' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    unzip consul.zip
    mv ./consul /usr/bin
  EOH
end

############
# setup consul service
############
group 'consul' do
  action :create
  gid node.consul.gid
end

user 'consul' do
  action :create
  comment 'consul user'
  uid node.consul.uid
  gid node.consul.gid
  group 'consul'
end

template '/etc/init.d/consul' do
  source 'init-script.erb'
  owner 'consul'
  group 'consul'
  mode '0755'
end

template '/etc/sysconfig/consul' do
  source 'sysconfig.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

directory "#{node.consul.config_dir}" do
  owner 'consul'
  group 'consul'
  mode '0755'
  action :create
end

directory "#{node.consul.data_dir}" do
  owner 'consul'
  group 'consul'
  mode '0755'
  action :create
end


