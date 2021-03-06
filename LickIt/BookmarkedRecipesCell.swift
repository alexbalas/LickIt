//
//  BookmarkedRecipesCell.swift
//  LickIt
//
//  Created by MBP on 31/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol BookmarkedRecipeCellDelegate{
    func bookmarkedRecipeCellDidLongTap(cell: BookmarkedRecipesCell)
}


class BookmarkedRecipesCell: UICollectionViewCell{
    
    var delegate: BookmarkedRecipeCellDelegate?
    
    @IBOutlet weak var image: UIImageView!
    var name = String()
    var efect = 0
    var visualEffectView : UIVisualEffectView!
    var numeReteta : UILabel!
    
    override func awakeFromNib() {
        let up = UISwipeGestureRecognizer(target: self, action: "showName")
        up.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target: self, action: "hideName")
        down.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(down)
        
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = self.image.bounds
        visualEffectView.hidden = true
        
        self.addSubview(visualEffectView)
        
        numeReteta = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: (self.frame.height)*3/2))
        
        numeReteta.font = UIFont(name: "CourierNewPS-ItalicMT", size: 18)
        numeReteta.hidden = true
        self.addSubview(numeReteta)
        
        
        let longTap = UILongPressGestureRecognizer(target: self, action: "showImage")
        self.addGestureRecognizer(longTap)
    }
    
    func showImage(){
        self.delegate?.bookmarkedRecipeCellDidLongTap(self)
    }
    
    func showName(){
        numeReteta.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: (self.frame.height)*3/2)
        numeReteta.text = self.name
        self.visualEffectView.hidden = false
        self.numeReteta.hidden = false
    }
    func hideName(){
        self.numeReteta.hidden = true
        self.visualEffectView.hidden = true
    }
}
    