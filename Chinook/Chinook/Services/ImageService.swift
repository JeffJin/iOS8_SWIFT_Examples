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
                        let content = item["content"]
                        println("title: \(title!), url: \(url!)")
                        var img = ImgResource(title: title!, url: url!)
                        img.description = content!
                        imgs.append(img)
                    }
                    self.saveImagesIntoDb(imgs)
                    //save image metadata into database
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
            var imgEntity = NSEntityDescription.insertNewObjectForEntityForName("Images", inManagedObjectContext: context) as NSManagedObject
            
            imgEntity.setValue(NSNumber(longLong: imgResource.id), forKey: "id")
            
            imgEntity.setValue(imgResource.url, forKey: "url")
            
            imgEntity.setValue(imgResource.title, forKey: "title")
            
            imgEntity.setValue(imgResource.description, forKey: "desc")
        }
        
        context.save(nil)
        
        return 0
    }
    
    func loadImagesFromDb() -> Array<ImgResource>{
        var imgs = Array<ImgResource>()
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Images")
        
        request.returnsObjectsAsFaults = false
        
        let results = context.executeFetchRequest(request, error: nil) as [NSManagedObject]?
        
        if results!.count > 0 {
            for result: AnyObject in results! {
                var id = result.valueForKey("id") as String
                var title = result.valueForKey("title") as String
                var desc = result.valueForKey("desc") as String
                var url = result.valueForKey("url") as String
                println("id: \(id), title: \(title), description: \(desc), url: \(url)")
            }
            
        } else {
            
            println("No results")
            
        }
        return imgs;
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
