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
        let predicat = NSPredicate(format: "%K <= %d", "rank", numberOfRecipes)
        let query = PFQuery(className: "Recipe", predicate: predicat)
        query.orderByAscending("rank")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var recipes = [Recipe]()
            if(objects != nil){
                for object in objects! {
                    let recipe = Recipe(object: object as! PFObject)
                    print(recipe.image)
                    recipes.append(recipe)
                }
            }
            completionBlock(recipes)
        }
    }
    
    func getTopRecipes(numberOfRecipes : Int, completionBlock: ([Recipe]) -> Void){
        let query = PFQuery(className: "Recipe")
        query.limit = numberOfRecipes
        query.orderByDescending("numberOfLicks")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var recipes = [Recipe]()
            if(objects != nil){
                for object in objects!{
                    let recipe = Recipe(object: object as! PFObject)
                    recipes.append(recipe)
                }}
            completionBlock(recipes)
        }
    }
    
    func didLikeRecipe(recipe: Recipe,user: PFUser, completionBlock:(Int32) -> Void){
        print("step 2.5")
        let lickers = recipe.parseObject?.relationForKey("lickers") as PFRelation?
        let relationQuery = lickers!.query()!.whereKey("objectId", equalTo: user.objectId!)
        print("2.555")
//        relationQuery.countObjectsInBackgroundWithBlock { (countt: Int?, error: NSError) -> Void in
//            completionBlock(countt)
//        }
        relationQuery.countObjectsInBackgroundWithBlock { (countt, error) -> Void in
            completionBlock(countt)
        }
//        relationQuery.countObjectsInBackgroundWithBlock { (caunt, eroare) -> Void in
//            
//        }
        
        //cred ca fct urmat era de la Marius
        
//        relationQuery.findObjectsInBackgroundWithBlock { (result, error) -> Void in
//    //        var _ = completionBlock(result!.count)
//        }
//        relationQuery.getObjectInBackgroundWithId(user.objectId!) { (object, error) -> Void in
//            println("step 2.6")
//            if (object!.objectId == PFUser.currentUser()?.objectId) {
//                //usser = object as! PFUser
//                completionBlock(1)
//            }
//            else{
//                completionBlock(0)
//            }
//            
//            println("step 2.7")
//            
//          //  completionBlock(usser)
//            
//        }
    }
    
    func isRecipeSaved(recipeName: String, completionBlock:(Bool) -> Void){
        let query = PFQuery(className: "Recipe").whereKey("name", equalTo: recipeName)
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if objects?.count > 0 {
                completionBlock(true)
            }
            else{
                completionBlock(false)
            }
        }
        
    }
    
    func getSearchedRecipes(magicWord : String, completionBlock: ([Recipe])-> Void){
        
        let qry = PFQuery(className: "Recipe")
        qry.whereKey("name", matchesRegex: magicWord, modifiers: "i")        
        qry.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if !(error != nil){
                var searchedRecipes = [Recipe]()
                if let objs = objects {
                    for object in objs{
                        let recipe = Recipe(object: object as! PFObject)
                        searchedRecipes.append(recipe as Recipe)
                    }
                }
                completionBlock(searchedRecipes)
                
            }
        }
    }
    
    func getAllRecipes(completionBlock: ([Recipe]) -> Void){
        let query = PFQuery(className: "Recipe")
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error) -> Void in
            var recipes = [Recipe]()
            if((error) == nil){
                if let objs = objects {
                    for object in objs {
                        let lickerRelation: PFRelation = (object as! PFObject).relationForKey("lickers") as PFRelation
                        let recipe = Recipe(object: object as! PFObject)
                        
                        recipe.numberOfLicks = lickerRelation.query()!.countObjects()
                        
                        _ = recipe.toManagedObject()
                        
                        recipes.append(recipe)
                    }}}
            do {
                try CoreDataManager.sharedInstance.managedObjectContext.save()
            } catch _ {
            }
            completionBlock(recipes)
        })
    }
    
    func getRecipesFromCore(completionBlock: ([Recipe]) -> Void){
        let fetchRequest = NSFetchRequest(entityName: "RecipeModel")
        let recipesFromCoreData = (try! CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest)) as! [RecipeModel]
        var recipes = [Recipe]()
        for recipe in recipesFromCoreData{
            let reteta = Recipe(recipeModel: recipe)
            recipes.append(reteta)
        }
        completionBlock(recipes)
    }
    
    func getAllIngredients(completionBlock: ([Ingredient]) -> Void){
        let query = PFQuery(className: "Ingredient")
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error) -> Void in
            var ingredients = [Ingredient]()
            if((error) == nil){
                if let objs = objects{
                    for object in objs {
                        let ingredient = Ingredient(object: object as! PFObject)
                        ingredients.append(ingredient)
                    }}}
            completionBlock(ingredients)
            
        })
    }
    
    func getNews(completionBlock: ([PFFile]) -> Void){
        let query = PFQuery(className: "News")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error) -> Void in
            var images = [PFFile]()
            if(error == nil){
                if let objs = objects{
                    for object in objs{
                        if let image = object["image"] as? PFFile{
                            images.append(image)
                        }
                    }
                }
            }
            completionBlock(images)
        }
    }
    
    func getRecipesForIngredients (ingredients: [Ingredient], blockedIngredients: [Ingredient], completionBlock: ([Recipe]) -> Void){
        let query = PFQuery(className: "Recipe")
        query.whereKey("ingredients", containedIn: ingredients.map({ return $0.parseObject!}))
        query.whereKey("ingredients", notContainedIn: blockedIngredients.map({ return $0.parseObject!}))
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var recipes = [Recipe]()
            if((error) == nil){
                if let objs = objects{
                    for object in objs {
                        let recipe = Recipe(object: object as! PFObject)
                        recipes.append(recipe)
                    }}}
            completionBlock(recipes)
            
        }
    }
    
    func getIngredientsForRecipe (recipe: Recipe, completionBlock:([Ingredient]) -> Void){
        recipe.ingredientsRelation?.query()!.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            var ingredients = [Ingredient]()
            if let objs = objects {
                for object in objs{
                    let ingredient = Ingredient(object: object as! PFObject)
                    ingredients.append(ingredient)
                }
            }
            completionBlock(ingredients)
        })
        
    }
    
    func lickRecipe (recipe: Recipe, user: PFUser, completionBlock:(success: Bool) -> Void){
        
        let lickers = recipe.parseObject?.relationForKey("lickers") as PFRelation?
        lickers?.addObject(user)
//        recipe.parseObject?.saveInBackgroundWithBlock({ (successfullyGotObjectInParse, error) -> Void in
//        
//            completionBlock(success: successfullyGotObjectInParse)
//        })
       // recipe.parseObject?.setObject(lickers!, forKey: "lickers")
        recipe.parseObject?.saveInBackground()
        
        completionBlock(success: true)
    }
    
    func addRecipeToParse (recipe: Recipe, completionBlock:(success: Bool) -> Void){
        var parseRecipe = PFObject(className: "Recipe")
        parseRecipe = recipe.toPFObject()
        
        parseRecipe.saveInBackgroundWithBlock { (successfullyGotObjectInParse, error) -> Void in
            completionBlock(success: successfullyGotObjectInParse)
        }
        
        
    }
    
    func getUsers (user: [User], completionBlock:([User]) -> Void){
        let query = PFQuery(className: "User")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            var users = [User]()
            if error == nil{
                if let objs = objects {
                    for object in objs{
                        let user = User(object: object as! PFObject)
                        users.append(user)
                    }}}
            completionBlock(users)
        }
    }
}
