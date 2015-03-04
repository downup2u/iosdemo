//
//  AppDelegate.swift
//  xkcrm
//
//  Created by 小庆 王 on 15-2-17.
//  Copyright (c) 2015年 wangxiaoqing. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var menuController:DrawerMenuController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var mainview:MainViewController = storyboard.instantiateViewControllerWithIdentifier("mainview") as MainViewController
      
        var navview:UIViewController = storyboard.instantiateViewControllerWithIdentifier("navview") as UIViewController
        var calendarview:UIViewController = storyboard.instantiateViewControllerWithIdentifier("calendarview") as UIViewController
        
        var navigationViewController = UINavigationController(rootViewController: mainview)
        var drawerMenuController:DrawerMenuController = DrawerMenuController()
        drawerMenuController.rootViewController = navigationViewController
        drawerMenuController.leftViewController = navview
        drawerMenuController.rightViewController = calendarview
        drawerMenuController.needSwipeShowMenu = true
        drawerMenuController.leftViewShowWidth = 160.0
        drawerMenuController.rightViewShowWidth = 300.0
        (UIApplication.sharedApplication().delegate as AppDelegate).menuController = drawerMenuController
        (UIApplication.sharedApplication().delegate as AppDelegate).menuController?.delegate = mainview
        window?.rootViewController = drawerMenuController;

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

