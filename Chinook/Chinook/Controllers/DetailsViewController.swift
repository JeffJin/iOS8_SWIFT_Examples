//
//  DetailsViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-26.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("DetailsViewController.viewDidLoad")
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
