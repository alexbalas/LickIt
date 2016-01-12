//
//  RecipeViewController.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol RecipeControllerDelegate {
    func refresh()
}

class RecipeViewController: UITableViewController, InfoRecipeCellDelegate, UICollectionViewDelegate,UIPopoverPresentationControllerDelegate, OneIngredientRecipeCellDelegate {
    
    
    var recipe: Recipe!
    var lickedOrNot: Bool!
    var savedOrNot = false
    var backButtonText: String?
    var didInteractWithLickButton = false
    var delegate: RecipeControllerDelegate!
    var isInTutorial = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.recipe.name
        var recipeManager = RecipeManager()
        recipeManager.getIngredientsForRecipe(self.recipe, completionBlock: { [weak self] (ingredients) -> Void in
            self?.recipe.ingredients = ingredients
            
            self?.tableView.reloadData()
            })

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Recipe", style: UIBarButtonItemStyle.Plain, target: nil, action: "setBackButton:")

    }
    


    
    func hidePopup()
    {
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            
        })
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    
    
    func showPopup(name: String, cell: UIView){
        
        var menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        var _ = menuViewController.view
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSizeMake(100, 60)
        menuViewController.name?.text = name
        
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = cell
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, 100, 60)
        
        
        
        println(menuViewController.name?.text)
        
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
    }
    
    func setBackButton(buton: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.delegate.refresh()
            
        })
    }
    func expandButtonPressed(){
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as! InfoRecipeCell
            cell.delegate = self
            cell.time.text = "\(recipe.time!)"+" min"
            if(recipe.numberOfLicks != nil){
                cell.licks.text = "\(recipe.numberOfLicks!)"
            }
            else{
                cell.licks.text = "?"
            }
            if(self.savedOrNot == true){
                cell.saveButton.titleLabel?.text = "you have it"
            }
            
            cell.setParseRecipe(recipe)
            return cell
            
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as! IngredientsRecipeCell
            if let ingredients = recipe.ingredients{
                
                cell.ingredients = ingredients
                cell.collectionView.reloadData()
                cell.delegate = self
                
            }
            return cell
        case 3:
            var cell = tableView.dequeueReusableCellWithIdentifier("HowToDoItCell", forIndexPath: indexPath) as! HowToDoItCell
            cell.content.text = recipe.recipeDescription!
            
            return cell
            
            
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as! ImageRecipeCell
            
            recipe.image?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                cell.imagine.image = UIImage(data:data!)
                
                
            })
            
            self.tableView.rowHeight = 110.0
            //      cell.imagine.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
            //      cell.imagine.sizeToFit()
            
            return cell
            
        }
    }
    
    //    func didAlreadyLikeRecipe(user: PFUser) -> Bool{
    //
    //        var relatie = self.recipe.parseObject?.relationForKey("lickers")
    //        var query = PFQuery(className: "Recipe")
    //        var relationQuery = relatie?.query()!.whereKey("objectId", equalTo: user.objectId!)
    //
    //        var smth = relationQuery?.getFirstObject()
    //        if( smth != nil ){
    //            return true
    //        }
    //        else{
    //            return false
    //        }
    //    }
    
    //    func didLikeRecipe(user: PFUser, completionBlock:(PFUser) -> Void){
    //        var relatie = self.recipe?.parseObject?.relationForKey("lickers")
    //        var query = PFQuery(className: "Recipe")
    //        var relationQuery = relatie?.query()!.whereKey("objectId", equalTo: user.objectId!)
    //        var smth: Void? = relationQuery?.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
    //            var usser = PFUser()
    //            if let uzer = object as? PFUser{
    //                usser = uzer
    //            }
    //            completionBlock(usser)
    //        })
    //    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            var atribute = [
                NSFontAttributeName : UIFont.systemFontOfSize(14)]
            if (self.recipe.recipeDescription != nil){
                var dimensions = (self.recipe.recipeDescription! as NSString).boundingRectWithSize(CGSize(width: self.view.frame.size.width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: atribute, context: nil)
                return 1.3*dimensions.height
            }
            else{
                return 100
            }
        }
        else if indexPath.row == 2 {
            return 70
        }
        return 100
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func infoRecipeCellSaveButtonPressed() {
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
        
        //        var recipeToSave = self.recipe.toManagedObject()
        //        CoreDataManager.sharedInstance.saveObject(recipeToSave)
        //        println(44)
        
        //self.recipe.parseObject?.pinInBackgroundWithName("44")
        //         self.recipe.parseObject?.pin()
        //        self.recipe.parseObject?.save()
        //        var query = PFQuery()
        self.recipe.parseObject?.pinInBackgroundWithName(self.recipe.name!)
  //      println(if(self.recipe.parseObject["pfFile"]))
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        if(indexPath.row==0){
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var viewController = storyboard.instantiateViewControllerWithIdentifier("FullScreenImageController") as! FullScreenPicController
            
            viewController.imageFile = self.recipe.image
            viewController.nume = self.recipe.name
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func loginControllerShouldAppear() {
        var loginViewController = LogInViewController()
        loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter | PFLogInFields.DismissButton
        self.presentViewController(loginViewController, animated: true) { () -> Void in
        }
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        println("deinitCalled")
    }
    
}
