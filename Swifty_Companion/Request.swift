//
//  Request.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 1/3/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import Foundation

class Request {
    
    var UID: String
    var SECRET: String
    var token: String?
    var student = StudentStruct()
    
    init(UID: String, SECRET: String) {
        self.UID = UID
        self.SECRET = SECRET
    }
    
    public func requestForToken() {
        let BEARER = ((self.UID + ":" + self.SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials&client_id=0a9eca6eb26d9156b2607741999cddbd50f6ee9dc6166ca66c46aabf3fd0a7f5&client_secret=dc4c2087acf4020acd0b93fad8d6999d5230b68653390bf907c0e04b1763cdf4".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(request)
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary {
                        if let t = dic["access_token"] as? String {
                            self.token = t
                            print(self.token!)
                            //self.signIn(token: self.token)
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
}

