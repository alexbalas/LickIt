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
        
        var recipeData = NSUserDefaults.standardUserDefaults().objectForKey("recipes") as NSData
        self.recipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipeData) as [Recipe]
        
        recipes[0].image = UIImage(named: "cookingWith")
        
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
