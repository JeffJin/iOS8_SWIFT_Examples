//
//  ImgShareTableViewController.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-12.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class ImgShareTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        
        // 3
        let row = indexPath.row
        
        cell.textLabel.text = "Index Row\(row)"
        cell.detailTextLabel?.text = "Detail Text Label\(indexPath.row)"
        return cell
    }    
}
