#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

remote_file '/tmp/install-redhat-td-agent2.sh' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'http://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh'
end

script 'edit sudoers requiretty' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers
  EOH
end

execute 'install td-agent2' do
  user 'root'
  command <<-EOH
    /tmp/install-redhat-td-agent2.sh
  EOH
end

execute 'setup td-agent config directory' do
  command 'mkdir /etc/td-agent/conf.d -m 755;echo "include conf.d/*.conf" >> /etc/td-agent/td-agent.conf'
  action :run
  not_if do ::File.exists?('/etc/td-agent/conf.d') end
end
