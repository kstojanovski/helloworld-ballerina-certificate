import ballerina/http;
import ballerina/io;
public function main() returns @tainted error? {
    http:Client clientEP = new ("http://localhost:9090");
    
    http:Response resp = check clientEP->get("/hello/sayHello");
    string payload = check resp.getTextPayload();
    io:println(payload + " from service");

    resp = check clientEP->get("/hello/sayHi");
    payload = check resp.getTextPayload();
    io:println(payload + " from service");
}
