import Foundation

public enum TwilioAction : String {
    case Call = "Calls"
    case TextMessage = "Messages"
}



//Steps:
//1. Register for an account on Twilio.
//2. Get a phone number, that will be the "from" phone number
//3. Get your account sid and auth token
//4. Copy one of the functions below and fill in your info.
public class ExampleCode {

    func sendTextMessage() {
        Twilio().sendTextMessage(accountSid: "account sid", authToken: "auth token",
            to: "some number", from: "twilio number", body: "Hello World!")
    }
    
    func makeCall() {
        Twilio().makeCall(accountSid: "account sid", authToken: "auth token",
            to: "some number", from: "twilio number", url: "https://brodan.biz/call.xml")
    }
}



public class Twilio {
    
    func makeCall(#accountSid: String, authToken: String,
        to: String, from: String, url: String) {
        
        //"https://brodan.biz/call.xml"
        performAction(.Call, username: accountSid, password: authToken, to: to, from: from, extraKey: "Url", extraValue: url)
    }
    
    func sendTextMessage(#accountSid: String, authToken: String,
        to: String, from: String, body: String) {
        performAction(.TextMessage, username: accountSid, password: authToken, to: to, from: from, extraKey: "Body", extraValue: body)
    }
    
    private func performAction(type: TwilioAction,
        username: String, password: String,
        to: String, from: String, extraKey: String, extraValue: String) {
        var swiftRequest = SwiftRequest();
        
        var data = [
            "To" : to,
            "From" : from,
            extraKey : extraValue
        ];
        
        let url = "https://api.twilio.com/2010-04-01/Accounts/" + username + "/" + type.rawValue
        swiftRequest.post(url,
            auth: ["username" : username, "password" : password],
            data: data,
            callback: {err, response, body in
                if err == nil {
                    println("Success: \(response)")
                } else {
                    println("Error: \(err)")
                }
        });
    }
}