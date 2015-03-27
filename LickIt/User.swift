//
//  User.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

enum Gender{
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
