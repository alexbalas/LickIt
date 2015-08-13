//
//  Ingredient.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreData


class Ingredient: NSObject {
    var name : String?
    var image : PFFile?
    var parseObject : PFObject?
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
    convenience init(object: PFObject){
        self.init()
        if let name = object["name"] as? String{
            self.name = name
        }
        if let image = object["image"] as? PFFile{
            self.image = image
        }
        self.parseObject = object
    }
}

extension Ingredient{
    func toManagedObjects() -> IngredientModel{
        var managedObject = NSEntityDescription.insertNewObjectForEntityForName("IngredientModel", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext) as! IngredientModel
        if let name = self.name{
            managedObject.name = name
        }
        if let imagine = self.image{
            imagine.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData!)
                    managedObject.image = img!
                }
            }
            
        }
        return managedObject
    }
}