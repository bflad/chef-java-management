#
# Cookbook Name:: java-management
# Provider:: truststore_certificate
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

action :import do
  # Since we can't use attributes in resource default values
  keystore = new_resource.keystore || "#{node['java']['java_home']}/jre/lib/security/cacerts"
  keytool = new_resource.keytool || "#{node['java']['java_home']}/jre/bin/keytool"
  storepass = new_resource.storepass || node['java-management']['truststore']['storepass']

  execute "import_trustcacert_#{new_resource.alias}" do
    command "#{keytool} -importcert -noprompt -trustcacerts -alias #{new_resource.alias} -file #{new_resource.file} -keystore #{keystore} -storepass #{storepass}"
    action :run
    only_if { ::File.exist?(new_resource.file) }
    not_if "#{keytool} -list -alias #{new_resource.alias} -keystore #{keystore} -storepass #{storepass}"
  end
  new_resource.updated_by_last_action(true)
end
