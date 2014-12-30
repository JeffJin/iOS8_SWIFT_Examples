//
//  VerticalLayout.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-30.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class VerticalLayout: UIView {
    
    var yOffsets: [CGFloat] = []
    
    init(width: CGFloat) {
        super.init(frame: CGRectMake(0, 0, width, 0))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var height: CGFloat = 0
        
        for i in 0..<subviews.count {
            var view = subviews[i] as UIView
            view.layoutSubviews()
            height += yOffsets[i]
            view.frame.origin.y = height
            height += view.frame.height
        }
        
        self.frame.size.height = height
        
    }
    
    override func addSubview(view: UIView) {
        
        yOffsets.append(view.frame.origin.y)
        super.addSubview(view)
        
    }
    
    func removeAll() {
        
        for view in subviews {
            view.removeFromSuperview()
        }
        yOffsets.removeAll(keepCapacity: false)
        
    }
    
}
