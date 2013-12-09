#
# Cookbook Name:: java-management
# Attributes:: java-management
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

default['java-management']['enableThreadContentionMonitoring'] = false
default['java-management']['group'] = 'bin'
default['java-management']['owner'] = 'nobody'

# JMX
# Set port attribute and define ACL/SSL
default['java-management']['jmxremote']['access_file'] = ''
default['java-management']['jmxremote']['authenticate'] = true
default['java-management']['jmxremote']['local_only'] = true
default['java-management']['jmxremote']['login_config'] = ''
default['java-management']['jmxremote']['password_file'] = ''
default['java-management']['jmxremote']['port'] = nil
default['java-management']['jmxremote']['ssl'] = true
default['java-management']['jmxremote']['ssl_config_file'] = ''
default['java-management']['jmxremote']['ssl_enabled_cipher_suites'] = ''
default['java-management']['jmxremote']['ssl_enabled_protocols'] = ''
default['java-management']['jmxremote']['ssl_need_client_auth'] = false
default['java-management']['jmxremote']['registry_ssl'] = false

# SNMP
# Set port attribute and define ACL to enable SNMP
default['java-management']['snmp']['acl'] = true
default['java-management']['snmp']['acl_file'] = ''
default['java-management']['snmp']['interface'] = 'localhost'
default['java-management']['snmp']['port'] = nil
default['java-management']['snmp']['trap'] = 162

# Truststore
default['java-management']['truststore']['certificate_files'] = {}
default['java-management']['truststore']['data_bag'] = 'java_truststore'
default['java-management']['truststore']['storepass'] = 'changeit'
