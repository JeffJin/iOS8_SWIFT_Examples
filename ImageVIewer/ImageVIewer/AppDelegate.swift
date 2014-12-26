//
//  AppDelegate.swift
//  ImageVIewer
//
//  Created by Coho on 2014-12-06.
//  Copyright (c) 2014 Coho. All rights reserved.
//

import UIKit


var favImageList:[String] = []
var uiViewCache = Dictionary<String, UIImage>()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let tabBarController = UITabBarController()
        let tab1 = ImageSearchController()
        let tab2 = ImageListController()
        let tab3 = ImageListController()
        let controllers = [tab1, tab2, tab3]
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
        let firstImage = UIImage(named: "Search")
        let secondImage = UIImage(named: "List")
        let thirdImage = UIImage(named: "Details")
        tab1.tabBarItem = UITabBarItem(title: "Search", image: firstImage, tag: 1)
        tab2.tabBarItem = UITabBarItem(title: "List", image: secondImage, tag:2)
        tab2.tabBarItem = UITabBarItem(title: "Details", image: thirdImage, tag:3)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

