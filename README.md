# chef-java-management [![Build Status](https://secure.travis-ci.org/bflad/chef-java-management.png?branch=master)](http://travis-ci.org/bflad/chef-java-management)

## Description

Cookbook for Java Management and Monitoring (JMX, trusted certificates, SNMP, etc.)

## Requirements

### Platforms

* CentOS 6
* RedHat 6

### Cookbooks

Required [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [java](https://github.com/opscode-cookbooks/java/)

## Attributes

These attributes are under the `node['java-management']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
enableThreadContentionMonitoring | Enables thread contention monitoring | Boolean | false
group | Group for file permissions | String | bin
owner | Owner for file permissions | String | nobody

### JMX Attributes

These attributes are under the `node['java-management']['jmxremote']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
access_file | Custom JMX access file location | String | nil
authenticate | Require authentication to access JMX | Boolean | true
local_only | Allow local management agent to accept only local connection requests | Boolean | true
login_config | Custom JMX login configuration | String | nil
password_file | Custom JMX password configuration file location | String | nil
port | Port for JMX, _required_ for enabling JMX | Fixnum | nil
ssl | RMI monitoring SSL | Boolean | true
ssl_config_file | RMI monitoring SSL configuration file location | String | nil
ssl_enabled_cipher_suites | Comma-separated list of SSL/TLS cipher suites to enable | String | nil
ssl_enabled_protocols | Comma-separated list of SSL/TLS protocol versions to enable | String | nil
ssl_need_client_auth| Require client authentication for SSL/TLS RMI Server Socket Factory | Boolean | false
registry_ssl | SSL/TLS protected RMI registry | Boolean | false

### SNMP Attributes

These attributes are under the `node['java-management']['snmp']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
acl | Require ACL for SNMP access | Boolean | true
acl_file | Custom SNMP ACL file location | String | nil
interface | Interface where SNMP agent will bind | String | "localhost"
port | Port for SNMP, _required_ for enabling SNMP | Fixnum | nil
trap | Port for SNMP traps | Fixnum | 162

### Truststore Attributes

These attributes are under the `node['java-management']['truststore']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
certificate_files | Trusted certificates files | Array of Hashes | []
data_bag | Trusted certificate data bag name | String | "java_truststore"
storepass | Java truststore password | String | "changeit"

## Data Bags

### JMX/SNMP Management Encrypted Data Bag

`java/management` encrypted data bag:

* `['roles']` - _required_ if you enable default JMX configuration
  * `['name']` - JMX role name
  * `['access']` - "readonly"/"readwrite"
  * `['password']` - password for role
* `['acls']` - _required_ if you enable default SNMP configuration
  * `['communities']` - array of SNMP community names
  * `['access']` - "read-only"/"read-write"
  * `['managers']` - array of hostnames/CIDR addresses with access
* `['traps']`
  * `['trap-community']` - SNMP trap community name
  * `['hosts']` - array of hostnames/CIDR addresses to send SNMP traps

### Truststore Data Bag

`node['java-management']['truststore']['data_bag']` data bag (defaults to `java_truststore`), with data bag items:
  * `['id']` - Trusted certificate alias
  * `['certificate']` - Trusted certificate contents
  * Other options as accepted by truststore_certificate LWRP

## Recipes

* `recipe[java-management]` Empty recipe for LWRPs
* `recipe[java-management::management]` Configures Java JMX and SNMP
* `recipe[java-management::truststore]` Configures Java truststore

## LWRPs

### java_management_truststore_certificate

Import trusted certificate into Java truststore

Attribute | Description | Type | Default
----------|-------------|------|--------
file | _required_ Certificate path | String | N/A
keystore | Keystore path | String | `#{node['java']['java_home']}/jre/lib/security/cacerts`
keytool | keytool path | String | `#{node['java']['java_home']}/jre/bin/keytool`
storepass | Keystore password | String | `#{node['java-management']['truststore']['storepass']}`

Example:

    java_management_truststore_certificate "alias" do
      file "/path/to/certificate"
    end

## Usage

### Add Trusted Certificates ###

If the certificate files are already on the filesystem:

* Add `{certalias => options}` to `node['java-management']['truststore']['certificate_files']`
  * `options` (as a String) certificate file location
  * `options` (as a Hash)
    * `file` _required_ certificate file location
    * Other options accepted by truststore_certificate LWRP

If you'd like to use data bag items (data bag defined by `node['java-management']['truststore']['data_bag']`):

* `knife data bag create java_truststore my_cert`
* Create _at least_ `certificate` attribute with certificate contents and save

If you'd like to use the LWRP directly:

    java_management_truststore_certificate "alias" do
      file "/path/to/certificate"
    end

### Password secured remote JMX setup without SSL

* `knife data bag create java`
* `knife data bag edit java management --secret-file=path/to/secret`
* Set `['roles']` with at least one role in encrypted data bag
* Set `node['java-management']['local_only']` attribute to false
* Set `node['java-management']['port']` attribute
* Set `node['java-management']['ssl']` attribute to false
* Add `recipe[java-management::management]` to run_list
* Configure JAVA_OPTS to include _one_ of the following:
  * __recommended__ `-Dcom.sun.management.config.file` (example:
  `=$JAVA_HOME/jre/lib/management/management.properties`)
  * `-Dcom.sun.management.jmxremote.port`
* Restart Java service and watch for configuration errors

### ACL secured remote SNMP 

* `knife data bag create java`
* `knife data bag edit java management --secret-file=path/to/secret`
* Set `['acls']` with at least one ACL in encrypted data bag
* Set `node['java-management']['interface']` attribute to "0.0.0.0"
* Set `node['java-management']['port']` attribute
* Add `recipe[java-management::management]` to run_list
* Configure JAVA_OPTS to include _one_ of the following:
  * __recommended__ `-Dcom.sun.management.config.file` (example:
  `=$JAVA_HOME/jre/lib/management/management.properties`)
  * `-Dcom.sun.management.snmp.port`
* Restart Java service and watch for configuration errors

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-omnibus
    git clone git://github.com/bflad/chef-java-management.git
    cd chef-java-management
    vagrant up BOX # BOX being centos5, centos6, debian7, fedora18, fedora19, fedora20, freebsd9, ubuntu1204, ubuntu1210, ubuntu1304, or ubuntu1310

You can then SSH into the running VM using the `vagrant ssh BOX` command.

The VM can easily be stopped and deleted with the `vagrant destroy` command. Please see the official [Vagrant documentation](http://docs.vagrantup.com/v2/cli/index.html) for a more in depth explanation of available commands.

## Contributing

Please use standard Github pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Author

Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012-2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
