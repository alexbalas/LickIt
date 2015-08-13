//
//  User.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

enum Gender: Int{
    case Male
    case Female
}

class User: NSObject {
    var name : String?
    var age : Int?
    var gender : Gender?
    var image : UIImage?
    var username : String?
    var password : String?
    var savedRecipes : [Recipe]?
    var myRecipes : [Recipe]?
}

extension User{
    func toPFObject() -> PFObject{
        var object = PFObject(className: "User")
        if let name = self.name{
            object["name"] = name
        }
        if let age = self.age{
            object["age"] = age
        }
        if let gender = self.gender{
            object["gender"] = gender.rawValue
        }

        if let image = self.image{
            object["image"] = image
        }
        if let username = self.username{
            object["username"] = username
        }
        if let password = self.password{
            object["password"] = password
        }
        if let savedRecipes = self.savedRecipes{
            object["savedRecipes"] = savedRecipes
        }
        if let myRecipe = self.myRecipes{
            object["myRecipe"] = myRecipe
        }
    return object
    }
    
    convenience init(object: PFObject) {
        self.init()
        self.name = object["name"] as? String
        self.age = object["age"] as? Int
        self.gender = Gender(rawValue: object["gender"] as! Int)
        self.image = object["image"] as? UIImage
        self.username = object["username"] as? String
        self.password = object["password"] as? String
        self.savedRecipes = object["savedRecipes"] as? [Recipe]
        self.myRecipes = object["savedRecipes"] as? [Recipe]
    }
}