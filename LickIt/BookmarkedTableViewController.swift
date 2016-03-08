//
//  BookmarkedTableViewController.swift
//  LickIt
//
//  Created by MBP on 15/09/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class BookmarkedTableViewController: BaseTableViewController {
    
    var recipes = [Recipe]()
    //    var savedRecipesIDs = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Recipe").fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            for object in objects!{
                let recipe = Recipe(object: object as! PFObject)
                self.recipes.append(recipe)
            }
            self.tableView.reloadData()
            
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.recipes[indexPath.row].parseObject?.unpinInBackgroundWithName(self.recipes[indexPath.row].name!)
            self.recipes.removeAtIndex(indexPath.row)
        }
        
        /*        if (editingStyle == UITableViewCellEditingStyle.Insert){
        Plus(persons)
        }
        */
        self.tableView.reloadData()
        // handle delete (by removing the data from your array and updating the tableview)
        
    }
    
    override func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        
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
        return recipes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkedTableViewCell", forIndexPath: indexPath) as! BookmarkedTableViewCell
        
        
        recipes[indexPath.item].image?.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                //aici se intampla sfanta transormare din imagine in thumbnail
                let imagine = UIImage(data: imageData!)
                let destinationSize = cell.imagine.frame.size
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell.imagine.image = nouaImagine

            }
        }
        
        cell.name.text = "\(recipes[indexPath.item].name!)"
        
        return cell
        
        // Configure the cell...
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
        viewController.recipe = recipes[indexPath.item]
        viewController.isSavedRecipe = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    deinit {
        debugPrint("Name_of_view_controlled deinitialized...")
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
