//
//  SideMenuViewController.swift
//  LickIt
//
//  Created by MBP on 09/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {
    
    var dataSource = [MenuItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var mainMenuItem = MenuItem(image: UIImage(named: "home")!) { () -> (Void) in
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            var viewController = storyboard.instantiateViewControllerWithIdentifier("MainMenuViewController") as FirstMenuViewController
            self.sideMenuViewController.hideMenuViewController()
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
        }
        
        var topWantedMenuItem = MenuItem(image: UIImage(named: "top wanted")!) { () -> (Void) in
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            var viewController = storyboard.instantiateViewControllerWithIdentifier("TopWantedViewContoller") as TopWantedViewController
            self.sideMenuViewController.hideMenuViewController()
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
        }
        
        var ingredientSearchMenuItem = MenuItem(image: UIImage(named: "cookingWith")!) { () -> (Void) in
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            var viewController = storyboard.instantiateViewControllerWithIdentifier("IngredientSearchController") as IngredientSearchController
            self.sideMenuViewController.hideMenuViewController()
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)

        }
        
        var searchMenuItem = MenuItem(image: UIImage(named: "search")!) { () -> (Void) in
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            var viewController = storyboard.instantiateViewControllerWithIdentifier("SearchMenuViewController") as SearchingTableViewController
            self.sideMenuViewController.hideMenuViewController()
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            
        }
        
        var bookmarkedRecipesMenuItem = MenuItem(image: UIImage(named: "bookmarked")!) { () -> (Void) in
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var viewController = storyboard.instantiateViewControllerWithIdentifier("BookmarkedRecipesCollection") as BookmarkedRecipesCollectionViewController
            self.sideMenuViewController.hideMenuViewController()
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
        }
        
        var addNewRecipeMenuItem = MenuItem(image: UIImage(named: "clouds2")!) { () -> (Void) in
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var viewController = storyboard.instantiateViewControllerWithIdentifier("AddNewRecipeControllerViewController") as AddNewRecipeControllerViewController
            self.sideMenuViewController.hideMenuViewController()
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            
        }
        self.dataSource.append(mainMenuItem)
        self.dataSource.append(topWantedMenuItem)
        self.dataSource.append(ingredientSearchMenuItem)
        self.dataSource.append(searchMenuItem)
        self.dataSource.append(bookmarkedRecipesMenuItem)
        self.dataSource.append(addNewRecipeMenuItem)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.dataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : SideMenuCell = tableView.dequeueReusableCellWithIdentifier("SideMenuCell", forIndexPath: indexPath) as SideMenuCell
        var currentMenuItem = self.dataSource[indexPath.row]
        cell.imagine.frame = CGRect(x: 0, y: 0, width: 320, height: 81)
        cell.imagine.image = currentMenuItem.image
        
        

    return cell
}

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currentMenuItem = self.dataSource[indexPath.row]
        currentMenuItem.selectionBlock()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
