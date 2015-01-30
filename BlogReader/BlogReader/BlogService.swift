//
//  BlogService.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-30.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation

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
    
}