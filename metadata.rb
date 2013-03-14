name              "java-management"
maintainer        "Brian Flad"
maintainer_email  "bflad@wharton.upenn.edu"
license           "Apache 2.0"
description       "Java Management Cookbook"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.2"
recipe            "java-management", "Empty recipe"
recipe            "java-management::management", "Java Management"
recipe            "java-management::truststore", "Java Truststore Management"

%w{ amazon centos redhat scientific }.each do |os|
  supports os
end

%w{ java }.each do |cb|
  depends cb
end
