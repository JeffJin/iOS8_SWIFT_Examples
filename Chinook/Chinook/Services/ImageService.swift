//
//  ImageService.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-16.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class ImageService : IImageService{
    
    let config:String
    
    init(conf:String){
        self.config = conf
    }
    
    func addImageUrl(url:String) -> Bool{
        var isNew = true
        var storedItems : AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("favImageList")
        if storedItems != nil {
            favImageList = []
            
            for var i = 0; i < storedItems!.count; ++i {
                if(storedItems![i] as NSString != url){
                    favImageList.append(storedItems![i] as NSString)
                }
                else{
                    isNew = false
                }
            }
        }
        favImageList.append(url as NSString)
        let fixedFavImageList = favImageList
        NSUserDefaults.standardUserDefaults().setObject(fixedFavImageList, forKey: "favImageList")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return isNew
    }
    
    func searchImages(keywords: String)-> Array<ImgResource> {
        var imgs = Array<ImgResource>()
        
        let urlPath = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=" + keywords.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println("Image Search url: \(urlPath)")
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Image Search completed")
            if((error) != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            } else {
                var response = jsonResult["responseData"]  as NSDictionary
                println(response["results"])
                if let items =  response["results"] as? [[String:String]] {
                    for item in items {
                        let title = item["title"]
                        let url = item["url"]
                        println("title: \(title!), url: \(url!)")
                        
                        imgs.append(ImgResource(title: title!, url: url!))
                    }
                    
                    //save image metadata into database
                }
            }
            
        })
        task.resume()

//        imgs.append(ImgResource(title:"Image 1", url: "http://upload.wikimedia.org/wikipedia/commons/b/b2/SNSD_Cooky_Phone.jpg"))

        return imgs
    }
    
    
    
    
    func downloadImage(url:String){
        var request = HTTPTask()
        let downloadTask = request.download(url, parameters: nil, progress: {(complete: Double) in
            println("percent complete: \(complete)")
            }, success: {(response: HTTPResponse) in
                println("download finished!")
                if response.responseObject != nil {
                    //we MUST copy the file from its temp location to a permanent location.
                    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                    let newPath = NSURL(string:  "\(paths[0])/\(response.suggestedFilename!)")!
                    let fileManager = NSFileManager.defaultManager()
                    fileManager.removeItemAtURL(newPath, error: nil)
                    fileManager.moveItemAtURL(response.responseObject! as NSURL, toURL: newPath, error: nil)
                    println("File new path: \(newPath)")
                    var stringUrl:NSString = newPath.absoluteString!
                }
                
            } ,failure: {(error: NSError, response: HTTPResponse?) in
                println("failure")
        })
    }
    
    func getPlaceholderImage() -> UIImage{
        
        return UIImage(named: "ImageNotFound.jpg")!
    }
    
    func randomNumber (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
}
