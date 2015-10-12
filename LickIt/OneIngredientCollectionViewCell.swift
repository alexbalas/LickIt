//
//  OneIngredientCollectionViewCell.swift
//  LickIt
//
//  Created by MBP on 08/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol OneIngredientRecipeCellDelegate {
    func showPopup(name: String, cell: UIView)
    func hidePopup()
}

class OneIngredientCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    var name: String?
    var delegate : OneIngredientRecipeCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        var longTapRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongTap:")
        var sdds = UILongPressGestureRecognizer()
        longTapRecognizer.minimumPressDuration = 0.5
        self.addGestureRecognizer(longTapRecognizer)
    }
    
    
    func didLongTap(gestureRecognizer: UILongPressGestureRecognizer){
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            //Do Whatever You want on End of Gesture
            println("LONG TAP RECOGNIZED")
            //     self.dismissViewControllerAnimated(false, completion: { () -> Void in
            self.delegate.hidePopup()
            //     })
        }
        else if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            //Do Whatever You want on Began of Gesture
            println("BEGeeeeeN")
            
            delegate!.showPopup(self.name!, cell: self)
            
            
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
}
