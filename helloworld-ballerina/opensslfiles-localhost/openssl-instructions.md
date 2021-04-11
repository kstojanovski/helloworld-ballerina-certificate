# How to create the certificate

## Step by step description

1. create the key.
winpty openssl genrsa -out ballerina.key

2. create certificate request file.
winpty openssl req -new -key ballerina.key -out ballerina.csr

3. create the certificate file.
winpty openssl x509 -req -days 365 -in ballerina.csr -signkey ballerina.key -out ballerina.crt

4. create ballerina.p12 with the ballerina.key.
winpty openssl pkcs12 -export -out ballerina.p12 -inkey ballerina.key -in ballerina.crt

5. create empty ballerina-truststore.p12 with no keys.
winpty openssl pkcs12 -export -nokeys -in ballerina.crt -out ballerina-truststore.p12

6. import the certificate into the trusted keystore.
keytool -import -file ballerina.crt -keystore ballerina-truststore.p12

## If the certificate expires.
* If the certificate expiries repeat steps 2 to 6. Creating new key for this examples is not necessary.

## Note
* strange case if creating the truststore with the key.
* if using this way then the file listed looks like the ballerina.p12 file. Id doens't list struster sert but private key.
* create ballerina-truststore.p12 with the ballerina.key
* winpty openssl pkcs12 -export -inkey ballerina.key -in ballerina.crt -out ballerina-truststore.p12

## List the content
* winpty openssl pkcs12 -in ballerina.p12 -info
* keytool -import -file ballerina.crt -keystore ballerina-truststore.p12

## Some listing commands
* keytool -list -storetype PKCS12 -keystore ballerina.12 -storepass ballerina
* keytool -importcert -storetype PKCS12 -keystore ballerina-truststore.p12 -storepass ballerina -alias ca -file ballerina.key -noprompt
* keytool -list -storetype PKCS12 -keystore ballerina-truststore.p12 -storepass ballerina

## Some listing commands
* Example
  * winpty openssl pkcs12 -info -in keystore.p12
* On this project:
  * winpty openssl pkcs12 -info -in ballerina-truststore.p12

## Print the expire date of the certificate
* Examples:
  * openssl x509 -req -in ballerina.csr -signkey ballerina.key -out ballerina.crt
  * openssl x509 -enddate -noout -in server.crt
* On this project:
  * openssl x509 -req -in ballerina.csr -signkey ballerina.key -out ballerina.crt

## List the key store cotnent
keytool -list -keystore ballerina-truststore.p12

## Glossary
* keytool manages a keystore (database) of cryptographic keys, X.509 certificate chains, and trusted certificates. It is a tool as part of the java installation.
* openssl is a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library.
