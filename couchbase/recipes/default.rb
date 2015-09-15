#
# Cookbook Name:: couchbase
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

rpm_filename = "couchbase-server-enterprise-3.1.0-centos6.x86_64.rpm"

cookbook_file "/tmp/#{rpm_filename}" do
  source rpm_filename
  owner 'root'
  group 'root'
  mode '0644'
end

rpm_package 'couchbase' do
  #provider	Chef::Provider::Package::Rpm
  source	"/tmp/#{rpm_filename}"
  #action	:install
end
