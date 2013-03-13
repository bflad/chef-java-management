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
  execute "import_trustcacert_#{new_resource.alias}" do
    command "#{new_resource.keytool} -importcert -noprompt -trustcacerts -alias #{new_resource.alias} -file #{new_resource.file} -keystore #{new_resource.keystore} -storepass #{new_resource.storepass}"
    action :run
    only_if { ::File.exists?(new_resource.file) }
    not_if "#{new_resource.keytool} -list -alias #{new_resource.alias} -keystore #{new_resource.keystore} -storepass #{new_resource.storepass}"
  end
  new_resource.updated_by_last_action(true)
end
