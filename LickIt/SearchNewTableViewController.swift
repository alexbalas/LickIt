//
//  SearchNewTableViewController.swift
//  LickIt
//
//  Created by MBP on 15/09/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SearchNewTableViewController: BaseTableViewController, UISearchResultsUpdating {

    
//    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(SearchNewTableViewCell.self, forCellReuseIdentifier: "SearchNewTableViewCell")
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
        return self.recipes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchNewTableViewCell", forIndexPath: indexPath) as! SearchNewTableViewCell
        
        if(self.recipes.count>0){
        
            self.recipes[indexPath.row].image!.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                var img = UIImage(data:imageData!)
                if var imag = cell.imagine {
                    imag.image = img

                }
            }
        }
        cell.name.text = self.recipes[indexPath.row].name
        cell.licks.text = "\(self.recipes[indexPath.row].numberOfLicks)"
        
        
        }
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row <= self.recipes.count && self.recipes.count>0){
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        println(indexPath.row)
        println(self.recipes.count)
        viewController.recipe = self.recipes[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
}
        println(indexPath.row)
        
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
      //  self.recipes.removeAll(keepCapacity: true)
        
        //aici trebuie facuta cautarea de elemente
        
        var manager = RecipeManager()
        manager.getSearchedRecipes(searchController.searchBar.text, completionBlock: { (retete) -> Void in
            self.recipes = retete
        })
        
        self.tableView.reloadData()
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
