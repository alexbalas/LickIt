//
//  RecipeModel.swift
//  LickIt
//
//  Created by MBP on 16/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import Foundation
import CoreData

@objc(RecipeModel)
class RecipeModel: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var time: NSNumber
    @NSManaged var ingredients: NSSet
    @NSManaged var id: String
    @NSManaged var image: UIImage
    @NSManaged var nrOfLicks: NSNumber
    
    func addIngredient(ingredient: IngredientModel){
        var mutableIngredients = self.mutableSetValueForKey("ingredients")
        mutableIngredients.addObject(ingredient)
    }
    
    func removeIngredient(ingredient: IngredientModel){
        var mutableIngredients = self.mutableSetValueForKey("ingredients")
        mutableIngredients.removeObject(ingredient)
    }

}
