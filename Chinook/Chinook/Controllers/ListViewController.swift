//
//  ListViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-26.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var imageList: UITableView!
    var viewService:ViewService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("ListViewController.viewDidLoad")
        viewService = ViewService()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println("favImageList.count : \(favImageList.count)")
        return favImageList.count
        
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = favImageList[indexPath.row]
        println("favImageList[indexPath.row] : \(indexPath.row) \(favImageList[indexPath.row])")
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?{
        println("row \(indexPath.row) selected")
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("showDetails", sender: indexPath)
        
        var detailsController = viewService.getDetailsViewController()
        
        self.presentViewController(detailsController, animated: true) { () -> Void in
            println("details view loaded")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if var storedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("favImageList") {
            
            favImageList = []
            
            for var i = 0; i < storedtoDoItems.count; ++i {
                
                favImageList.append(storedtoDoItems[i] as NSString)
                
            }
        }
        println("favImageList.count : \(favImageList.count)")
        imageList.reloadData()
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var url = favImageList[indexPath.row]
            uiViewCache.removeValueForKey(url)
            favImageList.removeAtIndex(indexPath.row)
            
            let fixedFavImageList = favImageList
            NSUserDefaults.standardUserDefaults().setObject(fixedFavImageList, forKey: "favImageList")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            imageList.reloadData()
            
        }
        
        
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
