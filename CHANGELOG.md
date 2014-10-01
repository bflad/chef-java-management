## 1.0.3

* [#3][]: Fix typo with String truststore certifcate_files attribute

## v1.0.2

* Fix for truststore_certificate provider attribute setting

## v1.0.1

* Move truststore_certificate default attribute logic to provider since its not available during compilation phase

## v1.0.0

* truststore_certificate LWRP per-resource attributes instead of cookbook specific node attributes
* `node['java-management']['truststore']['certificate_files']` hashes and truststore data bag items can now specify keystore, keytool, and storepass options
* Removed attributes (to avoid multiple attribute changes when changing `node['java']['java_home']`):
  * `node['java-management']['keytool']`
  * `node['java-management']['management_dir']`
  * `node['java-management']['security_dir']`
  * `node['java-management']['truststore']`
* Sample Vagrant setup for testing

## v0.3.2

* Set JMX/SNMP default port attributes to nil instead of ""

## v0.3.1 ##

* Fix to use Ruby File.exists? again in truststore_certificate LWRP

## v0.3.0 ##

* Refactored management into its own recipe
* Refactored truststore into its own recipe
* New truststore_certificate LWRP
* Use optional unencrypted data bag items for truststore certificates

## v0.2.2 ##

* Fixed not_if for trusted CA certificate import to include full path to cacerts
* Refactored Java security directory and store password for trusted CA certificate import

## v0.2.1 ##

* Fix for missing certificates data bag

## v0.2.0 ##

* Initial trusted certificate handling

## v0.1.3 ##

* Use template variables instead of saving node attributes

## v0.1.2

* Fixed minitest helpers module name

## v0.1.1

* Added basic minitests

## v0.1.0

* Initial beta release with Java SNMP and JMX management.

[#3]: https://github.com/bflad/chef-java-management/issues/3
