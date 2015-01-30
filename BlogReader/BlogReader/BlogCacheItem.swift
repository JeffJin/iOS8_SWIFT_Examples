//
//  BlogCacheItem.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-29.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation

class BlogCacheItem {
    
   var prevItem: BlogItem!
   var currentItem: BlogItem
   var nextItem: BlogItem!
    
    init(item: BlogItem){
       currentItem = item
        prevItem = nil
        nextItem = nil
    }
    
    convenience init(prev:BlogItem, curr:BlogItem, next: BlogItem){
        self.init(item: curr)
        prevItem = prev
        nextItem = next
    }
}
