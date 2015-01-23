//
//  SearchViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-26.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit
import AVFoundation

class SearchViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var keywords: UITextField!
    
    @IBOutlet var loadPhotos: UIButton!
    
    var imageButtonList:[UIButton] = []
    
    var imageService = ImageService(conf:"database connection")
    
    var imageContainer:UIView!
    
    var player:AVAudioPlayer!
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        var imgButton = imageButtonList[0]
        imgButton.setBackgroundImage(image, forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywords.delegate = self
        
        let width:CGFloat = 1024
        let height:CGFloat = 768
        
        imageContainer = UIView(frame: CGRectMake(15, 75, width, height))
        self.view.addSubview(imageContainer)
        
        //add observer for device orientation change
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "layoutImagePlaceHolders:", name:"UIDeviceOrientationChanged", object: nil)
        
        
        var audioPath = NSString(string: NSBundle.mainBundle().pathForResource("happiness", ofType: "mp3")!)
        
        var error : NSError? = nil
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
        player.play()
        var images = imageService.loadImagesFromDb()
        restoreImages(imageContainer, images: images)
        
    }
    
    
    func layoutImagePlaceHolders(notification: NSNotification){
        //Action to take on Notification
        println("layoutImagePlaceHolders")
        var images = imageService.loadImagesFromDb()
        restoreImages(imageContainer, images: images)
    }
    
    @IBAction func loadPhotosFromDevice(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func getImageButtonView(i:Int, j:Int)-> UIButton{
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, 250, 215)
        button.center = CGPointMake(CGFloat(115 + 255 * i), CGFloat(90 + 220 * j))
        button.setTitle("placeholder", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        button.addTarget(self, action: "selectTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }

    
    func restoreImages(imageContainer: UIView, images:Array<ImgResource>){
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
                    var button = getImageButtonView(i, j: j)
                    imageButtonList.append(button)
                    imageContainer.addSubview(button)
                }
            }
        }
        else {
            println("UIDevice.currentDevice().orientation: Landscape")
            for i in 0 ... 3{
                for j in 0 ... 2{
                    var button = getImageButtonView(i, j: j)
                    imageButtonList.append(button)
                    imageContainer.addSubview(button)
                }
            }
        }
        //TODO: if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)){
        
        //setup default place holder images
        for var i = 0; i < imageButtonList.count; ++i {
            self.imageButtonList[i].setBackgroundImage(placeHolderImg, forState: UIControlState.Normal)
        }
        var count = images.count > 12 ? 12 : images.count
        for var i = 0; i < count; i++ {
            var temp = images[i]
            loadImage(temp.url, imgButton: imageButtonList[i], id: i)
        }
    }
    
    
    func loadImage(url:String, imgButton: UIButton, id:Int) -> Bool{
        if((uiViewCache[url]) != nil){
            println("load image from cache")
            imgButton.setBackgroundImage(uiViewCache[url], forState: UIControlState.Normal)
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
                        imgButton.tag = id
                        imgButton.setBackgroundImage(image, forState: UIControlState.Normal)
                        println("setting background image for button with tag \(id), \(url)")
                    })
                }
                else {
                    println("Load Image Error: \(error.localizedDescription)")
                }
            })
        }
        
        return true
    }
    
    
    
   func searchImages(keywords:String){
        //TODO use promise to chain
       imageService.searchImages(keywords)
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
        
        searchImages(keywords.text);
        self.keywords.text = ""
        return true
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
