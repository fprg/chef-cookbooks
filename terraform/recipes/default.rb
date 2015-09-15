#
# Cookbook Name:: terraform
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'zlib' do
  action :install
end

remote_file '/tmp/terraform.zip' do
  owner 'root'
  group 'root'
  mode '0644'
  source "https://dl.bintray.com/mitchellh/terraform/terraform_#{node.terraform.install_version}_linux_amd64.zip"
end

script 'setup terraform' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    unzip terraform.zip
    mv ./terraform /usr/bin
  EOH
end

