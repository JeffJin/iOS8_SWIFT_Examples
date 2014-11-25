//
//  ImgShareViewController.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-11.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class ImgShareViewController: UIViewController {

    var backgroundImageView:UIImageView = UIImageView()
    var imageResources:Array<ImgResource> = Array<ImgResource>()
    var imageService:ImageService = ImageService(conf:"database connection")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageResources = loadImages()
        
        txtKeyword.text = "sexy lady"
        
        let width:CGFloat = 1000
        let height:CGFloat = 768
        
        var view:UIView = UIView(frame: CGRectMake(0, 35, width, height))
        self.view.addSubview(view)
        //setup image view
        backgroundImageView = UIImageView(frame: view.frame)
        backgroundImageView.image =  imageResources[0].uiImage
        view.addSubview(backgroundImageView)
        
        for i in 0 ... imageResources.count-1 {
            var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
            button.frame = CGRectMake(100, 100, 100, 100)
            button.center = CGPointMake(CGFloat(150 + (100 * i)), CGFloat(200))
            button.setTitle(imageResources[i].title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
            button.setBackgroundImage(imageResources[i].uiImage, forState: UIControlState.Normal)
            button.addTarget(self, action: "getTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i
        
            view.addSubview(button)
        }
        //mainImgView.image =  imageResources[0].uiImage
    }
    
    func getTargetImage(sender:UIButton){
        var button:UIButton = sender;
        //animate the clicked button
        UIView.animateWithDuration(0.5, animations: { button.alpha = 0 }, completion:{_ in
            UIView.animateWithDuration(0.5, animations: { button.alpha = 1 })
        })
        
        //backgroundImageView.image =  imageResources[button.tag].uiImage
        //animate background image
        UIView.animateWithDuration(1, animations: { self.backgroundImageView.alpha = 0 }, completion:{_ in
            self.backgroundImageView.image = self.imageResources[button.tag].uiImage
            UIView.animateWithDuration(0.4, animations: { self.backgroundImageView.alpha = 1 })
        })
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //load images from database or web service
    func loadImages()->Array<ImgResource> {
        return imageService.getImages()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func getNextImage(sender: AnyObject) {
        mainImgView.image = imageResources[1].uiImage
    }    
    
    @IBAction func getPrevImage(sender: UIButton) {
        mainImgView.image = imageResources[2].uiImage
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        
    }
    
    @IBOutlet var txtKeyword: UITextField!
    @IBOutlet var mainImgView: UIImageView!
}
