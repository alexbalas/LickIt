//
//  MyNavigationBar.swift
//  LickIt
//
//  Created by MBP on 31/01/16.
//  Copyright (c) 2016 MBP. All rights reserved.
//

import UIKit

class MyNavigationBar: UINavigationBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var amendedSize = super.sizeThatFits(size)
        amendedSize.height += 16
        
        return amendedSize
    }
    
//    override func drawRect(rect: CGRect) {
//        
//    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
