#
# Cookbook Name:: vault
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

############
# install vault
############
package 'zlib' do
  action :install
end

remote_file '/tmp/vault.zip' do
  owner 'root'
  group 'root'
  mode '0644'
  source "https://releases.hashicorp.com/vault/#{node.vault.install_version}/vault_#{node.vault.install_version}_linux_amd64.zip"
end

script 'setup vault' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    unzip vault.zip
    mv ./vault /usr/local/bin
  EOH
end

############
# setup vault service
############
group 'vault' do
  action :create
  gid node.vault.gid
end

user 'vault' do
  action :create
  comment 'vault user'
  uid node.vault.uid
  gid node.vault.gid
  group 'vault'
end

template '/etc/init.d/vault' do
  source 'init-script.erb'
  owner 'vault'
  group 'vault'
  mode '0755'
end

directory "#{node.vault.config_dir}" do
  owner 'vault'
  group 'vault'
  mode '0755'
  action :create
end

template '/etc/vault/vault.json' do
  source 'vault.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'vault' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
