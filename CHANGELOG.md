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
