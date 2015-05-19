//
//  IngredientsRecipeCell.swift
//  LickIt
//
//  Created by MBP on 08/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class IngredientsRecipeCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var ingredients = [Ingredient]()
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(100 + ingredients.count)
        return ingredients.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell : OneIngredientCollectionViewCell
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("OneIngredientRecipeCell", forIndexPath: indexPath) as OneIngredientCollectionViewCell
        
        ingredients[indexPath.item].image?.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if !(error != nil) {
                var img = UIImage(data:imageData)
                
                cell.image.image = img
                
            }
        }
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.item)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
        
}
