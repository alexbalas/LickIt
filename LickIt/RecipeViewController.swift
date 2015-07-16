//
//  RecipeViewController.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController, InfoRecipeCellDelegate, UICollectionViewDelegate {

    var recipe: Recipe!
    var lickedOrNot: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.recipe.name
        var recipeManager = RecipeManager()
        recipeManager.getIngredientsForRecipe(self.recipe, completionBlock: { (ingredients) -> Void in
            self.recipe.ingredients = ingredients
            self.tableView.reloadData()
        })
       // var recipeLickers: [User] = self.recipe.parseObject?.objectForKey("lickers") as [User]
//        var recipeLickers = [User(object: self.recipe.parseObject?.objectForKey("lickers")! as PFObject)]
//        var alreadyLicked = false
//        for licker in recipeLickers{
//            if( PFUser.currentUser() == licker){
//                alreadyLicked = true
//            }
//        }
        
//        if(alreadyLicked == true){
//            self.lickedOrNot = true
//        }
//        else{
//            self.lickedOrNot = false
//        }
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        switch indexPath.row {
                case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as InfoRecipeCell
            cell.delegate = self
            cell.time.text = "\(recipe.time!)"
            if(recipe.numberOfLicks != nil){
            cell.licks.text = "\(recipe.numberOfLicks!)"
            }
            else{
                cell.licks.text = "?"
            }
            cell.recipe = self.recipe
            
            if( didAlreadyLikeRecipe(PFUser.currentUser())){
                cell.lickButton.titleLabel?.text = "Licked! :P"
            }
            else{
                cell.lickButton.titleLabel?.text = "Give it a lick!"
            }
            
            return cell
//        case 2:
//            var cell = tableView.dequeueReusableCellWithIdentifier("CategoriesRecipeCell", forIndexPath: indexPath) as CategoriesRecipeCell
//            
//           // if(recipe.categorieString? != nil){
//           //     cell.categoriesLabel.text = recipe.categorieString
//            //    println("mjva")
//           // }
//            return cell
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as IngredientsRecipeCell
            if let ingredients = recipe.ingredients{
                
            cell.ingredients = ingredients
            cell.collectionView.reloadData()
            
            }
            return cell
        case 3:
            var cell = tableView.dequeueReusableCellWithIdentifier("HowToDoItCell", forIndexPath: indexPath) as HowToDoItCell
            cell.content.text = recipe.recipeDescription!
            println(recipe.recipeDescription!)
            
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
    }
    
    func didAlreadyLikeRecipe(user: PFUser) -> Bool{
        
        var relatie = self.recipe.parseObject?.relationForKey("lickers")
        var query = PFQuery(className: "Recipe")
        var relationQuery = relatie?.query().whereKey("objectId", equalTo: user.objectId)
        
        var smth = relationQuery?.getFirstObject()
        if( smth != nil ){
            return true
        }
        else{
            return false
        }
        
        if relationQuery?.getObjectWithId(PFUser.currentUser().objectId) != nil{
            return true
        }
        else{
            return false
        }
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


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            var atribute = [
                NSFontAttributeName : UIFont.systemFontOfSize(14)]
            if (self.recipe.recipeDescription != nil){
            var dimensions = (self.recipe.recipeDescription! as NSString).boundingRectWithSize(CGSize(width: self.view.frame.size.width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: atribute, context: nil)
            return dimensions.height
            }
            else{
                return 100
            }
        }
        else if indexPath.row == 2 {
            return 70
        }
/*        var footerView = self.tableView.tableFooterView;
        self.tableView.tableFooterView = nil;
        self.tableView.tableFooterView = footerView;
 */       return 100
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func infoRecipeCellSaveButtonPressed(cell: InfoRecipeCell) {
//        var savedRecipesIDs = NSUserDefaults.standardUserDefaults().arrayForKey("savedRecipes") as [String]?
//        if(savedRecipesIDs==nil){
//            savedRecipesIDs = [String]()
//        }
//        
//        savedRecipesIDs!.append(self.recipe.ID)
//        NSUserDefaults.standardUserDefaults().setObject(savedRecipesIDs, forKey: "savedRecipes")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
//        
//        
        var recipeToSave = self.recipe.toManagedObject()
        CoreDataManager.sharedInstance.saveObject(recipeToSave)
        println(44)
         //self.recipe.parseObject?.pinInBackgroundWithName("44")
//         self.recipe.parseObject?.pin()
//        self.recipe.parseObject?.save()
//        var query = PFQuery()
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
//        if(indexPath.row == 0 )
//        {
//            var recipeManager = RecipeManager()
//            recipeManager.lickRecipe(self.recipe, user: PFUser.currentUser(), completionBlock: { (success) -> Void in
//                println("succes: \(success)")
//            })
//        }
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
