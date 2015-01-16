//
//  ImgResource.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-16.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ImgResource{
    var id: Int64
    var title: String
    var url: String
    var desc: String

    init(){
        self.id = (Int64)(NSDate().timeIntervalSince1970)
        self.title = ""
        self.url = ""
        self.desc = ""
    }
    
    func getUIImage() -> UIImage{
        return UIImage(data: NSData(contentsOfURL: NSURL(string:  self.url)!)!)!
    }
}