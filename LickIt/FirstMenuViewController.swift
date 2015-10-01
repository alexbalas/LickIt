//
//  FirstMenuViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class FirstMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {
    
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
                    (data: NSData?, error: NSError?) -> Void in
                    if !(error != nil) {
                      //  var img = UIImage(data:imageData!)
                        self.newsImages.image = UIImage(data:data!)
                        self.count = 0
                    }
                }
            }
        
        }
        //setare butoane pentru schimbarea news-urilor
        forwardNewsButton.addTarget(self, action: "forwardNewsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        previousNewsButton.addTarget(self, action: "previousNewsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        //internet connection check
        
        checkForInternetConnection()
        
        // Do any additional setup after loading the view.
    }
    
    func checkForInternetConnection(){
        var checker = Reachability.isConnectedToNetwork()
        if checker == false{
            showInternetConnectionMessage()
        }
    }
    
    func showInternetConnectionMessage(){
        var menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        var _ = menuViewController.view
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSize(width: self.view.bounds.width, height: 60)
        //  var message = UILabel(frame: CGRect(x: 110, y: 110, width: self.view.bounds.width, height: 200))
        //message.text = "no internet connection \n you can only search saved recipes"
        menuViewController.name?.text = "no internet connection"
        menuViewController.name?.font = UIFont(name: "ChalkboardSE-Bold", size: 30)
        //menuViewController.name?.frame.origin = CGPoint(x: 0, y: self.view.bounds.height/2)
        
        //menuViewController.view.addSubview(message)
        //menuViewController.view.bringSubviewToFront(message)
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, 500, 50)//self.view.bounds
        
        
        
        println(menuViewController.name?.text)
        
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
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
        recipe.image?.getDataInBackgroundWithBlock {
            [weak cell]
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                cell?.image.image = UIImage(data:imageData!)
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var viewController = storyboard!.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
        viewController.recipe = recipes[indexPath.item]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        println(self.navigationController?.viewControllers)
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
