//
//  RecipeCategory.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class RecipeCategory: NSObject {
    var name : String?
    var recipes : [Recipe]?
    
}

extension RecipeCategory{
    func toPFObject() -> PFObject{
        var object = PFObject(className: "RecipeCategory")
        
        if let name = self.name{
            object["name"] = name
        }
        if let recipes = self.recipes{
            object["recipes"] = recipes
        }
        return object
    }

}