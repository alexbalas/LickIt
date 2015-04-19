//
//  RecipeViewController.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController, InfoRecipeCellDelegate {

    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch indexPath.row {
                case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as InfoRecipeCell
            cell.delegate = self
            cell.time.text = "\(recipe.time!)"
            cell.licks.text = "\(recipe.numberOfLicks!)"
            
            cell.saveButton = UIButton()
            return cell
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("CategoriesRecipeCell", forIndexPath: indexPath) as CategoriesRecipeCell
            
           // if(recipe.categorieString? != nil){
           //     cell.categoriesLabel.text = recipe.categorieString
            //    println("mjva")
           // }
            return cell
        case 3:
            var cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as IngredientsRecipeCell
            cell.ingredientName.text = recipe.ingredientsString?.description
            return cell
        case 4:
            var cell = tableView.dequeueReusableCellWithIdentifier("HowToDoItCell", forIndexPath: indexPath) as HowToDoItCell
            cell.content.text = recipe.recipeDescription
            return cell

            
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as ImageRecipeCell
            
            recipe.image?.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData)
                    
                    cell.imagine.image = img
                    
                }
            }
            self.tableView.rowHeight = 110.0
            //      cell.imagine.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
            //      cell.imagine.sizeToFit()
            
            return cell

        }
        
        
        
        /*
        if(indexPath.row==0) {
        var cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as ImageRecipeCell
            
           // cell.imagine.image = UIImage(contentsOfFile: "recipe.image")
            recipe.image?.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData)
                    
                    cell.imagine.image = img

                }
            }
            self.tableView.rowHeight = 110.0
   //      cell.imagine.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
   //      cell.imagine.sizeToFit()
            
        return cell
        }
        else{if(indexPath.row == 1){

        var cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as InfoRecipeCell
            cell.delegate = self
            cell.time.text = "\(recipe.time!)"
            cell.licks.text = "\(recipe.numberOfLicks!)"

            cell.saveButton = UIButton()
            return cell
            }
        }
*/


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
