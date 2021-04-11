import ballerina/auth;
import ballerina/config;
import ballerina/http;
import ballerina/log;

auth:InboundBasicAuthProvider basicAuthProvider = new;
http:BasicAuthHandler basicAuthHandler = new (basicAuthProvider);

listener http:Listener ep = new (9090, config = {
    auth: {
        authHandlers: [basicAuthHandler]
    },
    secureSocket: {
        keyStore: {
            path: config:getAsString("b7a.home") +
                  "/ballerina.p12",
            password: "ballerina"
        }
    }
});

@http:ServiceConfig {
    basePath: "/hello",
    auth: {
        scopes: ["scope1"]
    }
}

service echo on ep {    
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/sayHello",
        auth: {
            scopes: ["scope2"]
        }
    }
    resource function hello(http:Caller caller, http:Request req) {
        error? result = caller->respond("Hello, World!!!");
        if (result is error) {
            log:printError("Error in responding to caller", result);
        }
    }
}
