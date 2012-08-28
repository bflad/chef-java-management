# DESCRIPTION:

Cookbook for Java Management and Monitoring (JMX, SNMP, etc.)

# REQUIREMENTS:

## Cookbooks:

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* java

# USAGE:

Create a java/management encrypted data bag with the following
information per Chef environment:
* ['jmxremote']['roles']: _required_ if you enable JMX
* ['snmp']['acls']: _required_ if you enable SNMP
* ['snmp']['traps']: _optional_

Repeat for other Chef environments as necessary. Example:

    {
      "id": "management"
      "production": {
        "jmxremote": {
          "roles": [
            {
              "name": "my-role",
              "access": "readonly",
              "password": "my-role-password"
            }
          ]
        },
        "snmp": {
          "acls": [
            {
              "communities": "my-community",
              "access": "read-only",
              "managers": [
                "server1",
                "10.0.0.0/21"
              ]
            }
          ]
        }
      }
    }

Set default_attribute for ports to enable JMX/SNMP. Add other attributes
as necessary. Basic example with remote JMX/SNMP enabled and JMX SSL disabled:

    "java-management" => {
      "jmxremote" => {
        "local_only" => false,
        "port" => "10061",
        "ssl" => false
      },
      "snmp" => {
        "interface" => "0.0.0.0",
        "port" => "10161"
      }
    }

Add recipe[java-management] to your run_list and configure your JAVA_OPTS to
include _one_ of the following:
* __recommended__ `-Dcom.sun.management.config.file`
    * For example: `=$JAVA_HOME/jre/lib/management/management.properties`
* `-Dcom.sun.management.jmxremote.port`
* `-Dcom.sun.management.snmp.port`

Restart your service and watch logs for JVM configuration issues.

# LICENSE and AUTHOR:
      
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