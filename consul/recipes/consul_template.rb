#
# Cookbook Name:: consul
# Recipe:: consul-template
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'git' do
  action :install
end

directory '/opt/consul-template' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

git '/opt/consul-template' do
  repository 'git://github.com/hashicorp/consul-template.git'
  revision 'master'
  action :checkout
end

script 'install consul-template' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    source /etc/profile.d/go.sh
    cd /opt/consul-template
    make
  EOH
end

template '/etc/profile.d/consul-template.sh' do
  source 'consul-template.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
