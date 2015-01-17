//
//  ImageService.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-16.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ImageService : IImageService{
    
    let config:String
    
    init(conf:String){
        self.config = conf
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
                        var img = ImgResource()
                        img.url = item["url"]!
                        img.title = item["title"]!
                        img.desc = item["content"]!
                        imgs.append(img)
                    }
                    //save image metadata into database
                    self.saveImagesIntoDb(imgs)
                }
            }
            
        })
        task.resume()
        
        return imgs
    }
    
    func saveImagesIntoDb(images: Array<ImgResource>) -> Int{
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        for imgResource in images{
//            var imgEntity = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: context) as NSManagedObject
//            
//            imgEntity.setValue(NSNumber(longLong: imgResource.id), forKey: "id")
//            
//            imgEntity.setValue(imgResource.url, forKey: "url")
//            
//            imgEntity.setValue(imgResource.title, forKey: "title")
//            
//            imgEntity.setValue(imgResource.desc, forKey: "desc")
            
            var imgEntity = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: context) as Image
            
            imgEntity.id = NSNumber(longLong: imgResource.id)
            imgEntity.url = imgResource.url
            imgEntity.title = imgResource.title
            imgEntity.desc = imgResource.desc
        }
        
        context.save(nil)
        
        return 0
    }
    
    func loadImagesFromDb() -> Array<ImgResource>{
        var imgs = Array<ImgResource>()
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Image")
        
        request.returnsObjectsAsFaults = false
        
        let results = context.executeFetchRequest(request, error: nil) as [Image]?
        
        if results!.count > 0 {
            for result: Image in results! {
                var temp = ImgResource()
                temp.id = result.id.longLongValue
                temp.title = result.title
                temp.desc = result.desc
                temp.url = result.url
                
                imgs.append(temp)
                
                println("id: \(result.id), title: \(result.title), description: \(result.desc), url: \(result.url)")
            }
            println("results!.count = \(results!.count)")
            
        } else {
            
            println("No results")
            
        }
        
        return imgs
    }
    
    
    func printImagesFromDb(){
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Image")
        
        request.returnsObjectsAsFaults = false
        
        let results = context.executeFetchRequest(request, error: nil) as [NSManagedObject]?
        
        if results!.count > 0 {
            for result: NSManagedObject in results! {
                var id:Int64 = (result.valueForKey("id")! as NSNumber).longLongValue
                var title = result.valueForKey("title")! as String
                var desc = result.valueForKey("desc")! as String
                var url = result.valueForKey("url")! as String
                println("id: \(id), title: \(title), description: \(desc), url: \(url)")
            }
            println("results!.count = \(results!.count)")
        } else {
            println("No results")
        }
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
