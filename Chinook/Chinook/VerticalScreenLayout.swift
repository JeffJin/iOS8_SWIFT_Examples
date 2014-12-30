//
//  VerticalScreenLayout.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-30.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class VerticalScreenLayout: VerticalLayout {
    
    
    init() {
        super.init(width: UIScreen.mainScreen().bounds.width)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.frame.size.width = UIScreen.mainScreen().bounds.width
        super.layoutSubviews()
        
    }
    
}