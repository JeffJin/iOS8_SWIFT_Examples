//
//  FirstViewController.swift
//  ImageVIewer
//
//  Created by Coho on 2014-12-06.
//  Copyright (c) 2014 Coho. All rights reserved.
//

import UIKit

var favImageList:[String] = []
var uiViewCache = Dictionary<String, UIImage>()

class FirstViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet var imagesTable: UITableView!
    
    @IBOutlet var previewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    override func viewWillAppear(animated: Bool) {
        
        if var storedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("favImageList") {
            
            favImageList = []
            
            for var i = 0; i < storedtoDoItems.count; ++i {
                
                favImageList.append(storedtoDoItems[i] as NSString)
                
            }
        }
        println("favImageList.count : \(favImageList.count)")
        imagesTable.reloadData()
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var url = favImageList[indexPath.row]
            uiViewCache.removeValueForKey(url)
            favImageList.removeAtIndex(indexPath.row)
            
            let fixedFavImageList = favImageList
            NSUserDefaults.standardUserDefaults().setObject(fixedFavImageList, forKey: "favImageList")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            imagesTable.reloadData()
            
        }
        
        
    }

}

