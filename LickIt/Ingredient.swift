//
//  Ingredient.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class Ingredient: NSObject {
    var name : String?
    var image : UIImage?
    
}
extension Ingredient{
    func toPFObject() -> PFObject{
        
        var object = PFObject(className: "Ingredient")
        if let name = self.name{
            object["name"] = name
        }
        if let image = self.image{
            object["image"] = image
        }
        return object
}
}