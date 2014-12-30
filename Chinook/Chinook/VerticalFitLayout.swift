//
//  VerticalFitLayout.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-30.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class VerticalFitLayout: VerticalLayout {
    
    
    override init(width: CGFloat) {
        super.init(width: width)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var height: CGFloat = 0
        var zeroHeightView: UIView?
        
        for i in 0..<subviews.count {
            var view = subviews[i] as UIView
            height += yOffsets[i]
            if view.frame.height == 0 {
                zeroHeightView = view
            } else {
                height += view.frame.height
            }
        }
        
        if height < superview!.frame.height && zeroHeightView != nil {
            zeroHeightView!.frame.size.height = superview!.frame.height - height
        }
        
        super.layoutSubviews()
        
    }
    
}