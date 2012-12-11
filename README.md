# chef-java-management [![Build Status](https://secure.travis-ci.org/bflad/chef-java-management.png?branch=master)](http://travis-ci.org/bflad/chef-java-management)

## Description

Cookbook for Java Management and Monitoring (JMX, trusted certificates, SNMP, etc.)

## Requirements

### Platforms

* RedHat 6.3

### Cookbooks

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* java

## Attributes

* `node['java-management']['enableThreadContentionMonitoring']` - defaults to
  false
* `node['java-management']['owner']` - defaults to "nobody"
* `node['java-management']['group']` - defaults to "bin"

### JMX Attributes

* `node['java-management']['jmxremote']['access_file']` - define custom JMX
  access file, defaults to nothing
* `node['java-management']['jmxremote']['authenticate']` - require
  authentication to access JMX, defaults to true
* `node['java-management']['jmxremote']['local_only']` - for allowing the local
  management agent to accept local and remote connection requests, defaults to
  true
* `node['java-management']['jmxremote']['login_config']` - define custom
  JMX login configuration, defaults to nothing
* `node['java-management']['jmxremote']['password_file']` - define custom JMX
  password configuration file, defaults to nothing
* `node['java-management']['jmxremote']['port']` - port for JMX, _required_ for
  enabling JMX, defaults to nothing 
* `node['java-management']['jmxremote']['ssl']` - for RMI monitoring without
  SSL, set to false, defaults to true
* `node['java-management']['jmxremote']['ssl_config_file']` - for supplying the
  keystore settings in a file, defaults to nothing
* `node['java-management']['jmxremote']['ssl_enabled_cipher_suites']` - 
  comma-separated list of SSL/TLS cipher suites to enable, defaults to nothing
* `node['java-management']['jmxremote']['ssl_enabled_protocols']` - 
  comma-separated list of SSL/TLS protocol versions to enable, defaults to
  nothing
* `node['java-management']['jmxremote']['ssl_need_client_auth']` - SSL/TLS RMI
  Server Socket Factory will require client authentication, defaults to false
* `node['java-management']['jmxremote']['registry_ssl']` - for using an SSL/TLS
  protected RMI registry, defaults to false

### SNMP Attributes

* `node['java-management']['snmp']['acl']` - require ACL for SNMP access,
  defaults to true
* `node['java-management']['snmp']['acl_file']` - for a custom SNMP ACL
  file location, defaults to nothing
* `node['java-management']['snmp']['interface']` - interface where SNMP agent
  will bind, defaults to "localhost"
* `node['java-management']['snmp']['port']` - port for SNMP, _required_ for
  enabling SNMP, defaults to nothing
* `node['java-management']['snmp']['trap']` - SNMP trap port, defaults to 162

## Encrypted Data Bags

`java/management` encrypted data bag:

* `['jmxremote']['roles']` - _required_ if you enable default JMX configuration
  * `['name']` - JMX role name
  * `['access']` - "readonly"/"readwrite"
  * `['password']` - password for role
* `['snmp']['acls']` - _required_ if you enable default SNMP configuration
  * `['communities']` - array of SNMP community names
  * `['access']` - "read-only"/"read-write"
  * `['managers']` - array of hostnames/CIDR addresses with access
* `['snmp']['traps']`
  * `['trap-community']` - SNMP trap community name
  * `['hosts']` - array of hostnames/CIDR addresses to send SNMP traps

`java/certificates` encrypted data bag:
* `['trustcacerts']` - hash of trusted CA certificates
  * `{'ALIAS': 'CA_CERTIFICATE_CONTENTS'}` - trusted CA certificate

## Recipes

* `recipe[java-management]` Configures Java JMX, trusted certificates, and SNMP

## Usage

### Add Trusted CA Certificates ###

* `knife data bag create java`
* `knife data bag edit java certificates --secret-file=path/to/secret`
* Add `{"ALIAS": "CA_CERTIFICATE_CONTENTS"}` entries as necessary in `trustcacerts` hash

### Password secured remote JMX setup without SSL

* `knife data bag create java`
* `knife data bag edit java management --secret-file=path/to/secret`
* Set `['jmxremote']['roles']` with at least one role in encrypted data bag
* Set `node['java-management']['jmxremote']['local_only']` attribute to false
* Set `node['java-management']['jmxremote']['port']` attribute
* Set `node['java-management']['jmxremote']['ssl']` attribute to false
* Add `recipe[java-management]` to run_list
* Configure JAVA_OPTS to include _one_ of the following:
  * __recommended__ `-Dcom.sun.management.config.file` (example:
  `=$JAVA_HOME/jre/lib/management/management.properties`)
  * `-Dcom.sun.management.jmxremote.port`
* Restart Java service and watch for configuration errors

### ACL secured remote SNMP 

* `knife data bag create java`
* `knife data bag edit java management --secret-file=path/to/secret`
* Set `['snmp']['acls']` with at least one ACL in encrypted data bag
* Set `node['java-management']['snmp']['interface']` attribute to "0.0.0.0"
* Set `node['java-management']['snmp']['port']` attribute
* Add `recipe[java-management]` to run_list
* Configure JAVA_OPTS to include _one_ of the following:
  * __recommended__ `-Dcom.sun.management.config.file` (example:
  `=$JAVA_HOME/jre/lib/management/management.properties`)
  * `-Dcom.sun.management.snmp.port`
* Restart Java service and watch for configuration errors

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
