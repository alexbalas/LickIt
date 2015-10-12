//
//  InfoRecipeCell.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreData

protocol InfoRecipeCellDelegate : NSObjectProtocol {
    func infoRecipeCellSaveButtonPressed()
    func loginControllerShouldAppear()
}

class InfoRecipeCell: UITableViewCell {
    
    private var recipe : Recipe!
    var lickedOrNot: Bool!
    var savedOrNot: Bool!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var licks: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var lickButton: UIButton!
    
    weak var delegate : InfoRecipeCellDelegate?
    
    @IBAction func lickButtonPressed(sender: AnyObject) {
        
        if(PFUser.currentUser() == nil){
            self.lickButton.setTitle("Login first!", forState: UIControlState.Normal)
            delegate?.loginControllerShouldAppear()
        }
        else{
            if(self.lickedOrNot == false){
            println("lick")
            var recipeManager = RecipeManager()
            recipeManager.lickRecipe(self.recipe, user: PFUser.currentUser()!) { (success) -> Void in
                if(success){
                    println("Liked")
                }
                else{
                    println("Not Licked")
                }
            }
            var nrOfLicks = self.licks.text!.toInt()! + 1
            self.licks.text = "\(nrOfLicks)"
            self.lickButton.setTitle("Licked :P", forState: UIControlState.Normal)
            
            self.lickedOrNot = true
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        println("step 1")
        if PFUser.currentUser() == nil{
            self.lickButton.setTitle("Log on to lick", forState: UIControlState.Normal)
        }
        
        self.lickButton.addTarget(self, action: "lickButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setParseRecipe(recipe : Recipe) {
        
        self.recipe = recipe
        initialize()
    }
    
    func initialize() {
        // Initialization code
        //check if licked or not
        if PFUser.currentUser() != nil{
            println("step 2")
            var manager = RecipeManager()
            manager.didLikeRecipe(self.recipe,user: PFUser.currentUser()!, completionBlock: { [weak self] (uzer) -> Void in
                println("step 3")
                //var uzer = usser as PFUser!
                if uzer == 1 {
                    self?.lickButton.setTitle("Licked :P", forState: UIControlState.Normal)
                    self?.lickedOrNot = true
                }
                else{
                    self?.lickButton.setTitle("Give it a lick!", forState: UIControlState.Normal)
                    self?.lickedOrNot = false
                }
                self?.reloadInputViews()
                self?.contentView.reloadInputViews()
                println("Ar trebui sa se schimbe")
                })
        }
        
        setSaveButtonTitle()
    }
    
    func setSaveButtonTitle(){
        
        var manager = RecipeManager()
        manager.isRecipeSaved(self.recipe.name!, completionBlock: { (isSaved) -> Void in
            println("s-a intors")
            if isSaved == true{
                self.saveButton.setTitle("got it", forState: UIControlState.Normal)
                self.savedOrNot = true
            }
            else{
                self.saveButton.setTitle("Save", forState: UIControlState.Normal)
                self.savedOrNot = false
            }
        })
        
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        if(self.savedOrNot == false){
            self.saveButton.setTitle("got it", forState: UIControlState.Normal)
            delegate?.infoRecipeCellSaveButtonPressed()
            println("save button pressed")
            self.savedOrNot = true
        }
        
        
        
        
        //        var coreManager = CoreDataManager()
        //        var reteta = RecipeModel()
        //        reteta.time = self.recipe.time
        //        reteta.name = self.recipe.name!
        //
        //        coreManager.saveObject(reteta)
        //
    }
}
