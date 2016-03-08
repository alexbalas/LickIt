//
//  InfoRecipeCell.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


protocol InfoRecipeCellDelegate : NSObjectProtocol {
    func infoRecipeCellSaveButtonPressed()
    func loginControllerShouldAppear()
    func showCongratzMessage()
    func didInteractWithLickButton()
}

class InfoRecipeCell: UITableViewCell {
    
    private var recipe : Recipe!
    var lickedOrNot: Bool!
    var savedOrNot: Bool!
    var initializedOrNot = false
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var licks: UILabel!
    
    var lickImageView = AnimatableImageView()
    @IBOutlet weak var saveButton: UIButton!
 //@IBOutlet weak var lickButton: UIButton!
    var lickButton: UIButton!
    weak var delegate : InfoRecipeCellDelegate?
    var bgMusic = AVAudioPlayer()

    
    func lickButtonPressed() {
        
        if(PFUser.currentUser() == nil){
            self.lickButton.setTitle("Login first!", forState: UIControlState.Normal)
            delegate?.loginControllerShouldAppear()
        }
        else{
            if(self.lickedOrNot == false){
                print("lick")
                let recipeManager = RecipeManager()
                recipeManager.lickRecipe(self.recipe, user: PFUser.currentUser()!) { (success) -> Void in
                    if(success){
                        print("Liked")
                    }
                    else{
                        print("Not Licked")
                    }
                }
                let nrOfLicks = Int(self.licks.text!)! + 1
                self.licks.text = "\(nrOfLicks)"
                self.lickButton.setTitle("Licked :P", forState: UIControlState.Normal)
            
                self.lickedOrNot = true
            
                
                if let licks = NSUserDefaults.standardUserDefaults().valueForKey("licks") as? Int{
                    NSUserDefaults.standardUserDefaults().setValue(licks + 1, forKey: "licks")
                    print(licks)
                    if licks + 1  == 10 | 100 | 500{
                        self.delegate?.showCongratzMessage()
                    }
                }
                else{
                    NSUserDefaults.standardUserDefaults().setValue(1, forKey: "licks")
                }
                
                self.delegate?.didInteractWithLickButton()
            }
        }
        
    }
    
    func playSound(){
        
        let bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("sound", withExtension: "mp3")!
        do { bgMusic = try AVAudioPlayer(contentsOfURL: bgMusicURL, fileTypeHint: nil) }
        catch _{
            return print("no music file")
        }
        bgMusic.numberOfLoops = 2
    //    bgMusic.enableRate = true
   //     bgMusic.rate = 0.75
        bgMusic.prepareToPlay()
        bgMusic.playAtTime(bgMusic.deviceCurrentTime+0.5)
        
    }
    
    func playEffectSound(filename: String){
        //SKAction.playSoundFileNamed("\(filename)", waitForCompletion: false)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lickedOrNot = true
        
        //create gifView
        let gifView = AnimatableImageView(frame: CGRect(x: UIScreen.mainScreen().bounds.width/2-50, y: 0, width: 100, height: 100))
        print(gifView.frame.origin.x)
        self.lickImageView = gifView
        self.addSubview(self.lickImageView)
        
        //assign gif
        //gif will be assigned when i know if its liked or not
        
        
//        if self.lickedOrNot != nil{
//        self.lickImageView.animateWithImage(named: "lick.gif")
//        self.lickImageView.stopAnimatingGIF()
//        }
        
        //create touch detector
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("gifTapped"))
        self.lickImageView.userInteractionEnabled = true
        self.lickImageView.addGestureRecognizer(tapGestureRecognizer)
        
        //add lick button
        let buton = UIButton(frame: self.lickImageView.frame)
        self.lickButton = buton
        print("step 1")
//                var img = UIImage.gifWithName("lick")
//
//                var imgViu = UIImageView(image: img)
//                imgViu.frame = CGRect(x: UIScreen.mainScreen().bounds.width/2, y: self.frame.origin.y, width: 40, height: 40)
//                self.addSubview(imgViu)
//                self.contentView.addSubview(imgViu)
//                println(imgViu.frame)
//                println(self.lickButton.frame)
//        
//        self.lickButton.frame = CGRectMake(self.frame.width/2, 0, 50, self.frame.height)
//        self.lickButton.setImage(UIImage.gifWithName("lick"), forState: UIControlState.Normal)
        if PFUser.currentUser() == nil{
            self.lickButton.setTitle("Log on to lick", forState: UIControlState.Normal)
        }
        
        self.lickButton.addTarget(self, action: "lickButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func gifTapped(){
        if self.lickedOrNot == false{
            self.lickImageView.startAnimatingGIF()
            _ = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("timerFinished"), userInfo: nil, repeats: false)
            playSound()
        }
    }
    
    func timerFinished(){
        self.lickImageView.stopAnimatingGIF()
        self.lickImageView.image = UIImage(named: "licked")
        lickButtonPressed()

    }
    func setParseRecipe(recipe : Recipe) {
        
        self.recipe = recipe
        initialize()
    }
    
    func initialize() {
        if self.initializedOrNot == false{
        // Initialization code
        //check if licked or not
        if PFUser.currentUser() != nil{
            print("step 2")
            let manager = RecipeManager()
            manager.didLikeRecipe(self.recipe,user: PFUser.currentUser()!, completionBlock: { [weak self] (uzer) -> Void in
                print("step 3")
                //var uzer = usser as PFUser!
                if uzer == 1 {
                    self!.lickedOrNot = true
                    self!.lickImageView.image = UIImage(named: "licked")

                   
                }
                else{
                    self?.lickedOrNot = false
                    self!.lickImageView.animateWithImage(named: "lick.gif")
                    self!.lickImageView.stopAnimatingGIF()
                }
                self?.reloadInputViews()
              //  self?.contentView.reloadInputViews()
                print("Ar trebui sa se schimbe")
                })
        }
        
        setSaveButtonTitle()
        self.initializedOrNot = true
        }
    }
    
    func setSaveButtonTitle(){
        
        let manager = RecipeManager()
        manager.isRecipeSaved(self.recipe.name!, completionBlock: { (isSaved) -> Void in
            print("s-a intors")
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
            print("save button pressed")
            self.savedOrNot = true
            
            if let licks = NSUserDefaults.standardUserDefaults().valueForKey("saves") as? Int{
                NSUserDefaults.standardUserDefaults().setValue(licks + 1, forKey: "saves")
                if licks + 1 == 10 | 20 | 5{
                    self.delegate?.showCongratzMessage()
                }
            }
            else{
                NSUserDefaults.standardUserDefaults().setValue(1, forKey: "saves")
            }
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
