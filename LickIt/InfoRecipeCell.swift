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
    func infoRecipeCellSaveButtonPressed(cell : InfoRecipeCell)
}

class InfoRecipeCell: UITableViewCell {

    var recipe: Recipe!
    var lickedOrNot: Bool!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var licks: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var lickButton: UIButton!
    
    var delegate : InfoRecipeCellDelegate?
    
    @IBAction func lickButtonPressed(sender: AnyObject) {
        
        if(PFUser.currentUser() == nil){
            self.lickButton.titleLabel?.text = "Login first!"
        }
        else{
        println("lick")
        var recipeManager = RecipeManager()
        recipeManager.lickRecipe(self.recipe, user: PFUser.currentUser()) { (success) -> Void in
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
        // Initialization code
        
    
    /*
        if(self.lickedOrNot == true){
            self.lickButton.titleLabel?.text = "Licked :P"
        }
        else{
            self.lickButton.titleLabel?.text = "Give it a lick!"
        }
        */
        self.lickButton.addTarget(self, action: "lickButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func saveButtonPressed(sender: UIButton) {
        delegate?.infoRecipeCellSaveButtonPressed(self)
        println("save button pressed")
        
        var coreManager = CoreDataManager()
        var reteta = RecipeModel()
        reteta.time = self.recipe.time
        reteta.name = self.recipe.name!
        
        coreManager.saveObject(reteta)
        
    }
}
