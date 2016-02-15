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
        
//        image.getDataInBackgroundWithBlock { [weak self]
//            (data: NSData?, error: NSError?) -> Void in
//            if !(error != nil) {
//                //                var img = UIImage(data:imageData!)
//                //
//                //aici se intampla sfanta transormare din imagine in thumbnail
//                var imagine = UIImage(data: data!)
//                var destinationSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height/7)
//                UIGraphicsBeginImageContext(destinationSize)
//                image.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
//                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                self.image = nouaImagine
//                println("sizeul eeee")
//                println(self.image.size)
//
//                
//                cell.name = self!.ingredients[indexPath.item].name
//                
//            }
//        }
        
        

        self.image = image
        self.selectionBlock = selectionBlock
    }
}
