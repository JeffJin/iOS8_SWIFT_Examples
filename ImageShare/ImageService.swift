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
    
    func getImages()-> Array<ImgResource> {
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
    
    func randomNumber (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func searchImageFromGoogle(keyword:String) -> ImgResource{
        var images = getImages()
        var num = randomNumber(0, upper: 8)
        return images[num]
    }


}
