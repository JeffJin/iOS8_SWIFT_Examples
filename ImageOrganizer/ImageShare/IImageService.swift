//
//  IImageService.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-25.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation

protocol IImageService {
    
    func getImages()-> Array<ImgResource>
    
    func searchImageFromGoogle(keyword:String) -> ImgResource
    
}