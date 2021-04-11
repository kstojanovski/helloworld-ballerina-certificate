Prints "Hello World!" with a main function.
[//]: # (above is the module summary)

# Module Overview
Prints "Hello World!" as the output to the command line using a main function.

# precondition
# create the cert files.
# also the toml file with the user should exist.

# call
bal run helloworldservicesecurebasic --b7a.config.file=Ballerina.toml --b7a.home=opensslfiles-localhost

# curl call to check the service
 curl -k -u bob:password2 https://localhost:9090/hello/sayHello