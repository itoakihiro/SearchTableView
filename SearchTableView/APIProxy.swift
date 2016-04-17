//
//  APIProxy.swift
//  SearchTableView
//
//  Created by HIRANO TOMOKAZU on 3/3/16.
//  Copyright © 2016 Akihiro Ito. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class APIProxy: NSObject {
    
    static let sharedInstance = APIProxy()
    
    let urlPath = "http://voxwell.com/api/search"
    
    func getData(keyword: String, onCompletion: (JSON) -> Void) {
        makeHTTPPostRequest(keyword, onCompletion: { json, err in onCompletion(json as JSON)
        })
    }
    
    func makeHTTPPostRequest(keyword: String, onCompletion: ServiceResponse) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: urlPath)!)
        request.HTTPMethod = "POST"
        
        let username = "weissnat.chandler@yahoo.com"
        let password = "abc"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let param: NSDictionary = ["keyword": keyword, "limit": 5]
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
        } catch {
            //handle error. Probably return or mark function as throws
            print(error)
            return
        }
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}