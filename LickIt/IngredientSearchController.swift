//
//  IngredientSearchController.swift
//  LickIt
//
//  Created by MBP on 20/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class IngredientSearchController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var selectedCV: SelectedColView!
    @IBOutlet weak var chooseCV: ChooseColView!
    var selectedIngr = [Ingredient]()
    var chooseIngr = [Ingredient]()
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touches
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var recipeManager = RecipeManager()
        recipeManager.getAllIngredients { (ingredients) -> Void in
            self.chooseIngr = ingredients
            self.chooseCV.reloadData()
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.selectedCV.userInteractionEnabled = true
        self.chooseCV.userInteractionEnabled = true;
        // Dispose of any resources that can be recreated.
    }
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let a = collectionView as? SelectedColView{
            return selectedIngr.count
        }
        else{
            return chooseIngr.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let a = collectionView as? SelectedColView{
            var cell = selectedCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchSelected", forIndexPath: indexPath) as SelectedIngredientSearchCell
            
            selectedIngr[indexPath.item].image?.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData)
                    
                    cell.image.image = img!
                    cell.name = self.selectedIngr[indexPath.item].name
                }
            }
    
            return cell
        }
        else{
            var cell = chooseCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchChoose", forIndexPath: indexPath) as ChooseIngredientSearchCell
            chooseIngr[indexPath.item].image?.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData)
                    
                    cell.image.image = img!
                    cell.name = self.chooseIngr[indexPath.item].name
                }
                
                }
            return cell
            }
        }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let a = collectionView as? ChooseColView{
            if(!(contains(selectedIngr, chooseIngr[indexPath.item]))){
            selectedIngr.append(chooseIngr[indexPath.item])
                selectedCV.reloadData()
            }
        }
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
