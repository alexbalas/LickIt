//
//  MenuItem.swift
//  LickIt
//
//  Created by MBP on 20/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    var image : UIImage
    var selectionBlock: () -> (Void)
    
    init (image: UIImage, selectionBlock: ()->(Void)){
        self.image = image
        self.selectionBlock = selectionBlock
    }
}
