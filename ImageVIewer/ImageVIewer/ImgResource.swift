//
//  ImgResource.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-16.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class ImgResource{
    var id: Int64
    var title: String = ""
    var url: String = ""
    var image: UIImage?
    var description: String {
        return "The image resource title is \(title), "
    }
    var uiImage: UIImage? {
        get {
            if let image = self.image{
                return image
            }
            //synchronous version
            self.image = UIImage(data: NSData(contentsOfURL: NSURL(string:  self.url)!)!)!
            return self.image
        }
        set(newImage) {
            self.image = newImage
        }
        
       
    }
    
    init(title:String){
        self.id = (Int64)(NSDate().timeIntervalSince1970)
        self.title = title
    }
    
    convenience init(title:String, url:String){
        self.init(title: title)
        self.url = url
    }
}