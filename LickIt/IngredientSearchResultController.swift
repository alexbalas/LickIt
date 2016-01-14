//
//  IngredientSearchResultController.swift
//  LickIt
//
//  Created by MBP on 11/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit


class IngredientSearchResultController: UICollectionViewController {

    
    
    let reuseIdentifier = "IngrSearchResultCell"
    var foundRecipes = [Recipe]()
    var ingredients : [Ingredient]!
    //var recipes = [Recipe]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "backButtonPressed:")
        self.title = "Results"
        self.collectionView?.backgroundColor = UIColor(patternImage: (UIImage(named: "clouds2"))!)
//        var recipeManager = RecipeManager()
//        recipeManager.getRecipesForIngredients(ingredients, completionBlock: { (recipes) -> Void in
//            self.foundRecipes = recipes
//            self.collectionView?.reloadData()
//            println(recipes)
//        })
        
    }
    
    func backButtonPressed(){
        self.navigationController?.popViewControllerAnimated(true)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }

    override func viewWillAppear(animated: Bool) {
        
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.foundRecipes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> IngredientSearchResultCell {
       // var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as IngredientSearchResultCell
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("IngrSearchResultCell", forIndexPath: indexPath) as! IngredientSearchResultCell
        
        foundRecipes[indexPath.item].image?.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                //aici se intampla sfanta transormare din imagine in thumbnail
                var imagine = UIImage(data: imageData!)
                var destinationSize = cell.image.frame.size
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell.image.image = nouaImagine

            }
        }
        
        var recipe = foundRecipes[indexPath.item]
        
        
        
 //       cell.licks.text = "\(self.foundRecipes[indexPath.item].numberOfLicks)"
        cell.licks.text = "\(self.foundRecipes[indexPath.item].numberOfLicks!)"
        
        cell.licks.font = UIFont(name: "AmericanTypewriter", size: 14)
        cell.name.text = recipe.name
        cell.name.font = UIFont(name: "Zapfino", size: 18)
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
        viewController.recipe = foundRecipes[indexPath.item]
        self.navigationController?.pushViewController(viewController, animated: true)

    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
