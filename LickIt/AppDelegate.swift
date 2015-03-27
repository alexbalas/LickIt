//
//  AppDelegate.swift
//  LickIt
//
//  Created by MBP on 13/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController : UINavigationController?
    var leftViewController : UIViewController?
    var sideMenu : UIViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        self.mainViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as? UINavigationController
        self.leftViewController = storyboard.instantiateViewControllerWithIdentifier("SideMenuViewController") as SideMenuViewController
        self.sideMenu = RESideMenu(contentViewController: mainViewController, leftMenuViewController: leftViewController, rightMenuViewController: nil)
        self.window!.rootViewController = sideMenu
        
        var recipes = [Recipe]()
        
        var recipeOne = Recipe(ID : "123")
        recipeOne.name = "Prima Reteta"
        recipeOne.numberOfLicks = 22
        recipeOne.image = UIImage(named: "1")
        recipeOne.time = 23
        recipeOne.recipeDescription = "lot of work"
        
        var recipeTwo : Recipe = Recipe(ID : "124")
        recipeTwo.name = "A doua reteta"
        recipeTwo.numberOfLicks = 44
        recipeTwo.image = UIImage(named: "2")
        recipeTwo.time = 55
        recipeTwo.recipeDescription = "just cook it"
        
        
        var anotherRecipe : Recipe = Recipe(ID : "125")
        anotherRecipe.numberOfLicks = 33
        anotherRecipe.name = "A treia reteta"
        anotherRecipe.image = UIImage(named: "3")
        anotherRecipe.time = 11
        anotherRecipe.recipeDescription = "nothing"
        
        recipes.append(recipeOne)
        recipes.append(recipeTwo)
        recipes.append(anotherRecipe)
        
        var recipeData = NSKeyedArchiver.archivedDataWithRootObject(recipes)
        NSUserDefaults.standardUserDefaults().setObject(recipeData, forKey: "recipes")
        NSUserDefaults.standardUserDefaults().synchronize()
        
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

