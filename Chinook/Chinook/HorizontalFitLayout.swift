//
//  HorizontalFitLayout.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-30.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class HorizontalFitLayout: HorizontalLayout {
    
    
    override init(height: CGFloat) {
        super.init(height: height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var width: CGFloat = 0
        var zeroWidthView: UIView?
        
        for i in 0..<subviews.count {
            var view = subviews[i] as UIView
            width += xOffsets[i]
            if view.frame.width == 0 {
                zeroWidthView = view
            } else {
                width += view.frame.width
            }
        }
        
        if width < superview!.frame.width && zeroWidthView != nil {
            zeroWidthView!.frame.size.width = superview!.frame.width - width
        }
        
        super.layoutSubviews()
        
    }
    
}
