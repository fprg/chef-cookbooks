#
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

remote_file '/tmp/rundeck.rpm' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'http://repo.rundeck.org/latest.rpm'
end

# package 'java' do
#   action :install
# end

rpm_package 'rundeck' do
  source '/tmp/rundeck.rpm'
end

package 'rundeck' do
  action :install
end

script 'rundeck properties changes' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed -i -e "s/localhost/#{node.automatic.ec2.public_ipv4}/g" /etc/rundeck/framework.properties
    sed -i -e "s/localhost/#{node.automatic.ec2.public_ipv4}/g" /etc/rundeck/rundeck-config.properties
  EOH
end

service 'rundeckd' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
