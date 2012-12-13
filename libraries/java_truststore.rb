#
# Cookbook Name:: java-management
# Library:: java_truststore
#
# Copyright 2012
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

class Chef::Recipe::JavaTruststore
  def self.import_trustcacert(certalias,certificate_file)
    execute "import_trustcacert_#{certalias}" do
      command "#{node['java-management']['keytool']} -importcert -noprompt -trustcacerts -alias #{certalias} -file #{certificate_file} -keystore #{node['java-management']['truststore']} -storepass #{node['java-management']['storepass']}"
      action :run
      only_if { File.exists?(certificate_file) }
      not_if "#{node['java-management']['keytool']} -list -alias #{certalias} -keystore #{node['java-management']['truststore']} -storepass #{node['java-management']['storepass']}"
    end
  end
end
