//
//  AppDelegate.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import RealReachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor=UIColor.whiteColor()
        window?.rootViewController = MainTabBarController()
        
        initNavigationBar()
        openRealReachability()
        
        window?.makeKeyAndVisible()
        return true
    }
    func initNavigationBar() {
        //导航背景颜色
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(CGFloat(NSInteger.min),CGFloat(NSInteger.min)), forBarMetrics:UIBarMetrics.Default)
        //导航标题文字颜色
        UINavigationBar.appearance().titleTextAttributes = NSDictionary(object:UIColor.whiteColor(), forKey:NSForegroundColorAttributeName) as? [String : AnyObject]
        UINavigationBar.appearance().barTintColor = YYMain_Color
        //将状态栏变为白色
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
    }
    /**
     开启网络监控
     */
    func openRealReachability () {
        RealReachability.sharedInstance().startNotifier()
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

