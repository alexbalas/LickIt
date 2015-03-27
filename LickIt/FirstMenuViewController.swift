//
//  FirstMenuViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit


class FirstMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var recipes: [Recipe] = [Recipe]()
    var numberOfControllerToShow = -1
    
    
    @IBOutlet weak var whatCanICookImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var recipeOne = Recipe()
        recipeOne.name = "Prima Reteta"
        recipeOne.numberOfLicks = 22
        recipeOne.image = UIImage(named: "1")
        recipeOne.time = 23
        recipeOne.recipeDescription = "lot of work"
        
        var recipeTwo : Recipe = Recipe()
        recipeTwo.name = "A doua reteta"
        recipeTwo.numberOfLicks = 44
        recipeTwo.image = UIImage(named: "2")
        recipeTwo.time = 55
        recipeTwo.recipeDescription = "just cook it"
        
        
        var anotherRecipe : Recipe = Recipe()
        anotherRecipe.numberOfLicks = 33
        anotherRecipe.name = "A treia reteta"
        anotherRecipe.image = UIImage(named: "3")
        anotherRecipe.time = 11
        anotherRecipe.recipeDescription = "nothing"
                
        recipes.append(recipeOne)
        recipes.append(recipeTwo)
        recipes.append(anotherRecipe)

        
                
        var gesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "imageViewTapped")
        self.whatCanICookImage.addGestureRecognizer(gesture)
        
             // Do any additional setup after loading the view.
    }
    
    func imageViewTapped() {
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("BookmarkedRecipes") as BookmarkedRecipeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : WeRecommandCell = collectionView.dequeueReusableCellWithReuseIdentifier("WeRecommandCell", forIndexPath: indexPath) as WeRecommandCell
        var recipe = recipes[indexPath.item]
        cell.licks.text = "\(recipe.numberOfLicks!)"
        cell.name.text = recipe.name
        cell.image.image = recipe.image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as RecipeViewController
        
       viewController.recipe = recipes[indexPath.item]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
