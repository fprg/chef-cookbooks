#
# Cookbook Name:: go
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

script 'install gom' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    source /etc/profile.d/go.sh
    go get github.com/mattn/gom
  EOH
end
