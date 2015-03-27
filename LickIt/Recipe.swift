//
//  Recipe.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class Recipe: NSObject, NSCoding {
    
    var ID : String
    var name : String?
    var numberOfLicks : Int?
    var ingredients : [Ingredient]?
    var time : Int!
    var categories : [RecipeCategory]?
    var image : UIImage?
    var recipeDescription : String?
    var comments : [Comment]?
    
    init (ID : String){
        self.ID = ID
    }
    
    required init(coder aDecoder: NSCoder) {
        self.ID = aDecoder.decodeObjectForKey("ID") as String
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.numberOfLicks = Int(aDecoder.decodeIntForKey("numberOfLicks"))
        self.time = Int(aDecoder.decodeIntForKey("time"))
        self.image = UIImage(data: aDecoder.decodeObjectForKey("image") as NSData)
        self.recipeDescription = aDecoder.decodeObjectForKey("recipeDescription") as? String
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.ID, forKey: "ID")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeInteger(self.numberOfLicks!, forKey: "numberOfLicks")
        aCoder.encodeInteger(self.time, forKey: "time")
        aCoder.encodeObject(UIImagePNGRepresentation(self.image), forKey: "image")
        aCoder.encodeObject(self.recipeDescription, forKey: "recipeDescription")
        
    }
    
   
}
