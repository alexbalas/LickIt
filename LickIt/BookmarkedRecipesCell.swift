//
//  BookmarkedRecipesCell.swift
//  LickIt
//
//  Created by MBP on 31/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit


class BookmarkedRecipesCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    var name = String()
    var efect = 0
    
    override func awakeFromNib() {
        var up = UISwipeGestureRecognizer(target: self, action: "showName")
        up.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(up)
        
        var down = UISwipeGestureRecognizer(target: self, action: "hideName")
        down.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(down)
        
    }


    func showName(){
        if(self.efect==0){
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = self.image.bounds
        visualEffectView.alpha = 0.85

        self.addSubview(visualEffectView)
        
            
        var numeReteta = UILabel()
        numeReteta.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: (self.frame.height)*3/2)
        numeReteta.text = self.name
        numeReteta.font = UIFont(name: "CourierNewPS-ItalicMT", size: 18)
        self.addSubview(numeReteta)
            
            
        self.efect++
        }
    }
    func hideName(){
        if(self.efect==1)
        {
            var i = 0
            var subViews = self.subviews
            
            self.subviews.last?.removeFromSuperview()
            self.subviews.last?.removeFromSuperview()
            self.efect--
           
    }
}
    
}
