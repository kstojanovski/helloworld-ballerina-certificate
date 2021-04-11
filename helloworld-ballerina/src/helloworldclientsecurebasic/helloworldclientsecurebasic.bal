import ballerina/auth;
import ballerina/config;
import ballerina/http;
import ballerina/log;
auth:OutboundBasicAuthProvider outboundBasicAuthProvider = new ({
    username: "bob",
    password: "password2"
});

http:BasicAuthHandler outboundBasicAuthHandler =
                                            new (outboundBasicAuthProvider);

http:Client httpEndpoint = new ("https://localhost:9090", {
    auth: {
        authHandler: outboundBasicAuthHandler
    },
    secureSocket: {
        trustStore: {
            path: config:getAsString("b7a.home") +
                  "/ballerina-truststore.p12",
            password: "ballerina"
        }
    }
});

public function main() {
    log:printInfo("b7a.home: " + config:getAsString("b7a.home"));

    var response = httpEndpoint->get("/hello/sayHello");
    if (response is http:Response) {
        var result = response.getTextPayload();
        log:printInfo((result is error) ? "Failed to retrieve payload."
                                        : result);
    } else {
        log:printError("Failed to call the endpoint.", response);
    }
}