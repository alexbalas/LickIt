//
//  SearchingTableViewController.swift
//  LickIt
//
//  Created by MBP on 01/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SearchingTableViewController: BaseTableViewController, UITextFieldDelegate, SearchingInputCellDelegate {

    var foundRecipes = [Recipe]()
    
    
  //  @IBAction func searchButtonPressed(sender: AnyObject) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "Search"
        //    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchButtonPressed:")
        
    //    var recipeData = NSUserDefaults.standardUserDefaults().objectForKey("recipes") as NSData
     //   self.recipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipeData) as [Recipe]

        
        
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
        return foundRecipes.count+1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.row==0){
            var cell = tableView.dequeueReusableCellWithIdentifier("SearchingInputCell", forIndexPath: indexPath) as SearchingInputCell
            cell.delegate = self
            self.tableView.rowHeight = 100
        return cell
        }
        else{
            var cell = tableView.dequeueReusableCellWithIdentifier("SearchingResultCell", forIndexPath: indexPath) as SearchingResultCell
         //   cell.photo.image = foundRecipes[indexPath.row].image
            foundRecipes[indexPath.row + 1].image?.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    cell.photo.image = UIImage(data:imageData)!
                }
            }
            cell.licks.text = "\(foundRecipes[indexPath.row + 1].numberOfLicks!)"
            cell.name.text = foundRecipes[indexPath.row + 1].name
            return cell
        }
        // Configure the cell...
        
    }
    
    func searchingInputCellGotMagicWord(magicWord: String){
        println("L-a trimis!!")
        print(magicWord)
        var manager = RecipeManager()
        manager.getSearchedRecipes(magicWord, completionBlock: { (recipesss) -> Void in
            self.foundRecipes = recipesss
            self.tableView.reloadData()
        })
        println(foundRecipes)
    
    
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
