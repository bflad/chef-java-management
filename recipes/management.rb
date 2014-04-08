#
# Cookbook Name:: java-management
# Recipe:: management
#
# Copyright 2012-2013
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# rubocop:disable RescueException
begin
  configuration_data_bag = Chef::EncryptedDataBagItem.load('java', 'management')
  if configuration_data_bag[node.chef_environment]['jmxremote']
    jmxremote_roles = configuration_data_bag[node.chef_environment]['jmxremote']['roles']
  end
  if configuration_data_bag[node.chef_environment]['snmp']
    snmp_acls = configuration_data_bag[node.chef_environment]['snmp']['acls']
    snmp_traps = configuration_data_bag[node.chef_environment]['snmp']['traps']
  end
rescue Exception
  Chef::Log.debug('java/management encrypted databag not found')
end
# rubocop:enable RescueException

template "#{node['java']['java_home']}/jre/lib/management/jmxremote.access" do
  source 'jmxremote.access.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables :roles => jmxremote_roles
end

template "#{node['java']['java_home']}/jre/lib/management/jmxremote.password" do
  source 'jmxremote.password.erb'
  owner node['java-management']['owner']
  group node['java-management']['group']
  mode '0400'
  variables :roles => jmxremote_roles
end

template "#{node['java']['java_home']}/jre/lib/management/management.properties" do
  source 'management.properties.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{node['java']['java_home']}/jre/lib/management/snmp.acl" do
  source 'snmp.acl.erb'
  owner node['java-management']['owner']
  group node['java-management']['group']
  mode '0400'
  variables :acls => snmp_acls, :traps => snmp_traps
end
