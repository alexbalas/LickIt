//
//  FirstMenuViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class FirstMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    var recipes: [Recipe] = [Recipe]()
    var numberOfControllerToShow = -1
    var news = [PFFile]()
    var count = Int()
    
    @IBOutlet weak var newsImages: UIImageView!
    
    @IBOutlet weak var forwardNewsButton: UIButton!
    
    @IBOutlet weak var previousNewsButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome chef!"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Zapfino", size: 20)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()

        if(PFUser.currentUser() == nil){
            var loginViewController = LogInViewController()
            loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter | PFLogInFields.DismissButton
            
            self.presentViewController(loginViewController, animated: true) { () -> Void in
            }
        }
       
        var manager = RecipeManager()
        manager.getRecommendedRecipes(5, completionBlock: { (recipess) -> Void in
            self.recipes = recipess
            self.collectionView.reloadData()
        })
       
        
        //setare news
        manager.getNews { (exctractedNews) -> Void in
            if (exctractedNews.count > 0){
                self.news = exctractedNews
                self.news[0].getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if !(error != nil) {
                        var img = UIImage(data:imageData!)
                        self.newsImages.image = img
                        self.count = 0
                    }
                }
            }
        }
        
        //setare butoane pentru schimbarea news-urilor
        forwardNewsButton.addTarget(self, action: "forwardNewsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        previousNewsButton.addTarget(self, action: "previousNewsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
    
    }
    
    func forwardNewsButtonPressed(){
        if(self.count<self.news.count-1){
            self.count++
            news[self.count].getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData!)
                    self.newsImages.image = img
                }
            }
        }
    }
    
    func previousNewsButtonPressed(){
        if(self.count>0){
            self.count--
            news[self.count].getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var img = UIImage(data:imageData!)
                    self.newsImages.image = img
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : WeRecommandCell = collectionView.dequeueReusableCellWithReuseIdentifier("WeRecommandCell", forIndexPath: indexPath) as! WeRecommandCell
        var recipe = recipes[indexPath.item]
        cell.licks.text = "\(recipe.numberOfLicks!)"
        cell.licks.font = UIFont(name: "AmericanTypewriter", size: 14)
        cell.name.text = recipe.name
        cell.name.font = UIFont(name: "Zapfino", size: 18)
        var size = 18 as CGFloat
        while( cell.name.intrinsicContentSize().width > cell.name.frame.width ){
            cell.name.font = UIFont(name: "Zapfino", size: size - 1)
            size--
        }
        recipes[indexPath.row].image?.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                cell.image.image = UIImage(data:imageData!)
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
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
