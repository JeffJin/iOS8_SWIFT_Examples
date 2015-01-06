//
//  ViewService.swift
//  Chinook
//
//  Created by Jeff Jin on 2015-01-06.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import Foundation
import UIKit


//TODO make this class singleton
class ViewService{
    
    var detailsController:DetailsViewController!
    var tabBarController:UITabBarController!
    
    init(){
        detailsController = getDetailsViewController()
        tabBarController = getTabController()
    }
    
    
    func getTabController() -> UITabBarController{
        if(tabBarController != nil){
            return tabBarController
        }
        
        tabBarController = UITabBarController()
        let tab1 = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let tab2 = ListViewController(nibName: "ListViewController", bundle: nil)
        //        let tab3 = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        let tab4 = MapViewController(nibName: "MapViewController", bundle: nil)
        let tab5 = DynamicLayoutViewController(nibName: "DynamicLayoutViewController", bundle: nil)
        let controllers = [tab1, tab2, tab4, tab5]
        tabBarController.viewControllers = controllers
        
        let firstImage = UIImage(named: "Search")
        let secondImage = UIImage(named: "List")
        let thirdImage = UIImage(named: "Details")
        tab1.tabBarItem = UITabBarItem(title: "Search", image: firstImage, tag: 1)
        tab2.tabBarItem = UITabBarItem(title: "List", image: secondImage, tag:2)
        //        tab3.tabBarItem = UITabBarItem(title: "Details", image: thirdImage, tag:3)
        tab4.tabBarItem = UITabBarItem(title: "Map", image: firstImage, tag:4)
        tab5.tabBarItem = UITabBarItem(title: "Dynamic Layout", image: secondImage, tag:5)
        
        return tabBarController
    }
    
    func getDetailsViewController()-> DetailsViewController{
        if(detailsController == nil){
            detailsController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        }
        
        return detailsController

    }
}