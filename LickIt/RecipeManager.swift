//
//  RecipeManager.swift
//  LickIt
//
//  Created by MBP on 09/04/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class RecipeManager: NSObject {
    func getTopRecipes(numberOfRecipes : Int, completionBlock: ([Recipe]) -> Void){
        var predicat = NSPredicate(format: "%K <= %d", "rank", numberOfRecipes)
        var query = PFQuery(className: "Recipe", predicate: predicat)
        query.orderByAscending("rank")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var recipes = [Recipe]()
            for object in objects{
                var recipe = Recipe(object: object as PFObject)
                recipes.append(recipe)
            }
            completionBlock(recipes)
        }
    }
    
    func getAllRecipes(completionBlock: ([Recipe]) -> Void){
        var query = PFQuery(className: "Recipe")
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error) -> Void in
          var recipes = [Recipe]()
            for object in objects {
                var recipe = Recipe(object: object as PFObject)
                recipes.append(recipe)
                }
                completionBlock(recipes)
            //}
        })
    }
    

}
