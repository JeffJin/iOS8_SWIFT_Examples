//
//  MasterViewController.swift
//  BlogReader
//
//  Created by Jeff Jin on 2015-01-21.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var blogService = BlogService()
    
    var refresher: UIRefreshControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
        
        let sheet = UIAlertView(title: "test title", message: "test message", delegate: self, cancelButtonTitle: "Cancel")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        loadBlogs("AIzaSyD3myoOn8_grWyGZdEWR6cjA1xgRIdx_iQ")
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refresher.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refresher)
        
    }
    
    func timerUpdate(){
        
        self.refresher.endRefreshing()
    }
    
    func reload() {
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("timerUpdate"), userInfo: nil, repeats: false)
        println("reloading blogs from google blogger")
        
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
        if event.subtype == UIEventSubtype.MotionShake {
            
            println("User Shook Their Device")
            
        }
        
    }
    
    func loadBlogs(key:String){
        //
        //        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //
        //        var context: NSManagedObjectContext = appDel.managedObjectContext!
        //
        //        let urlPath = "https://www.googleapis.com/blogger/v3/blogs/3213900/posts?key=" + key
        //
        //        let url = NSURL(string: urlPath)
        //
        //        let session = NSURLSession.sharedSession()
        //
        //        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
        //
        //            if (error != nil) { //change 'error' to '(error != nil)'
        //                println(error)
        //            } else {
        //
        //                var request = NSFetchRequest(entityName: "BlogItem")
        //
        //                request.returnsObjectsAsFaults = false
        //
        //                var results = context.executeFetchRequest(request, error: nil)! //append '!' at the end of line in order to convert optional to non-optional
        //
        //                for result in results {
        //
        //                    context.deleteObject(result as BlogItem)
        //
        //                    context.save(nil)
        //
        //                }
        //
        //
        //                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        //
        //                var items = [[String:String]()]
        //
        //                var item:AnyObject
        //
        //                var authorDictionary:AnyObject
        //
        //                var newBlogItem:BlogItem
        //
        //                for var i = 0; i < jsonResult["items"]!.count; i++ {//append '!' after [] in order to convert optional to non-optional
        //
        //                    items.append([String:String]())
        //
        //                    item = jsonResult["items"]![i] as NSDictionary  //append '!' after [] in order to convert optional to non-optional
        //
        //                    items[i]["content"] = item["content"] as? NSString
        //
        //                    items[i]["title"] = item["title"] as? NSString
        //
        //                    items[i]["publishedDate"] = item["published"] as? NSString
        //
        //                    authorDictionary = item["author"] as NSDictionary
        //
        //                    items[i]["author"] = authorDictionary["displayName"] as? NSString
        //
        //
        //                    newBlogItem = NSEntityDescription.insertNewObjectForEntityForName("BlogItem", inManagedObjectContext: context) as BlogItem
        //
        //                    newBlogItem.author = items[i]["author"]!
        //
        //                    newBlogItem.title = items[i]["title"]!
        //
        //                    newBlogItem.content = items[i]["content"]!
        //
        //                    newBlogItem.datePublished = items[i]["publishedDate"]!
        //
        //                    context.save(nil)
        //                    //TODO check if an item is already inserted
        //                    blogCache.append(BlogCacheItem(prev:newBlogItem, curr: newBlogItem, next: newBlogItem))
        //                }
        //                //build linked list
        //                for var i = 0; i < blogCache.count; i++ {
        //                    var prevIndex = i - 1
        //                    var nextIndex = i + 1
        //                    if(prevIndex < 0){
        //                        prevIndex = blogCache.count - 1
        //                    }
        //                    if(nextIndex >= blogCache.count){
        //                        nextIndex = 0
        //                    }
        //                    blogCache[i].prevItem = blogCache[prevIndex].currentItem
        //                    blogCache[i].nextItem = blogCache[nextIndex].currentItem
        //                }
        //                println(blogCache)
        //
        //                request = NSFetchRequest(entityName: "BlogItem")
        //
        //                request.returnsObjectsAsFaults = false
        //
        //                results = context.executeFetchRequest(request, error: nil)!  //append '!' at the end of line in order to convert
        //            }
        //        })
        //
        //        task.resume()
        var futureBlogs = blogService.loadBlogsFromGoogleBlogger(key)
        //var blogs = blogService.loadBlogsFromCoreData()
        futureBlogs.then(body: {(result:[[String:String]]) -> Void in

            self.blogService.saveBlogsToCoreData(result)
            
            var appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            var request = NSFetchRequest(entityName: "BlogItem")
                request.returnsObjectsAsFaults = false
            
            var results = context.executeFetchRequest(request, error: nil)!
            println(results)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as BlogItem
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject.author = "Jeff Jin"
        newManagedObject.content = "This is the content"
        newManagedObject.title = "Rock and Roll"
        newManagedObject.datePublished = "2015 Dec 13th"
        
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            let indexPath = self.tableView.indexPathForSelectedRow()!  //append '!' at the end of line in order to convert optional to non-optional
            
            var currentItem = self.fetchedResultsController.objectAtIndexPath(indexPath) as BlogItem
            
            activeItem = blogService.findCacheItem(currentItem)
            //TODO set blog cache item
            
            let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
            
            controller.navigationItem.leftBarButtonItem = self.splitViewController!.displayModeButtonItem()  //append '!' after splitViewController in order to convert optional to non-optional
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            var item = self.fetchedResultsController.objectAtIndexPath(indexPath) as BlogItem
            context.deleteObject(item)
            
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
            self.tableView.reloadData()
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as BlogItem
        cell.textLabel!.text = object.title  //append '!' before description in order to convert optional to non-optional
        cell.detailTextLabel!.text = object.author  //append '!' before description in order to convert optional to non-optional
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("BlogItem", inManagedObjectContext: self.managedObjectContext!)  //append '!' after managedObjectContext in order to convert optional to non-optional
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "datePublished", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")  //append '!' after managedObjectContext in order to convert optional to non-optional
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        var error: NSError? = nil
        if !_fetchedResultsController!.performFetch(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    /*
    // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    // In the simplest, most efficient, case, reload the table view.
    self.tableView.reloadData()
    }
    */
    
}

