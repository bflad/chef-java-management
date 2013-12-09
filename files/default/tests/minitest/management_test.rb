require File.expand_path('../support/helpers', __FILE__)

describe_recipe 'java-management::default' do
  include Helpers::JavaManagement

  # configuration_data_bag = Chef::EncryptedDataBagItem.load("java","management")

  it 'creates Java JMX Access File' do
    file("#{node['java']['java_home']}/jre/lib/management/jmxremote.access").must_exist
  end

  it 'creates Java JMX Password File' do
    file("#{node['java']['java_home']}/jre/lib/management/jmxremote.password").must_exist.with(:owner, node['java-management']['owner'])
  end

  it 'creates Java Management Properties File' do
    file("#{node['java']['java_home']}/jre/lib/management/management.properties").must_exist
  end

  it 'creates Java SNMP Access File' do
    file("#{node['java']['java_home']}/jre/lib/management/snmp.acl").must_exist.with(:owner, node['java-management']['owner'])
  end

end
