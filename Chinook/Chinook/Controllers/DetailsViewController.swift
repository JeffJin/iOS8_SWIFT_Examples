//
//  DetailsViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-26.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var detailsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("DetailsViewController.viewDidLoad")
        
        self.detailsImageView.image = selectedImageButton.backgroundImageForState(UIControlState.Normal)
        
        UIView.animateWithDuration(1, animations: { self.detailsImageView.alpha = 0.5 }, completion:{_ in
            self.detailsImageView.image = selectedImageButton.backgroundImageForState(UIControlState.Normal)
            UIView.animateWithDuration(1, animations: { self.detailsImageView.alpha = 1 })
        })
        var x = self.detailsImageView.center.x
        var y = self.detailsImageView.center.y
        UIView.animateWithDuration(1, animations: {
            self.detailsImageView.center = CGPointMake(-512, -384)
            }, completion:{_ in
                self.detailsImageView.center = CGPointMake(512, 384)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
