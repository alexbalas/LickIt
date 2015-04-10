//
//  BookmarkedRecipeViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class BookmarkedRecipeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var recipes = [Recipe]()
    var savedRecipesIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
   
        var recipesData = NSUserDefaults.standardUserDefaults().objectForKey("recipes") as NSData
        var recipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipesData) as [Recipe]
        
        savedRecipesIDs = NSUserDefaults.standardUserDefaults().arrayForKey("savedRecipes") as [String]
        for recipe in recipes {
            if(contains(savedRecipesIDs, recipe.ID)){
                self.recipes.append(recipe)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("BookmarkedRecipeCell", forIndexPath: indexPath) as BookmarkedRecipeCell
        
        cell.name.text = recipes[indexPath.row].name
        cell.imagine.image = UIImage(named: "2")
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
