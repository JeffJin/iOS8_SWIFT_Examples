//
//  DynamicLayoutViewController.swift
//  Chinook
//
//  Created by Jeff Jin on 2014-12-30.
//  Copyright (c) 2014 Jeff Jin. All rights reserved.
//

import UIKit

class DynamicLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        var vLayout = VerticalLayout(width: view.frame.width)
        vLayout.backgroundColor = UIColor.cyanColor()
        view.addSubview(vLayout)
        
        var heightUnit:CGFloat = (view.frame.height) / 4
        
        var widthUnit:CGFloat = (view.frame.width) / 4
        println("width: \(widthUnit), height: \(heightUnit)")
        let view1 = createHorizontalLayout(heightUnit,  widthUnit: widthUnit, color:  UIColor.lightGrayColor(), index: 1)
        let view2 = createHorizontalLayout(heightUnit,  widthUnit: widthUnit, color:  UIColor.grayColor(), index: 2)
        let view3 = createHorizontalLayout(heightUnit, widthUnit: widthUnit, color:  UIColor.lightGrayColor(), index: 3)
        let view4 = createHorizontalLayout(heightUnit, widthUnit: widthUnit, color:  UIColor.grayColor(), index: 4)
        vLayout.addSubview(view1)
        vLayout.addSubview(view2)
        vLayout.addSubview(view3)
        vLayout.addSubview(view4)
        
    }
    
    func createHorizontalLayout(heightUnit:CGFloat, widthUnit:CGFloat, color: UIColor, index: Int) -> HorizontalLayout{
        let layout = HorizontalLayout(height: heightUnit)
        layout.backgroundColor = color
        
        layout.addSubview(getImageButtonView(1, j: index, w: widthUnit, h: heightUnit))
        layout.addSubview(getImageButtonView(2, j: index, w: widthUnit, h: heightUnit))
        layout.addSubview(getImageButtonView(3, j: index, w: widthUnit, h: heightUnit))
        layout.addSubview(getImageButtonView(4, j: index, w: widthUnit, h: heightUnit))
        
        return layout
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImageButtonView(i: Int, j: Int, w: CGFloat, h: CGFloat)-> UIButton{
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, w, h)
        button.setTitle("\(i) X \(j)", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState:UIControlState.Normal)
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: "selectTargetImage:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    
    func selectTargetImage(sender:UIButton){
        var button:UIButton = sender
        selectedImageButton = button
        //animate the clicked button
        UIView.animateWithDuration(0.5, animations: { button.alpha = 0 }, completion:{_ in
            UIView.animateWithDuration(0.5, animations: { button.alpha = 1 })
        })
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
