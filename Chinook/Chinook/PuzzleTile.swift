//
//  PuzzleTile.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-31.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit

class PuzzleTitle {
    let originalX:Int!
    let originalY:Int!
    let width:CGFloat!
    let height:CGFloat!
    let imageUrl:String!
    var currentX:Int!
    var currentY:Int!
    
    init(x:Int, y:Int, imageLink: String, w: CGFloat, h: CGFloat){
        self.originalX = x
        self.originalY = y
        self.imageUrl = imageLink
        self.width = w
        self.height = h
    }
    
    func getImageTile()-> UIButton{
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, self.width, self.height)
        button.setTitle("\(self.originalX) X \(self.originalY)", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: "selectTile:", forControlEvents: UIControlEvents.TouchUpInside)
        button.addTarget(self, action: "dragTile:", forControlEvents: UIControlEvents.TouchDragEnter)
        button.addTarget(self, action: "dropTile:", forControlEvents: UIControlEvents.TouchDragExit)
        return button
    }
    
    func selectTile(sender:UIButton){
        var button:UIButton = sender
        UIView.animateWithDuration(0.5, animations: { button.alpha = 0 }, completion:{_ in
            UIView.animateWithDuration(0.5, animations: { button.alpha = 1 })
        })
    }
    
    
    func dragTile(sender:UIButton){
        var button:UIButton = sender
        println("dragging tile")
    }
    
    
    
    func dropTile(sender:UIButton){
        var button:UIButton = sender
        println("dropping tile")
    }
    
    
}