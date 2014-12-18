//
//  SecondViewController.swift
//  ImageVIewer
//
//  Created by Coho on 2014-12-06.
//  Copyright (c) 2014 Coho. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var keywordTxt: UITextField!
    
    @IBOutlet var sortByDate: UIButton!
    
    @IBOutlet var sortByFileSize: UIButton!
    
    @IBOutlet var sortByImageType: UIButton!
    
    @IBOutlet var imageContainer: UIView!
    
    var imageService:ImageService = ImageService(conf:"database connection")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Do any additional setup after loading the view, typically from a nib.
        var placeHolderImg = imageService.getPlaceholderImage()
        
        let width:CGFloat = 1000
        let height:CGFloat = 768
        
        var view:UIView = UIView(frame: CGRectMake(0, 0, width, height))
        self.view.addSubview(view)
        
        for i in 0 ... 1{
            for j in 0 ... 2{
                var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
                button.frame = CGRectMake(0, 0, 155, 155)
                button.center = CGPointMake(CGFloat(110 + 160 * i), CGFloat(190 + 160 * j))
                button.setTitle("placeholder", forState: UIControlState.Normal)
                button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
                button.setBackgroundImage(placeHolderImg, forState: UIControlState.Normal)
                button.addTarget(self, action: "addTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
                button.tag = i
                
                view.addSubview(button)
            }
        }
        
    }
    
    func addTargetImage(sender:UIButton){
        var button:UIButton = sender;
        //animate the clicked button
        UIView.animateWithDuration(0.5, animations: { button.alpha = 0 }, completion:{_ in
            UIView.animateWithDuration(0.5, animations: { button.alpha = 1 })
        })
        println("addTargetImage gets called")
        //backgroundImageView.image =  imageResources[button.tag].uiImage
        //animate background image
        //        UIView.animateWithDuration(1, animations: { self.backgroundImageView.alpha = 0 }, completion:{_ in
        //            self.backgroundImageView.image = self.imageResources[button.tag].uiImage
        //            UIView.animateWithDuration(0.4, animations: { self.backgroundImageView.alpha = 1 })
        //        })
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        keywordTxt.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    
    
}

