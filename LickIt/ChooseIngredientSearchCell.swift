//
//  ChooseIngredientSearchCell.swift
//  LickIt
//
//  Created by MBP on 20/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol ChooseIngredientSearchCellDelegate {
    func showPopup(controller: PopupViewController)
}

class ChooseIngredientSearchCell: UICollectionViewCell, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    var name: String!
    var delegate : ChooseIngredientSearchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var longTapRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongTap:")
        var sdds = UILongPressGestureRecognizer()
        longTapRecognizer.minimumPressDuration = 0.75
        
        self.addGestureRecognizer(longTapRecognizer)

    }
    
    func didLongTap(gestureRecognizer: UILongPressGestureRecognizer){
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            //Do Whatever You want on End of Gesture
            println("LONG TAP RECOGNIZED")
       //     self.dismissViewControllerAnimated(false, completion: { () -> Void in
                
       //     })
        }
        else if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            //Do Whatever You want on Began of Gesture
            println("BEGAAAN")
            let storyboard : UIStoryboard = UIStoryboard(
                name: "Main",
                bundle: nil)
            var menuViewController: PopupViewController = storyboard.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
            menuViewController.modalPresentationStyle = .Popover
            menuViewController.preferredContentSize = CGSizeMake(100, 60)
            menuViewController.name?.text = self.name
            
            delegate!.showPopup(menuViewController)
            println(self.name)
//            let popoverMenuViewController = menuViewController.popoverPresentationController
//            popoverMenuViewController?.permittedArrowDirections = .Any
//            popoverMenuViewController?.delegate = self
//            popoverMenuViewController?.sourceView = gestureRecognizer.view
//            popoverMenuViewController?.sourceRect = CGRect(
//                x: gestureRecognizer.locationInView(gestureRecognizer.view).x,
//                y: gestureRecognizer.locationInView(gestureRecognizer.view).y,
//                width: 1,
//                height: 1)
            
        
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }

}
