#
# Cookbook Name:: serf
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

############
# install serf
############
package 'zlib' do
  action :install
end

remote_file '/tmp/serf.zip' do
  owner 'root'
  group 'root'
  mode '0644'
  source "https://releases.hashicorp.com/serf/#{node.serf.install_version}/serf_#{node.serf.install_version}_linux_amd64.zip"
end

script 'setup serf' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    unzip serf.zip
    mv ./serf /usr/local/bin
  EOH
end

############
# setup serf service
############
group 'serf' do
  action :create
  gid node.serf.gid
end

user 'serf' do
  action :create
  comment 'serf user'
  uid node.serf.uid
  gid node.serf.gid
  group 'serf'
end

template '/etc/init.d/serf' do
  source 'init-script.erb'
  owner 'serf'
  group 'serf'
  mode '0755'
end

directory "#{node.serf.config_dir}" do
  owner 'serf'
  group 'serf'
  mode '0755'
  action :create
end

template '/etc/serf/serf.json' do
  source 'serf.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'serf' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
