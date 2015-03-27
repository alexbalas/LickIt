//
//  Recipe.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    
    var name : String?
    var numberOfLicks : Int?
    var ingredients : [Ingredient]?
    var time : Int!
    var categories : [RecipeCategory]?
    var image : UIImage?
    var recipeDescription : String?
    var comments : [Comment]?
   
}
