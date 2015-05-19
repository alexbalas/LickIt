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
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var whatCanICookImage: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        var manager = RecipeManager()
        manager.getAllRecipes { (recipes: [Recipe]) -> Void in
            println("dajkcnakjsdn")
            self.recipes = recipes
            self.collectionView.reloadData()
        }
        var gesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "imageViewTapped")
        self.whatCanICookImage.addGestureRecognizer(gesture)
        
             // Do any additional setup after loading the view.
        
    
        var loginViewController = PFLogInViewController()
        var users = [PFUser]()
        var user = PFUser()
      //  if(user.isNew){
  
        /*manager.getUsers(users, completionBlock: { (user) -> Void in
            users = user
            
        })
        for user in users{
            println(user.username); print("1")
        }
        
        for user in users{
            if(!(PFFacebookUtils.isLinkedWithUser(user/*.toPFObject()*/))){
            loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter
            self.presentViewController(loginViewController, animated: true) { () -> Void in
    //    }
        }

            }
        }
        //else{
  //          println(user.username)
    //        println(user.password)
        //}*/
    }
    
    func imageViewTapped() {
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("BookmarkedRecipesCollection") as BookmarkedRecipesCollectionViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : WeRecommandCell = collectionView.dequeueReusableCellWithReuseIdentifier("WeRecommandCell", forIndexPath: indexPath) as WeRecommandCell
        var recipe = recipes[indexPath.item]
        cell.licks.text = "\(recipe.numberOfLicks!)"
        cell.licks.font = UIFont(name: "AmericanTypewriter", size: 14)
        cell.name.text = recipe.name
        cell.name.font = UIFont(name: "Zapfino", size: 18)
        recipes[indexPath.row].image?.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if !(error != nil) {
                cell.image.image = UIImage(data:imageData)
            }
        }
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
    
    override func viewDidAppear(animated: Bool) {

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
