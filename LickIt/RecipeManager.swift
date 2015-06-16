//
//  RecipeManager.swift
//  LickIt
//
//  Created by MBP on 09/04/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreData

class RecipeManager: NSObject {
    func getRecommendedRecipes(numberOfRecipes : Int, completionBlock: ([Recipe]) -> Void){
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
    
    func getTopRecipes(numberOfRecipes : Int, completionBlock: ([Recipe]) -> Void){
        var query = PFQuery(className: "Recipe")
        query.limit = numberOfRecipes
        query.orderByDescending("numberOfLicks")
        
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
//        var query = PFQuery(className: "Recipe")
//        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error) -> Void in
//          var recipes = [Recipe]()
//            if((error) == nil){
//            for object in objects {
//                var lickerRelation: PFRelation = (object as PFObject).relationForKey("lickers") as PFRelation
//                var recipe = Recipe(object: object as PFObject)
//                
//                recipe.numberOfLicks = lickerRelation.query().countObjects()
//                
//                var recipeModel = recipe.toManagedObject()
//         //       CoreDataManager.sharedInstance.saveObject(recipeModel)
//                
//                recipes.append(recipe)
//                }}
//                CoreDataManager.sharedInstance.managedObjectContext.save(nil)
//                completionBlock(recipes)
//            })

        var fetchRequest = NSFetchRequest(entityName: "RecipeModel")
        var recipesFromCoreData = CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as [RecipeModel]
        var recipes = [Recipe]()
        for recipe in recipesFromCoreData{
            var reteta = Recipe(recipeModel: recipe)
            recipes.append(reteta)
        }
        completionBlock(recipes)
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

    func getRecipesForIngredients (ingredients: [Ingredient], completionBlock: ([Recipe]) -> Void){
        var query = PFQuery(className: "Recipe")
        query.whereKey("ingredients", containedIn: ingredients.map({ return $0.parseObject!}))
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var recipes = [Recipe]()
            if((error) == nil){
                for object in objects {
                    var recipe = Recipe(object: object as PFObject)
                    recipes.append(recipe)
                }}
            completionBlock(recipes)

        }
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
    
    func lickRecipe (recipe: Recipe, user: PFUser, completionBlock:(success: Bool) -> Void){
        
        var lickers = recipe.parseObject?.relationForKey("lickers")
        lickers?.addObject(user)
        recipe.parseObject?.saveInBackgroundWithBlock({ (successfullyGotObjectInParse, error) -> Void in
            
            completionBlock(success: successfullyGotObjectInParse)
        })
        
    }
    
    func addRecipeToParse (recipe: Recipe, completionBlock:(success: Bool) -> Void){
        var parseRecipe = PFObject(className: "Recipe")
        parseRecipe = recipe.toPFObject()
        
        parseRecipe.saveInBackgroundWithBlock { (successfullyGotObjectInParse, error) -> Void in
        completionBlock(success: successfullyGotObjectInParse)
        }
        
        
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
