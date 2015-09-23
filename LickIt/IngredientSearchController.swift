//
//  IngredientSearchController.swift
//  LickIt
//
//  Created by MBP on 20/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class IngredientSearchController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPopoverPresentationControllerDelegate, ChooseIngredientSearchCellDelegate {

    
    
    
    @IBOutlet weak var selectedCV: SelectedColView!
    @IBOutlet weak var chooseCV: ChooseColView!
    var selectedIngr = [Ingredient]()
    var chooseIngr = [Ingredient]()
    var foundRecipes = [Recipe]()
    var arrivedRecipesCheck = Int()
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        touches
//    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        touches
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        if( self.selectedIngr.count == self.arrivedRecipesCheck){
            
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("IngredientSearchResultController") as! IngredientSearchResultController
    //    viewController.ingredients = selectedIngr
        viewController.foundRecipes = self.foundRecipes
        
        
        self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var recipeManager = RecipeManager()
        recipeManager.getAllIngredients { (ingredients) -> Void in
            self.chooseIngr = ingredients
            self.chooseCV.reloadData()
        }

        var searchButton = UIButton(frame: CGRect(x: 280, y: 0, width: 40, height: 40))
        var buttonImage = UIImage(named: "MenuButton")
        searchButton.setImage(buttonImage, forState: UIControlState.Normal)
        
        searchButton.addTarget(self, action: "searchButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        var menuButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = menuButtonItem
        
        

        // Do any additional setup after loading the view.
    }
   
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.selectedCV.userInteractionEnabled = true
        self.chooseCV.userInteractionEnabled = true;
        // Dispose of any resources that can be recreated.
    }
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let a = collectionView as? SelectedColView{
            return selectedIngr.count
        }
        else{
            return chooseIngr.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let a = collectionView as? SelectedColView{
            var cell = selectedCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchSelected", forIndexPath: indexPath) as! SelectedIngredientSearchCell
            
            selectedIngr[indexPath.item].image?.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData!)
                    
                    cell.image.image = img!
                    cell.name = self.selectedIngr[indexPath.item].name
                }
            }
    
            return cell
        }
        else{
            var cell = chooseCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchChoose", forIndexPath: indexPath) as! ChooseIngredientSearchCell
            chooseIngr[indexPath.item].image?.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData!)
                    
                    cell.image.image = img!
                    cell.name = self.chooseIngr[indexPath.item].name
                }
                
                }
            //add long tap recognizer
            return cell
            }
        }
    
//    func didLongTap(gestureRecognizer: UILongPressGestureRecognizer){
//        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
//            //Do Whatever You want on End of Gesture
//            println("LONG TAP RECOGNIZED")
//            self.dismissViewControllerAnimated(false, completion: { () -> Void in
//                
//            })
//        }
//        else if (gestureRecognizer.state == UIGestureRecognizerState.Began){
//            //Do Whatever You want on Began of Gesture
//            println("BEGAAAN")
//            let storyboard : UIStoryboard = UIStoryboard(
//                name: "Main",
//                bundle: nil)
//            var menuViewController: PopupViewController = storyboard.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
//            menuViewController.modalPresentationStyle = .Popover
//            menuViewController.preferredContentSize = CGSizeMake(100, 60)
//           // menuViewController.name.text = self.chooseIngr[indexPath.item].name
//           
//            let popoverMenuViewController = menuViewController.popoverPresentationController
//            popoverMenuViewController?.permittedArrowDirections = .Any
//            popoverMenuViewController?.delegate = self
//            popoverMenuViewController?.sourceView = gestureRecognizer.view
//            popoverMenuViewController?.sourceRect = CGRect(
//                x: gestureRecognizer.locationInView(gestureRecognizer.view).x,
//                y: gestureRecognizer.locationInView(gestureRecognizer.view).y,
//                width: 1,
//                height: 1)
//            presentViewController(
//                menuViewController,
//                animated: true,
//                completion: nil)
//        }
//        
//    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    func showPopup(menuViewController: PopupViewController){
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        
        println(menuViewController.name?.text)
        
                    presentViewController(
                        menuViewController,
                        animated: true,
                        completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let a = collectionView as? ChooseColView{
            if(!(contains(selectedIngr, chooseIngr[indexPath.item]))){
            selectedIngr.append(chooseIngr[indexPath.item])
                selectedCV.reloadData()
                self.selectedCV.scrollToItemAtIndexPath(NSIndexPath(forItem: selectedIngr.count-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
            //cauta retete
                var recipeManager = RecipeManager()
                recipeManager.getRecipesForIngredients(self.selectedIngr, completionBlock: { (recipes) -> Void in
                    self.foundRecipes = recipes
                    self.arrivedRecipesCheck = self.selectedIngr.count
                })

            }
        }
        else{
            self.selectedIngr.removeAtIndex(indexPath.item)
            selectedCV.reloadData()
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

}
