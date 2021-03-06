//
//  AppDelegate.swift
//  LickIt
//
//  Created by MBP on 13/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import iAd
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController : UINavigationController?
    var leftViewController : UIViewController?
    var sideMenu : UIViewController?
    

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        
        self.mainViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as? UINavigationController
        self.leftViewController = storyboard.instantiateViewControllerWithIdentifier("SideMenuViewController") as! SideMenuViewController
        self.sideMenu = RESideMenu(contentViewController: mainViewController, leftMenuViewController: leftViewController, rightMenuViewController: nil)
        
        self.window!.rootViewController = sideMenu
//        
        
        //parse settings
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("LwxamL5Rx5AOtWuSDhwuVeYPLW7XXwKKBBhvx75g", clientKey: "rNxWpsRBxMuctjLoZ4PcLFa0izmwPl6FxzZuto3W")
        if let options = launchOptions{
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(options)
        }
        else{
            PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(Dictionary())
        }
        PFTwitterUtils.initializeWithConsumerKey("wdtgoD0ZuXk6HjGntWB3MsmMl", consumerSecret: "YlMd3Ua47psUKObrvdhCBj7wyzuPakMGbNczQKgBjyAAHqp2Og")
        
        

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
        FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "WasClosed")
        NSUserDefaults.standardUserDefaults().synchronize()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

}

