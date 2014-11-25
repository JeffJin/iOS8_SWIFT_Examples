//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 7/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {
  
  @IBOutlet var keywordField : UITextField!
@IBOutlet var scalePctSlider : UISlider!


  let imgService = ImageService(conf: "")
    
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func scalePercentageChanged(sender : AnyObject) {
       println("Percentage slider changed \(scalePctSlider.value)")
  }
  @IBAction func viewTapped(sender : AnyObject) {
    println("View tapped")
    keywordField.resignFirstResponder()
  }

}

