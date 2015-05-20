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
            if(objects != nil){
            for object in objects{
                var recipe = Recipe(object: object as PFObject)
                recipes.append(recipe)
                }}
            completionBlock(recipes)
        }
    }
    
    func getSearchedRecipes(magicWord : String, completionBlock: ([Recipe])-> Void){
        
        println(magicWord)
        var predicat = NSPredicate(format: "%K CONTAINS %@", "name", magicWord)
        
        var query = PFQuery(className: "Recipe", predicate: predicat)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if !(error != nil){
            var searchedRecipes = [Recipe]()
            if(objects != nil){
                for object in objects{
                    var recipe = Recipe(object: object as PFObject)
                    searchedRecipes.append(object as Recipe)
                }
            }
            completionBlock(searchedRecipes)

        }
        }
    }
    
    func getAllRecipes(completionBlock: ([Recipe]) -> Void){
        var query = PFQuery(className: "Recipe")
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error) -> Void in
          var recipes = [Recipe]()
            if((error) == nil){
            for object in objects {
                var recipe = Recipe(object: object as PFObject)
                recipes.append(recipe)
                }}
                completionBlock(recipes)
            //}
            })
                }
    
    func getAllIngredients(completionBlock: ([Ingredient]) -> Void){
        var query = PFQuery(className: "Ingredient")
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error) -> Void in
            var ingredients = [Ingredient]()
            if((error) == nil){
                for object in objects {
                    var ingredient = Ingredient(object: object as PFObject)
                    ingredients.append(ingredient)
                }}
            completionBlock(ingredients)
        
        })
    }

    
    
func getIngredientsForRecipe (recipe: Recipe, completionBlock:([Ingredient]) -> Void){
    recipe.ingredientsRelation?.query().findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
        var ingredients = [Ingredient]()
        for object in objects{
            var ingredient = Ingredient(object: object as PFObject)
            ingredients.append(ingredient)
        }
        completionBlock(ingredients)
    })

    }
    
    func getUsers (user: [User], completionBlock:([User]) -> Void){
        var query = PFQuery(className: "User")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var users = [User]()
            if error == nil{
            for object in objects{
                var user = User(object: object as PFObject)
                users.append(user)
                }}
            completionBlock(users)
        }
    }
}
