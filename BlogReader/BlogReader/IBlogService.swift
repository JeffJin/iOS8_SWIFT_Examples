//
//  IBlogService.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-30.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

protocol IBlogService {
    func findCacheItem(item:BlogItem) -> BlogCacheItem!
    func loadBlogsFromGoogleBlogger(key:String)
    func loadBlogsFromCoreData() -> [BlogItem]
    func saveBlogsToCoreData(items: [[String:String]])
}