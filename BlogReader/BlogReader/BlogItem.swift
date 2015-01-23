//
//  BlogItem.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-21.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation
import CoreData

class BlogItem: NSManagedObject {

    @NSManaged var author: String
    @NSManaged var content: String
    @NSManaged var datePublished: String
    @NSManaged var title: String

}
