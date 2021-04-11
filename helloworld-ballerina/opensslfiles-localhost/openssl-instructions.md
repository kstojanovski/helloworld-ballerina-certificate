# How to create the certificate

## Step by step description

1. create the key.<br>```winpty openssl genrsa -out ballerina.key```
1. create certificate request file.<br>```winpty openssl req -new -key ballerina.key -out ballerina.csr```
1. create the certificate file.<br>```winpty openssl x509 -req -days 365 -in ballerina.csr -signkey ballerina.key -out ballerina.crt```
1. create ballerina.p12 with the ballerina.key.<br>```winpty openssl pkcs12 -export -out ballerina.p12 -inkey ballerina.key -in ballerina.crt```
1. create empty ballerina-truststore.p12 with no keys.<br>```winpty openssl pkcs12 -export -nokeys -in ballerina.crt -out ballerina-truststore.p12```
1. import the certificate into the trusted keystore.<br>```keytool -import -file ballerina.crt -keystore ballerina-truststore.p12```

## If the certificate expires.
* If the certificate expiries repeat steps 2 to 6. Creating new key for this examples is not necessary.

## Note - possible invalid cotnent if creating the truststore with the key.
* if using this way then the file listed looks like the ballerina.p12 file. It doesn't list trusted cert but private key.
* create ballerina-truststore.p12 with the ballerina.key:<br>```winpty openssl pkcs12 -export -inkey ballerina.key -in ballerina.crt -out ballerina-truststore.p12```

## List the content
```winpty openssl pkcs12 -in ballerina.p12 -info```<br>
```keytool -import -file ballerina.crt -keystore ballerina-truststore.p12```

## Some listing commands
```keytool -list -storetype PKCS12 -keystore ballerina.12 -storepass ballerina```<br>
```keytool -importcert -storetype PKCS12 -keystore ballerina-truststore.p12 -storepass ballerina -alias ca -file ballerina.key -noprompt```<br>
```keytool -list -storetype PKCS12 -keystore ballerina-truststore.p12 -storepass ballerina```

## Some listing commands
* Example:<br>```winpty openssl pkcs12 -info -in keystore.p12```
* On this project:<br>```winpty openssl pkcs12 -info -in ballerina-truststore.p12```

## Print the expire date of the certificate
* Examples:<br>```openssl x509 -req -in ballerina.csr -signkey ballerina.key -out ballerina.crt```<br>```openssl x509 -enddate -noout -in server.crt```
* On this project:<br>```openssl x509 -req -in ballerina.csr -signkey ballerina.key -out ballerina.crt```

## List the key store content
```keytool -list -keystore ballerina-truststore.p12```

## Glossary
* keytool manages a keystore (database) of cryptographic keys, X.509 certificate chains, and trusted certificates. It is a tool as part of the java installation.
* openssl is a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library.
