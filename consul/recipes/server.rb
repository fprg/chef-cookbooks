#
# Cookbook Name:: consul
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

template '/etc/consul/consul.json' do
  source 'consul-server.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'consul' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
