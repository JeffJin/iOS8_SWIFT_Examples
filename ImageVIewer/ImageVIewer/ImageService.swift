//
//  ImageService.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-16.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP

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
    
    func getOnlineImages()-> Array<ImgResource> {
        var imgs = Array<ImgResource>()
        
        imgs.append(ImgResource(title:"Image 1", url: "http://upload.wikimedia.org/wikipedia/commons/b/b2/SNSD_Cooky_Phone.jpg"))
        imgs.append(ImgResource(title:"Image 2", url: "http://bestkpopwallpaper.com/wp-content/uploads/2013/10/after-school-best-kpop-images.jpg"))
        imgs.append(ImgResource(title:"Image 3", url: "http://3.bp.blogspot.com/-sg4RjBMhm9w/T5ZiWyHEZHI/AAAAAAAAKSQ/kNLljtod3T8/s1600/Kpop+star+120422_07.jpg"))
        imgs.append(ImgResource(title:"Image 4", url: "http://www.mtviggy.com/wp-content/gallery/kpop-2000s-list/kpop_missacrop_0.jpg"))
        imgs.append(ImgResource(title:"Image 5", url: "http://images6.fanpop.com/image/photos/33500000/-K-pop-kpop-4ever-33571582-1680-1050.jpg"))
        imgs.append(ImgResource(title:"Image 6", url: "http://www.soompi.com/es/wp-content/blogs.dir/8/files/2012/12/SNSD.jpg"))
        imgs.append(ImgResource(title:"Image 7", url: "http://www.beatnik.ca/seven/Girls_Generation_sailor_suits_colored.png"))
        imgs.append(ImgResource(title:"Image 8", url: "http://images5.fanpop.com/image/photos/26100000/Secret-kpop-girl-power-26130791-640-441.jpg"))
        imgs.append(ImgResource(title:"Image 9", url: "http://dliubb1xeg9ue.cloudfront.net/wp-content/uploads/2013/12/secretmadonna.jpg"))
        
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
