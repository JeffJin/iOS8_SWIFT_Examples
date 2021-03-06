//
//  FileSevice.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-28.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
class FileService: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    
    typealias CallbackBlock = (result: String, error: String?) -> ()
    
    var callback: CallbackBlock = {
        (resultString, error) -> Void in
        if error == nil {
            println(resultString)
        } else {
            println(error)
        }
    }
    
    func httpGet(request: NSMutableURLRequest!, callback: (String,
        String?) -> Void) {
            var configuration =
            NSURLSessionConfiguration.defaultSessionConfiguration()
            var session = NSURLSession(configuration: configuration,
                delegate: self,
                delegateQueue:NSOperationQueue.mainQueue())
            var task = session.dataTaskWithRequest(request){
                (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if error != nil {
                    callback("", error.localizedDescription)
                } else {
                    var result = NSString(data: data, encoding:
                        NSASCIIStringEncoding)!
                    callback(result, nil)
                }
            }
            task.resume()
    }
    
    func URLSession(session: NSURLSession,
        didReceiveChallenge challenge:
        NSURLAuthenticationChallenge,
        completionHandler:
        (NSURLSessionAuthChallengeDisposition,
        NSURLCredential!) -> Void) {
            completionHandler(
                NSURLSessionAuthChallengeDisposition.UseCredential,
                NSURLCredential(forTrust:
                    challenge.protectionSpace.serverTrust))
    }
    
    func URLSession(session: NSURLSession,
        task: NSURLSessionTask,
        willPerformHTTPRedirection response:
        NSHTTPURLResponse,
        newRequest request: NSURLRequest,
        completionHandler: (NSURLRequest!) -> Void) {
            var newRequest : NSURLRequest? = request
            println(newRequest?.description);
            completionHandler(newRequest)
    }
    
    func downloadWebsites(){
        
        //        var url = NSURL(string: "http://www.stackoverflow.com")
        //
        //        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        //
        //            println(NSString(data: data, encoding:NSUTF8StringEncoding))
        //
        //        }
        //        task.resume()
        var request = NSMutableURLRequest(URL: NSURL(string: "https://www.google.com")!)
        var fileService = FileService()
        fileService.httpGet(request){
            (data, error) -> Void in
            if error != nil {
                println(error)
            } else {
                //println(data)
            }
        }
    }
}