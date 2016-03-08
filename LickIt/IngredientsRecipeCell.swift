//
//  IngredientsRecipeCell.swift
//  LickIt
//
//  Created by MBP on 08/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

//protocol IngredientsRecipeCellDelegate{
//    func showPopup(name: String, sourceViewRekt: CGRect, width: CGFloat, height: CGFloat)
//    func hidePopup()
//}

class IngredientsRecipeCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var ingredients = [Ingredient]()
    @IBOutlet weak var collectionView: UICollectionView!
    var name: String!
    var delegate :OneIngredientRecipeCellDelegate!

    

    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(100 + ingredients.count)
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
                let imagine = UIImage(data: data!)
                let destinationSize = cell.image.frame.size
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell.image.image = nouaImagine

                
                cell.name = self!.ingredients[indexPath.item].name
                
            }
        }
        cell.delegate = self.delegate
        
//        var longTapRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongTap:")
//        longTapRecognizer.minimumPressDuration = 0.5
//        longTapRecognizer.indexCellProperty = indexPath
//        self.addGestureRecognizer(longTapRecognizer)
        
        
        return cell
    }

//    func didLongTap(gestureRecognizer: UILongPressGestureRecognizer){
//        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
//            //Do Whatever You want on End of Gesture
//            print("LONG TAP RECOGNIZED")
//            //     self.dismissViewControllerAnimated(false, completion: { () -> Void in
//            self.delegate.hidePopup()
//            //     })
//        }
//        else if (gestureRecognizer.state == UIGestureRecognizerState.Began){
//            //Do Whatever You want on Began of Gesture
//            print("BEGeeeeeN")
//            var cell = collectionView.cellForItemAtIndexPath(gestureRecognizer.indexCellProperty) as! OneIngredientCollectionViewCell
//            print(gestureRecognizer.indexCellProperty)
//            delegate!.showPopup(cell.name!, sourceViewRekt: cell.frame, width: 100, height: 60)
//            print(cell.frame)
//            
//            
//        }
//        
//    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
        
}
