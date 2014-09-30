#
# Cookbook Name:: java-management
# Recipe:: truststore
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

begin
  truststore_data_bag = data_bag(node['java-management']['truststore']['data_bag'])
rescue
  Chef::Log.info("Java truststore data bag (#{node['java-management']['truststore']['data_bag']}) not found.")
ensure
  truststore_data_bag ||= []
end

truststore_data_bag.each do |certalias|
  options = data_bag_item(node['java-management']['truststore']['data_bag'], certalias)
  certificate_file = "#{node['java']['java_home']}/jre/lib/security/truststore-#{certalias}.pem"

  file certificate_file do
    action :create
    owner 'root'
    group 'root'
    mode 0644
    content options['certificate']
  end

  java_management_truststore_certificate certalias do
    file certificate_file
    keystore options['keystore'] if options['keystore']
    keytool options['keytool'] if options['keytool']
    storepass options['storepass'] if options['storepass']
  end
end

node['java-management']['truststore']['certificate_files'].each_pair do |certalias, options|
  java_management_truststore_certificate certalias do
    if options.is_a?(String)
      file options
    else
      file options['file']
      keystore options['keystore'] if options['keystore']
      keytool options['keytool'] if options['keytool']
      storepass options['storepass'] if options['storepass']
    end
  end
end
