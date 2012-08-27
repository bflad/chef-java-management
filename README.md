# DESCRIPTION:

Cookbook for Java Management (JMX, SNMP, etc.)

_NOTE: THIS COOKBOOK IS CURRENTLY UNDER HEAVY ACTIVE DEVELOPMENT_
_AND NOT RECOMMENDED FOR EVEN BETA TESTING YET._

# REQUIREMENTS:

## Cookbooks:

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* java

# USAGE:

Create a java/management encrypted data bag with the following information per
Chef environment:
* TBD

Repeat for other Chef environments as necessary. Example:

    {
      "id": "management"
      "development": {
        "key": "value"
      }
    }

Add recipe[java-management] to your run_list and get on your merry way.

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