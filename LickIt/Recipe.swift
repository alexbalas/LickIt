//
//  Recipe.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreData

class Recipe: NSObject, NSCoding {
    
    var htmlString : String?
    
    var ID : String?
    var name : String?
    var numberOfLicks : Int?
    var ingredients : [Ingredient]?
    var time : Int!
    var categories : [RecipeCategory]?
    var categorieString : String?
    var image : PFFile?
    var recipeDescription : String?
    var comments : [Comment]?
    var ingredientsRelation : PFRelation?
    var parseObject : PFObject? {
        didSet {
            println("changed")
        }
}
    
    //    init (ID : String){
    //        self.ID = ID
    //    }
    override init(){
    }
    
    required init(coder aDecoder: NSCoder) {
        self.ID = (aDecoder.decodeObjectForKey("ID") as? String)!
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.numberOfLicks = Int(aDecoder.decodeIntForKey("numberOfLicks"))
        self.time = Int(aDecoder.decodeIntForKey("time"))
        //        self.image = UIImage(contentsOfFile: "self.image") as UIImage!
        self.recipeDescription = aDecoder.decodeObjectForKey("recipeDescription") as? String
        self.parseObject = aDecoder.decodeObjectForKey("parseObject") as? PFObject
        
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.ID, forKey: "ID")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeInteger(self.numberOfLicks!, forKey: "numberOfLicks")
        aCoder.encodeInteger(self.time, forKey: "time")
        //        aCoder.encodeObject(UIImagePNGRepresentation(self.image), forKey: "image")
        aCoder.encodeObject(self.recipeDescription, forKey: "recipeDescription")
        aCoder.encodeObject(self.parseObject, forKey: "parseObject")
    }
    
    
}

extension Recipe{
    func toPFObject() -> PFObject{
        
        var object = PFObject(className: "Recipe")
        if let aidi = self.ID as String?{
            object["ID"] = aidi
        }
        if let name = self.name {
            object["name"] = name
        }
        if let numberOfLicks = self.numberOfLicks {
            object["numberOfLicks"] = numberOfLicks
        }
//               if let ingredients = self.ingredients{
//        object["ingredients"] = ingredients
//        }
        if let time = self.time{
            object["time"] = time
        }
        /*       if let categories = self.categories{
        object["categories"] = categories
        } */
        if let image = self.image{
        //   object["image"] = image
        }
        if let description = self.recipeDescription{
            object["recipeDescription"] = description
        }
        if let comms = self.comments{
            object["comments"] = comms
        }
        
        if let categs = self.categorieString{
            object["categories"] = categs
        }
        
        if let html = self.htmlString{
            object["htmlString"] = html
        }
        
        return object
    }
    
    convenience init(object: PFObject){
        //self.init(ID: object["ID"] as! String)
        self.init()
        if let aidi = object["ID"] as? String{
            self.ID = aidi
        }
        if let name = object["name"] as? String{
            self.name = name
        }
        if let nrLicks = object["numberOfLicks"] as? Int{
            self.numberOfLicks = nrLicks
        }
        /*        if let ingredients = object["ingredients"] as? [Ingredient]{
        self.ingredients = ingredients
        }  */
        if let time = object["time"] as? Int{
            self.time = time
        }
        /*        if let categories = object["categories"] as? [RecipeCategory]{
        self.categories = categories
        } */
        if let image = object["image"] as? PFFile{
            self.image = image
        }
        if let descr = object["recipeDescription"] as? String{
            self.recipeDescription = descr
        }
        if let comms = object["comments"] as? [Comment]{
            self.comments = comms
        }
        if let ingredientsRelation = object["ingredients"] as? PFRelation{
            self.ingredientsRelation = ingredientsRelation
            
        }
        if let categs = object["categories"] as? String{
            self.categorieString = categs
        }
        if let html = object["htmlString"] as? String{
            self.htmlString = html
        }
        self.parseObject = object
    }
}

extension Recipe{
    func toManagedObject() -> RecipeModel{
        var recipeModel = NSEntityDescription.insertNewObjectForEntityForName("RecipeModel", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext) as! RecipeModel
        if let name = self.name{
            recipeModel.name = name
        }
        if let time = self.time{
            recipeModel.time = time
        }
        //        if let ingredients = self.ingredients{
        //            for ingredient in ingredients{
        //                var ingredientModel = ingredient.toManagedObjects()
        //                recipeModel.addIngredient(ingredientModel)
        //            }
        //        }
        if let imagine = self.image{
            imagine.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData!)
                    recipeModel.image = img!
                }
            }
        }
        
        if let licks = self.numberOfLicks{
            recipeModel.nrOfLicks = licks
        }
        
        if let aidi = self.ID as String?{
            recipeModel.id = aidi
        }
        return recipeModel
    }
    
    convenience init(recipeModel: RecipeModel){
        //    self.init(ID: recipeModel.id)
        self.init()
        if let aidi = recipeModel.id as String!{
            self.ID = aidi
        }
        if let nume = recipeModel.name as String?{
            self.name = nume
        }
        if let timp = recipeModel.time as? Int{
            self.time = timp
        }
        if let imagine = recipeModel.image as UIImage?{
            //var pfImagine = PFFile(data: imagine) as PFFile?
            var data = UIImageJPEGRepresentation(imagine, 0.0)
            var pfImagine = PFFile(data: data)
            self.image = pfImagine
        }
        if let licks = recipeModel.nrOfLicks as? Int{
            self.numberOfLicks = licks
        }
    }
}







