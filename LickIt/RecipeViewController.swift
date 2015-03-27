//
//  RecipeViewController.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class RecipeViewController: BaseTableViewController, InfoRecipeCellDelegate {

    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(recipe.numberOfLicks)
        println(recipe.time)
        // Do any additional setup after loading the view.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell : UITableViewCell = UITableViewCell()
        
        if(indexPath.row==0) {
        var cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as ImageRecipeCell
            
            cell.imagine.image = recipe.image
            self.tableView.rowHeight = 140.0
            
            return cell
        }
        else{

        var cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as InfoRecipeCell
            cell.delegate = self
            cell.time.text = "\(recipe.time!)"
            cell.licks.text = "\(recipe.numberOfLicks!)"

            cell.saveButton = UIButton()
            return cell
           
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func infoRecipeCellSaveButtonPressed(cell: InfoRecipeCell) {
        var savedRecipesIDs = NSUserDefaults.standardUserDefaults().arrayForKey("savedRecipes") as [String]?
        if(savedRecipesIDs==nil){
            savedRecipesIDs = [String]()
        }
        
        savedRecipesIDs!.append(self.recipe.ID)
        NSUserDefaults.standardUserDefaults().setObject(savedRecipesIDs, forKey: "savedRecipes")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
