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
        midTxt.text = "9089"
        tokenTxt.text = "1c0c7f65-1821-4929-9f1f-4b3be3b37215"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var baseUrl = "http://localhost:9000/"
    
    @IBAction func loadSite(sender: AnyObject) {
        loadWebsite(tokenTxt.text, merchantId: midTxt.text)
    }
    
    
    func loadWebsite(token:NSString, merchantId:NSString){
        
        
        var url = NSURL(string: baseUrl + "#/merchant?token=" + token + "&merchantId=" + merchantId)
        
        var request = NSURLRequest(URL:url!)
        
        webview.loadRequest(request)
        
        
        
        //        var html = "<html><head></head><body><h1>Hello World!</h1></body></html>"
        //
        //        webview.loadHTMLString(html, baseURL: nil)
    }
}

