//
//  Image.swift
//  Chinook
//
//  Created by Jeff Jin on 2015-01-16.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation
import CoreData

class Image: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var id: NSNumber
    @NSManaged var title: String
    @NSManaged var url: String

}
