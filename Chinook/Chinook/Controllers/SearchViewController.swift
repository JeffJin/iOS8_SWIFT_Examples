//
//  SearchViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-26.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var keywords: UITextField!
    
    var imageButtonList:[UIButton] = []
    
    var imageService:IImageService = ImageService(conf:"database connection")
    
    var index:Int = 0
    
    var imageContainer:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywords.delegate = self
        
        let width:CGFloat = 1024
        let height:CGFloat = 768
        
        imageContainer = UIView(frame: CGRectMake(15, 75, width, height))
        self.view.addSubview(imageContainer)
        
        //add observer for device orientation change
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "layoutImagePlaceHolders:", name:"UIDeviceOrientationChanged", object: nil)
    }
    
    func layoutImagePlaceHolders(notification: NSNotification){
        //Action to take on Notification
        println("layoutImagePlaceHolders")
        
        restoreImages(imageContainer)
    }
    
    func restoreImages(imageContainer: UIView){
        println("restoring images")
        //clean up existing image button list
        for var i = 0; i < self.imageButtonList.count; ++i {
            self.imageButtonList[i].removeFromSuperview()
        }
        //setup image buttons based on device orientation
        var placeHolderImg = imageService.getPlaceholderImage()
        //if horizontal
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)){
            println("UIDevice.currentDevice().orientation: Portrait")
            for i in 0 ... 2{
                for j in 0 ... 3{
                    var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
                    button.frame = CGRectMake(0, 0, 250, 215)
                    button.center = CGPointMake(CGFloat(114 + 255 * i), CGFloat(90 + 220 * j))
                    button.setTitle("placeholder", forState: UIControlState.Normal)
                    button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
                    button.addTarget(self, action: "addTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
                    imageButtonList.append(button)
                    imageContainer.addSubview(button)
                }
            }
        }
        else if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)){
            println("UIDevice.currentDevice().orientation: Landscape")
            for i in 0 ... 3{
                for j in 0 ... 2{
                    var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
                    button.frame = CGRectMake(0, 0, 250, 215)
                    button.center = CGPointMake(CGFloat(115 + 255 * i), CGFloat(90 + 220 * j))
                    button.setTitle("placeholder", forState: UIControlState.Normal)
                    button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
                    button.addTarget(self, action: "selectTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
                    imageButtonList.append(button)
                    imageContainer.addSubview(button)
                }
            }
        }
        else{
            NSLog("Invalid UIDevice Orientation")
        }
        //setup default place holder images
        self.index = 0
        for var i = 0; i < imageButtonList.count; ++i {
            self.imageButtonList[i].setBackgroundImage(placeHolderImg, forState: UIControlState.Normal)
        }
        //load images from local storage
        if var storedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("favImageList") {
            
            favImageList = []
            
            for var i = 0; i < storedtoDoItems.count; ++i {
                favImageList.append(storedtoDoItems[i] as NSString)
                loadImage(favImageList[i] as String)
            }
        }
    }
    
    
    func loadImage(url:String) -> Bool{
        if((uiViewCache[url]) != nil){
            println("load image from cache")
            self.imageButtonList[self.index].setBackgroundImage(uiViewCache[url], forState: UIControlState.Normal)
            self.index++
        }
        else{
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: url)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            println("downloading image from \(url)")
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    var image = UIImage(data: data)
                    uiViewCache[url] = (image)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.imageButtonList[self.index].tag = self.index
                        self.imageButtonList[self.index].setBackgroundImage(image, forState: UIControlState.Normal)
                        self.index++
                    })
                }
                else {
                    println("Load Image Error: \(error.localizedDescription)")
                }
            })
        }
        
        return true
    }
    
    func selectTargetImage(sender:UIButton){
        var button:UIButton = sender
        selectedImageButton = button
        //animate the clicked button
        UIView.animateWithDuration(0.5, animations: { button.alpha = 0 }, completion:{_ in
            UIView.animateWithDuration(0.5, animations: { button.alpha = 1 })
        })
    }
    
    //response to return key press
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        keywords.resignFirstResponder()
        var isNew = imageService.addImageUrl(keywords.text)
        if(!isNew || index > 5){
            println("\(keywords.text) is duplicated link")
            return false
        }
        
        var result = loadImage(keywords.text);
        self.keywords.text = ""
        return result
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
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
