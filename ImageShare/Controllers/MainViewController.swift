//
//  MainViewController.swift
//  ImageShare
//
//  Created by Jeff Jin on 2014-11-19.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIDocumentMenuDelegate {

    let UTIs:Array<String> = [".jpg", ".pdf"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2.jpg")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func documentMenu(documentMenu: UIDocumentMenuViewController,
        didPickDocumentPicker documentPicker: UIDocumentPickerViewController){

    }

    
    func documentMenuWasCancelled(documentMenu: UIDocumentMenuViewController){
        println("documentMenuWasCancelled")
    }
    
    @IBAction func openDocMenu(sender: AnyObject) {
        println("Opening document menu")
        let importMenu = UIDocumentMenuViewController(documentTypes: self.UTIs, inMode: .Import)
        importMenu.delegate = self
        self.presentViewController(importMenu, animated: true, completion: nil)
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
