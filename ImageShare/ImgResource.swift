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
    var description: String {
        return "The image resource title is \(title), "
    }
    var uiImage: UIImage {
        return UIImage(data: NSData(contentsOfURL: NSURL(string:  self.url)!)!)!
    }
    
    init(url:String){
        self.id = (Int64)(NSDate().timeIntervalSince1970)
        self.url = url
    }
    
    convenience init(title:String, url:String){
        self.init(url: url)
        self.title = title
    }
}