#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

filename = "redis-3.0.3"

packages = [
  "gcc",
  "gcc-c++",
  "make",
  "autoconf",
].each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "/tmp/#{filename}.tar.gz" do
  owner 'root'
  group 'root'
  mode '0644'
  source "http://download.redis.io/releases/#{filename}.tar.gz"
end

script 'setup redis' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    tar xzf #{filename}.tar.gz
    cd #{filename}
    make
    make install
    cd utils/
    ./install_server.sh
    cd ../src
    mv redis-benchmark /usr/bin
    mv redis-check-aof /usr/bin
    mv redis-check-dump /usr/bin
    mv redis-cli /usr/bin
    mv redis-sentinel /usr/bin
    mv redis-server /usr/bin
  EOH
end
