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
        self.image = UIImage(contentsOfFile: "self.image") as UIImage!
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

extension Recipe{
    func toPFObject() -> PFObject{
    
        var object = PFObject(className: "Recipe")
        object["ID"] = self.ID
        if let name = self.name {
            object["name"] = name
        }
        if let numberOfLicks = self.numberOfLicks {
            object["numberOfLicks"] = numberOfLicks
        }
        if let ingredients = self.ingredients{
            object["ingredients"] = ingredients
        }
        if let time = self.time{
            object["time"] = time
        }
        if let categories = self.categories{
            object["categories"] = categories
        }
        if let image = self.image{
            object["image"] = image
        }
        if let description = self.recipeDescription{
            object["recipeDescription"] = description
        }
        if let comms = self.comments{
            object["comments"] = comms
        }
        return object
    }
    
    convenience init(object: PFObject){
        self.init(ID: object["ID"] as String)
        if let name = object["name"] as? String{
            self.name = name
        }
        if let nrLicks = object["numberOfLicks"] as? Int{
            self.numberOfLicks = nrLicks+1
        }
        if let ingredients = object["ingredients"] as? [Ingredient]{
            self.ingredients = ingredients
        }
        if let time = object["time"] as? Int{
            self.time = time
        }
        if let categories = object["categories"] as? [RecipeCategory]{
            self.categories = categories
        }
        if let image = object["image"] as? UIImage{
            self.image = UIImage(contentsOfFile: <#String#>)
        }
        if let descr = object["recipeDescription"] as? String{
            self.recipeDescription = descr
        }
        if let comms = object["comments"] as? [Comment]{
            self.comments = comms
        }
        
        
    }
}