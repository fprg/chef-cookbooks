#
# Cookbook Name:: go
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

go_version = "1.5"

package 'git' do
  action :install
end

git '/home/ec2-user/.goenv' do
  repository 'git://github.com/wfarr/goenv.git'
  revision 'master'
  action :checkout
end

template '/etc/profile.d/goenv.sh' do
  source 'profile.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

script 'install go' do
  interpreter 'bash'
  user 'ec2-user'
  cwd '/tmp'
  code <<-EOH
    /opt/goenv/bin/goenv install #{go_version} 
    /opt/goenv/bin/goenv global #{go_version}
    /opt/goenv/bin/goenv rehash
  EOH
end
