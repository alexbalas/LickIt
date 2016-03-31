//
//  SideMenuViewController.swift
//  LickIt
//
//  Created by MBP on 09/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController{
    
    var dataSource = [MenuItem]()
    var cellSize = CGRect()
    var c1 = UIViewController()
    var c2 = UITableViewController()
    var c3 = UIViewController()
    var c4 = UITableViewController()
    var c5 = UITableViewController()
    var c6 = UITableViewController()
    var controllere = [UIViewController]()
    
    func dismissAllControllers(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        for controller in (appDelegate.mainViewController?.viewControllers)!{
            controller.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mainMenuItem = MenuItem(image: UIImage(named: "home")!) { () -> (Void) in
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainMenuViewController") as! FirstMenuViewController
            
            //de test
            //self.controllere.append(viewController)
            //
            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
           // self.view.window?.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
            
            //self.navigationController?.visibleViewController?.dismissViewControllerAnimated(false, completion: nil)
            
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
        }
        
        let topWantedMenuItem = MenuItem(image: UIImage(named: "top wanted")!) { () -> (Void) in
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("TopWantedViewContoller") as! TopWantedViewController
            self.controllere.append(viewController)

            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)

            //appDelegate.mainViewController?.pushViewController(viewController, animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
    //        appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
        }
        
        let bookmarkedTableViewControllerItem = MenuItem(image: UIImage(named: "bookmarked")!) { () -> (Void) in
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("BookmarkedTableViewController") as! BookmarkedTableViewController
            self.controllere.append(viewController)

            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
            // appDelegate.mainViewController?.pushViewController(viewController, animated: true)
        }
        let ingredientSearchMenuItem = MenuItem(image: UIImage(named: "cookingWith")!) { () -> (Void) in
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("IngredientSearchController") as! IngredientSearchController
            self.controllere.append(viewController)

            viewController.isIngredientSearch = true
            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
            //appDelegate.mainViewController?.pushViewController(viewController, animated: true)
        }
        
        let newSearchMenuItem = MenuItem(image: UIImage(named: "search")!) { () -> (Void) in
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchNewTableViewController") as! SearchNewTableViewController
            self.controllere.append(viewController)

            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
            //appDelegate.mainViewController?.pushViewController(viewController, animated: true)
        }
        
        let addRecipeItem = MenuItem(image: UIImage(named: "addrecipe")!) { () -> (Void) in
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddRecipeViewController") as! AddRecipeViewController
            self.controllere.append(viewController)

            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
            //appDelegate.mainViewController?.pushViewController(viewController, animated: true)
        }
        
        let achievementsItem = MenuItem(image: UIImage(named: "addrecipe")!) { () -> (Void) in
            let viewController = AchievementsTableViewController()
            self.controllere.append(viewController)

            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
            //appDelegate.mainViewController?.pushViewController(viewController, animated: true)
        }
        
        let supportItem = MenuItem(image: UIImage(named: "addrecipe")!) { () -> (Void) in
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("Support") as! SupportViewController
            self.sideMenuViewController.hideMenuViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
            print("_____________")
            print(appDelegate.mainViewController?.viewControllers)
            //appDelegate.mainViewController?.pushViewController(viewController, animated: true)
        }
        print("SIDEMENU: in view did load marimea e")
        print(self.cellSize)
        print(UIScreen.mainScreen().bounds)
//        var searchMenuItem = MenuItem(image: UIImage(named: "search")!) { () -> (Void) in
//            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            
//            var viewController = storyboard.instantiateViewControllerWithIdentifier("SearchMenuViewController") as! SearchingTableViewController
//            self.sideMenuViewController.hideMenuViewController()
//            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//          //  appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
//            appDelegate.mainViewController?.pushViewController(viewController, animated: true)
//
//        }
        
//        var bookmarkedRecipesMenuItem = MenuItem(image: UIImage(named: "bookmarked")!) { () -> (Void) in
//            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            var viewController = storyboard.instantiateViewControllerWithIdentifier("BookmarkedRecipesCollection") as! BookmarkedRecipesCollectionViewController
//            self.sideMenuViewController.hideMenuViewController()
//            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            //appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
//            appDelegate.mainViewController?.pushViewController(viewController, animated: true)
//
//        }
        
//        var addNewRecipeMenuItem = MenuItem(image: UIImage(named: "add recipe")!) { () -> (Void) in
//            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            var viewController = storyboard.instantiateViewControllerWithIdentifier("AddNewRecipeControllerViewController") as! AddNewRecipeControllerViewController
//            self.sideMenuViewController.hideMenuViewController()
//            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            //appDelegate.mainViewController?.setViewControllers([viewController], animated: true)
//            appDelegate.mainViewController?.pushViewController(viewController, animated: true)
//
//        }
//        
//        var loginItem = MenuItem(image: UIImage(named: "add recipe")!) { () -> (Void) in
//            
//                var loginViewController = PFLogInViewController()
//                loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter
//                loginViewController.title = "Login"
//                //self.presentViewController(loginViewController, animated: true) { () -> Void in   }
//            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            appDelegate.mainViewController?.pushViewController(loginViewController, animated: true)
//        }
        
        
        self.dataSource.append(mainMenuItem)
        self.dataSource.append(topWantedMenuItem)
        self.dataSource.append(ingredientSearchMenuItem)
        self.dataSource.append(newSearchMenuItem)
        self.dataSource.append(bookmarkedTableViewControllerItem)
        self.dataSource.append(addRecipeItem)
        self.dataSource.append(achievementsItem)
    //    self.dataSource.append(supportItem)
//        self.dataSource.append(searchMenuItem)
//        self.dataSource.append(bookmarkedRecipesMenuItem)
//        self.dataSource.append(addNewRecipeMenuItem)
//            self.dataSource.append(loginItem)
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
        let cell : SideMenuCell = tableView.dequeueReusableCellWithIdentifier("SideMenuCell", forIndexPath: indexPath) as! SideMenuCell
        let currentMenuItem = self.dataSource[indexPath.row]
        cell.imagine.frame = CGRect(x: 0, y: 0, width: 320, height: 81)
        cell.imagine.image = currentMenuItem.image
        
        self.cellSize = cell.frame
        print("ar trebui sa fie")
        print(self.cellSize)

    return cell
}

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentMenuItem = self.dataSource[indexPath.row]
        currentMenuItem.selectionBlock()
     //   let cell = self.tableView.cellForRowAtIndexPath(indexPath)
       // print("marimea este")
        //print(cell?.frame)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.height/7
    }
    
    deinit {
        self
        print("deinitCalled")
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
