//
//  BookmarkedRecipesCollectionViewController.swift
//  LickIt
//
//  Created by MBP on 31/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class BookmarkedRecipesCollectionViewController: BaseCollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return recipes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

  //      var cell = collectionView.dequeueReusableCellWithIdentifier("BookmarkedRecipeCollectionCell", forIndexPath: indexPath) as BookmarkedRecipeCell
       
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookmarkedRecipeCollectionCell", forIndexPath: indexPath) as BookmarkedRecipesCell
        
 //       cell.image.image = recipes[indexPath.row].image
        cell.name = "Spaghetti"
        
  //      var up = UISwipeGestureRecognizer(target: self, action: "showName")
  //      cell.image.addGestureRecognizer(up)
        // Configure the cell
    
        return cell
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
