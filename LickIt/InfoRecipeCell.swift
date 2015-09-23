//
//  InfoRecipeCell.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreData

protocol InfoRecipeCellDelegate {
    func infoRecipeCellSaveButtonPressed()
    func loginControllerShouldAppear()
}

class InfoRecipeCell: UITableViewCell {

    var recipe = Recipe()
    var lickedOrNot: Bool!
    
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var licks: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var lickButton: UIButton!
    
    var delegate : InfoRecipeCellDelegate?
    
    @IBAction func lickButtonPressed(sender: AnyObject) {
        
        if(PFUser.currentUser() == nil){
            self.lickButton.setTitle("Login first!", forState: UIControlState.Normal)
            delegate?.loginControllerShouldAppear()
        }
        else{
        println("lick")
        var recipeManager = RecipeManager()
        recipeManager.lickRecipe(self.recipe, user: PFUser.currentUser()!) { (success) -> Void in
        if(success){
            println("Liked")
            var nrOfLicks = self.licks.text!.toInt()! + 1
            self.licks.text = "\(nrOfLicks)"
            self.lickButton.titleLabel?.text = "Licked :P"
            }
        }
    
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        println("step 1")
        self.recipe.parseObject = self.recipe.toPFObject()
        // Initialization code
        //check if licked or not
        if PFUser.currentUser() != nil{
            println("step 2")
            var manager = RecipeManager()
            manager.didLikeRecipe(self.recipe,user: PFUser.currentUser()!, completionBlock: { (usser) -> Void in
                println("step 3")
                var uzer = usser as PFUser!
                if uzer != nil {
                    self.lickButton.setTitle("Licked :P", forState: UIControlState.Normal)
                }
                else{
                    self.lickButton.setTitle("Give it a lick!", forState: UIControlState.Normal)
                }
            self.reloadInputViews()
            self.contentView.reloadInputViews()
            println("Ar trebui sa se schimbe")
            })
        }
        else{
            self.lickButton.setTitle("Log on to lick", forState: UIControlState.Normal)
        }
    
        
        
        
        var query = PFQuery(className: "Recipe").fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            for object in objects!{
                if( self.recipe.parseObject == object as? PFObject){
                    self.saveButton.setTitle("got it", forState: UIControlState.Normal)
                }
            }
            if(self.saveButton.titleLabel?.text != "got it"){
                self.saveButton.setTitle("Save", forState: UIControlState.Normal)
            }
        }
        self.lickButton.addTarget(self, action: "lickButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }


    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func saveButtonPressed(sender: UIButton) {
        self.saveButton.setTitle("got it", forState: UIControlState.Normal)
        delegate?.infoRecipeCellSaveButtonPressed()
        println("save button pressed")
        
        

        
//        var coreManager = CoreDataManager()
//        var reteta = RecipeModel()
//        reteta.time = self.recipe.time
//        reteta.name = self.recipe.name!
//        
//        coreManager.saveObject(reteta)
//        
    }
}
