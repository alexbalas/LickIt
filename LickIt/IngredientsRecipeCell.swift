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
                //aici se intampla sfanta transormare din imagine in thumbnail
                var imagine = UIImage(data: data!)
                var destinationSize = cell.image.frame.size
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell.image.image = nouaImagine

                
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
