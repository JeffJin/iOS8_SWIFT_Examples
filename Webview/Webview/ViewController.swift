//
//  ViewController.swift
//  Webview
//
//  Created by Jeff Jin on 2015-01-11.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var loadWebsite: UIButton!
    @IBOutlet var tokenTxt: UITextField!
    @IBOutlet var midTxt: UITextField!
    @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        midTxt.text = "4444"
        tokenTxt.text = "779a92a6-d0de-4efa-b60c-cfe163e017b3"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var baseUrl = "https://qa.lumos.xyz/2.0/#/"
    
    @IBAction func loadSite(sender: AnyObject) {
        loadWebsite(tokenTxt.text, merchantId: midTxt.text)
    }
    
    
    func loadWebsite(token:NSString, merchantId:NSString){
        //?token=8e1a80ae-9cda-4102-993d-78a2522dd78d&merchantId=9089
        
        var url = NSURL(string: baseUrl + "web-orders/new?token=" + token + "&merchantId=" + merchantId)
        
        var request = NSURLRequest(URL:url!)
        
        webview.loadRequest(request)
        
        
        
        //        var html = "<html><head></head><body><h1>Hello World!</h1></body></html>"
        //
        //        webview.loadHTMLString(html, baseURL: nil)
    }
}

