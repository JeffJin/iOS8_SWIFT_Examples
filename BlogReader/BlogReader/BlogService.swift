//
//  BlogService.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-30.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation
import CoreData
import PromiseKit

var activeItem:BlogCacheItem!
var blogCache:[BlogCacheItem] = []


class BlogService : IBlogService{
    
    func findCacheItem(item:BlogItem) -> BlogCacheItem!{
        for cache in blogCache{
            if(cache.currentItem == item){
                return cache
            }
        }
        return nil
    }
    
    func loadBlogsFromGoogleBlogger(key:String) -> Promise<[[String:String]]>{
        
        let (promise, resolve, reject) = Promise<[[String:String]]>.defer()
        
        let urlPath = "https://www.googleapis.com/blogger/v3/blogs/3213900/posts?key=" + key
        
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if (error != nil) { //change 'error' to '(error != nil)'
                println(error)
                reject(error)
            } else {
                
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                var items = [[String:String]]()
                
                var item:AnyObject
                
                var authorDictionary:AnyObject
                
                var newBlogItem:BlogItem
                
                for var i = 0; i < jsonResult["items"]!.count; i++ {//append '!' after [] in order to convert optional to non-optional
                    
                    items.append([String:String]())
                    
                    item = jsonResult["items"]![i] as NSDictionary  //append '!' after [] in order to convert optional to non-optional
                    
                    items[i]["content"] = item["content"] as? NSString
                    
                    items[i]["title"] = item["title"] as? NSString
                    
                    items[i]["publishedDate"] = item["published"] as? NSString
                    
                    authorDictionary = item["author"] as NSDictionary
                    
                    items[i]["author"] = authorDictionary["displayName"] as? NSString
                }
                
                resolve(items)
            }
        })
        task.resume()
        
        return promise
    }
    
    
    func loadBlogsFromCoreData() -> [BlogItem]{
        
        var request = NSFetchRequest(entityName: "BlogItem")
        
        request.returnsObjectsAsFaults = false
        
        var results = dataAccess.executeFetchRequest(request, error: nil)! as [BlogItem] //append '!' at the end of line in order to convert
        
        return results
    }
    
    
    
    func saveBlogsToCoreData(items: [[String:String]]){
        
        for var i = 0; i < items.count; i++ {//append '!' after [] in order to convert optional to non-optional
            
            var newBlogItem = NSEntityDescription.insertNewObjectForEntityForName("BlogItem", inManagedObjectContext: dataAccess) as BlogItem
            
            newBlogItem.author = items[i]["author"]!
            
            newBlogItem.title = items[i]["title"]!
            
            newBlogItem.content = items[i]["content"]!
            
            newBlogItem.datePublished = items[i]["publishedDate"]!
            
            dataAccess.save(nil)
        }
        
    }
    
    func buildCacheItems(items:[BlogItem]) -> [BlogCacheItem]{
        //build linked list
        var count = items.count
        var blogCacheList = [BlogCacheItem]()
        for var i = 0; i < count; i++ {
            var prevIndex = i - 1
            var nextIndex = i + 1
            if(prevIndex < 0){
                prevIndex = count - 1
            }
            if(nextIndex >= count){
                nextIndex = 0
            }
            var tempCache = BlogCacheItem(item: items[i])
            tempCache.prevItem = items[prevIndex]
            tempCache.nextItem = items[nextIndex]
            blogCacheList.append(tempCache)
        }
        return blogCacheList
    }
    
}