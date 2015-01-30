//
//  DetailViewController.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-21.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet var webview: UIWebView!
    
    var detailItem: AnyObject? {
        didSet {
        }
    }
    
    var blogService = BlogService()
    
    func loadView(blog:BlogItem!) {
        if(blog == nil){
            return;
        }
        // Update the user interface for the detail item.
        self.title = blog.title
        
        webview.loadHTMLString(blog.content, baseURL: nil)
    }
    
    func loadNextView(){
        self.loadView(activeItem.nextItem)
        activeItem = blogService.findCacheItem(activeItem.nextItem)
    }
    
    func loadPreviousView(){
        self.loadView(activeItem.prevItem)
        activeItem = blogService.findCacheItem(activeItem.prevItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(activeItem != nil){
            self.loadView(activeItem.currentItem)
        }
        //
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
    }

    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                loadPreviousView()
            case UISwipeGestureRecognizerDirection.Left:
                loadNextView()
            default:
                break
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


