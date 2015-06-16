//
//  TopWantedViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class TopWantedViewController: BaseTableViewController {

    var topRecipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var manager = RecipeManager()
        manager.getTopRecipes(4, completionBlock: { (recipes) -> Void in
            self.topRecipes = recipes
            self.tableView.reloadData()
        })
        
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
        return topRecipes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            var cell = tableView.dequeueReusableCellWithIdentifier("TopWantedRecipeCell", forIndexPath: indexPath) as TopWantedRecipeCell
            topRecipes[indexPath.row].image?.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    cell.recipeImage.image = UIImage(data:imageData)
                }
            }
        if(self.topRecipes[indexPath.row].numberOfLicks != nil){
            cell.nrOfLicks.text = "\(self.topRecipes[indexPath.row].numberOfLicks!)"
        }
        else{
            cell.nrOfLicks.text = "?"
        }
 //       cell.nrOfLicks.text = "\(self.topRecipes[indexPath.row].numberOfLicks?)"

            cell.recipeName.text = topRecipes[indexPath.row].name!
            cell.userName.text = "by " + "ALEX"
            
            self.tableView.rowHeight = 90.0
            return cell

        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as RecipeViewController
        
        viewController.recipe = topRecipes[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
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
