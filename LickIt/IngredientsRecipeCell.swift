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
    var name: String!
    var delegate : OneIngredientRecipeCellDelegate!

    

    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(100 + ingredients.count)
        return ingredients.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = OneIngredientCollectionViewCell()
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("OneIngredientRecipeCell", forIndexPath: indexPath) as! OneIngredientCollectionViewCell
        
        ingredients[indexPath.item].image?.getDataInBackgroundWithBlock { [weak self]
            (data: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
//                var img = UIImage(data:imageData!)
//                
                cell.image.image = UIImage(data:data!)
                cell.name = self!.ingredients[indexPath.item].name
                
            }
        }
        cell.delegate = self.delegate
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.item)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
        
}
