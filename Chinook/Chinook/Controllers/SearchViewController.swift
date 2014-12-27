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
    
    var index:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywords.delegate = self
        
        var placeHolderImg = imageService.getPlaceholderImage()
        
        let width:CGFloat = 768
        let height:CGFloat = 568
        
        var view:UIView = UIView(frame: CGRectMake(0, 100, width, height))
        self.view.addSubview(view)
        
        for i in 0 ... 1{
            for j in 0 ... 2{
                var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
                button.frame = CGRectMake(0, 0, 155, 155)
                button.center = CGPointMake(CGFloat(110 + 160 * i), CGFloat(90 + 160 * j))
                button.setTitle("placeholder", forState: UIControlState.Normal)
                button.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
                button.setBackgroundImage(placeHolderImg, forState: UIControlState.Normal)
                button.addTarget(self, action: "addTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
                button.tag = i
                imageButtonList.append(button)
                view.addSubview(button)
            }
        }
        restoreImages()
    }
    
    func restoreImages(){
        println("restoring images")
        self.index = 0
        var placeHolderImg = imageService.getPlaceholderImage()
        for var i = 0; i < imageButtonList.count; ++i {
            self.imageButtonList[i].setBackgroundImage(placeHolderImg, forState: UIControlState.Normal)
        }
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
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    var image = UIImage(data: data)
                    uiViewCache[url] = (image)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.imageButtonList[self.index].setBackgroundImage(image, forState: UIControlState.Normal)
                        self.index++
                    })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
        }
        
        return true
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