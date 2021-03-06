//
//  IImageService.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-25.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

protocol IImageService {
    
    func getPlaceholderImage() -> UIImage

    func searchImages(keywords: String)-> Array<ImgResource> 
    
    func saveImagesIntoDb(images: Array<ImgResource>) -> Int
    
    func loadImagesFromDb() -> Array<ImgResource>
    
    func printImagesFromDb()
}