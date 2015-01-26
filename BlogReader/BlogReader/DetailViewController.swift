//
//  DetailViewController.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-21.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet var webview: UIWebView!
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            println("detailItem, \(activeIndex.row)")
            self.loadNextView(activeIndex)
        }
    }
    
    func loadView(blog:BlogItem!) {
        if(blog == nil){
            return;
        }
        // Update the user interface for the detail item.
        self.title = blog.title

        webview.loadHTMLString(blog.content, baseURL: nil)
    }
    
    func loadNextView(indexPath:NSIndexPath){
        activeIndex = NSIndexPath(index: (indexPath.row + 1))
        activeItem = loadItem(activeIndex)
        self.loadView(activeItem)
    }
    
    func loadPreviousView(indexPath:NSIndexPath){
        activeIndex = NSIndexPath(index: (indexPath.row - 1))
        activeItem = loadItem(activeIndex)
        self.loadView(activeItem)
    }
    
    func loadItem(index:NSIndexPath) -> BlogItem! {
      return activeItem
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(activeIndex == nil){
            return;
        }
        println("viewDidLoad, \(activeIndex.row)")
        self.loadNextView(activeIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


