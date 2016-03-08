//
//  ChooseIngredientSearchCell.swift
//  LickIt
//
//  Created by MBP on 20/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol ChooseIngredientSearchCellDelegate {
    func showPopup(name: String, cell: UIView)
    func hidePopup()
    func selectCell(cell: ChooseIngredientSearchCell)
}

class ChooseIngredientSearchCell: UICollectionViewCell, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    var name: String!
    var delegate : ChooseIngredientSearchCellDelegate!
    var selectedOrNot: Bool = false
    var viu: UIImageView?
    var visualEffect: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongTap:")
        _ = UILongPressGestureRecognizer()
        longTapRecognizer.minimumPressDuration = 0.5
        
        self.addGestureRecognizer(longTapRecognizer)
        
        }
    
    func tapped(){
        self.delegate.selectCell(self)
        
//        var array = [String]()
//        array.append(self.name)
//        let segmentedControl = UISegmentedControl(items: array)
//        segmentedControl.sizeToFit()
//        segmentedControl.center = self.contentView.center
//        let visualBlur = UIBlurEffect(style: .Light)
//        var visualEffectView = UIVisualEffectView(effect: visualBlur) as UIVisualEffectView
//        self.addSubview(visualEffectView)
//        var vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: visualBlur))
//        vibrancy.frame = self.frame
//        
//        vibrancy.contentView.addSubview(segmentedControl)
//        
//        self.addSubview(vibrancy)
//        visualEffectView.contentView.addSubview(vibrancy)
//        self.visualEffect = visualEffectView
//
//        
//        self.visualEffect.hidden = false
//        self.reloadInputViews()
//        if !self.selectedOrNot{
//            var img = UIView(frame: self.frame)
//            img.backgroundColor = UIColor.greenColor()//(red: 100, green: 100, blue: 100, alpha: 0.7)
//            println(img.backgroundColor)
//            self.viu = img
//            self.addSubview(img)
//            self.selectedOrNot = true
//        }
//        else{
//            self.viu?.removeFromSuperview()
//            self.selectedOrNot = false
//        }
    }

    
    func didLongTap(gestureRecognizer: UILongPressGestureRecognizer){
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            //Do Whatever You want on End of Gesture
            print("LONG TAP RECOGNIZED")
       //     self.dismissViewControllerAnimated(false, completion: { () -> Void in
                self.delegate.hidePopup()
       //     })
        }
        else if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            //Do Whatever You want on Began of Gesture
            print("BEGeeeeeN")
            
            delegate!.showPopup(self.name, cell: self)
            print(self.name)
        
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }

}
