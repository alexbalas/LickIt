//
//  RecipeViewController.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol RecipeControllerDelegate {
    func refresh(indexPath: NSIndexPath)
    func revineInTutorial()
}

class RecipeViewController: UITableViewController, InfoRecipeCellDelegate, UICollectionViewDelegate,UIPopoverPresentationControllerDelegate, OneIngredientRecipeCellDelegate, PFLogInViewControllerDelegate {
    
    
    var recipe: Recipe!
    var lickedOrNot: Bool!
    var savedOrNot = false
    var backButtonText: String?
    var didInteractWithLickButton = false
    var delegate: RecipeControllerDelegate?
    var isInTutorial = false
    var indexPath: NSIndexPath?
    weak var currentMaskView = UIView()
    var rects = [CGRect]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.recipe.name
        var recipeManager = RecipeManager()
        recipeManager.getIngredientsForRecipe(self.recipe, completionBlock: { [weak self] (ingredients) -> Void in
            self?.recipe.ingredients = ingredients
            
            self?.tableView.reloadData()
            })
        var img = UIImage(named: "back")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed:")
        
        if self.isInTutorial{
            createMaskForCell(0,message: "The big pic!")
        }

    }
  
    func createMaskForCell(nrCell: Int, message: String){
        var indexPath = NSIndexPath(forRow: nrCell, inSection: 0)
        var cell = UITableViewCell()
        switch nrCell {
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as! InfoRecipeCell
            
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as! IngredientsRecipeCell
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("HowToDoItCell", forIndexPath: indexPath) as! HowToDoItCell
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as! ImageRecipeCell

            
            
        }

//        var cellRect = self.rects[nrCell]//cellForRowAtIndexPath(NSIndexPath(forRow: nrCell+1, inSection: 1))!.frame
//        println(self.tableView.rectForRowAtIndexPath(NSIndexPath(forRow: nrCell+1, inSection: 1)))
//        cellRect = CGRectMake(cellRect.origin.x - tableView.contentOffset.x, cellRect.origin.y - tableView.contentOffset.y, cellRect.size.width, cellRect.size.height)
   //     var height = self.tableView(self.tableView, heightForRowAtIndexPath: indexPath)
   //     var circleRekt = CGRect(x: cell.frame.origin.x, y: 174, width: cell.frame.width, height: cell.frame.height)
        creazaGauraCuImagine(cell, circleRekt: cell.frame)
        showPopup(message, sourceViewRekt: cell.frame, width: 100, height: 60)
    }
    
    func creazaGauraCuImagine(viu: UIView, circleRekt: CGRect){
        
        var currentWindow = UIApplication.sharedApplication().keyWindow
        
        var mapView = viu
        mapView.clipsToBounds = false
        
        let frame = mapView.frame
        
        // Add the mask view
        
        var circleArray = [CGRect]()
        //to change the circle customize next line
        circleArray.append(circleRekt)
        
        
        let maskColor = UIColor(white: 0.2, alpha: 0.65)        //UIColor(red: 0.9, green: 0.5, blue: 0.9, alpha: 0.5)
        let parentView = currentWindow//mapView.superview
        let pFrame = parentView!.frame
        var maskView = PartialTransparentMaskView(frame: CGRectMake(0, 0, pFrame.width, pFrame.height), backgroundColor: maskColor, transparentRects: nil, transparentCircles:circleArray, targetView: mapView)
        //pana aici s-a creat ecranul negru cu gauri
        //de aici pui imaginea peste ecranul negru
        
        self.currentMaskView = maskView
        parentView!.insertSubview(maskView, aboveSubview: mapView)
        
    }

    
    func showPopup(name: String, sourceViewRekt: CGRect, width: CGFloat, height: CGFloat){
        
        var menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        var _ = menuViewController.view
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSizeMake(width, height)
        menuViewController.name?.text = name
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        let sourceView = UIView(frame: sourceViewRekt)
        self.view.addSubview(sourceView)
        popoverMenuViewController?.sourceView = sourceView
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, width, height)
        
        
        
        println(menuViewController.name?.text)
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
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
    

    
    func settedBackButtonPressed(buton: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    
        if self.delegate != nil{
            self.delegate?.refresh(self.indexPath!)
            self.delegate?.revineInTutorial()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.popViewControllerAnimated(true)
        // self.dismissViewControllerAnimated( true, completion: nil)
        
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
            self.rects.append(cell.frame)

            
            return cell
            
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as! IngredientsRecipeCell
            if let ingredients = recipe.ingredients{
                
                cell.ingredients = ingredients
                cell.collectionView.reloadData()
                cell.delegate = self
                
            }
            self.rects.append(cell.frame)

            return cell
        case 3:
            var cell = tableView.dequeueReusableCellWithIdentifier("HowToDoItCell", forIndexPath: indexPath) as! HowToDoItCell
            cell.content.text = recipe.recipeDescription!
            self.rects.append(cell.frame)

            return cell
            
            
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as! ImageRecipeCell
            
            recipe.image?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                cell.imagine.image = UIImage(data:data!)
                
                
            })
            
            self.tableView.rowHeight = 110.0
            //      cell.imagine.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
            //      cell.imagine.sizeToFit()
            self.rects.append(cell.frame)
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
            
            if(self.isInTutorial){
                hidePopup()
                self.currentMaskView!.removeFromSuperview()
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func loginControllerShouldAppear() {
        var loginViewController = LogInViewController()
        loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter | PFLogInFields.DismissButton
        
        self.navigationController?.pushViewController(loginViewController, animated: true)
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
