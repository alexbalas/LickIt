//
//  FirstMenuViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit



class FirstMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate, RecipeControllerDelegate {
    
    var recipes: [Recipe] = [Recipe]()
    var numberOfControllerToShow = -1
    var news = [PFFile]()
    var count = Int()
    var enteredInTutorial = false
    var currentMaskView = UIView()
        
    @IBOutlet weak var newsImages: UIImageView!
    
    @IBOutlet weak var forwardNewsButton: UIButton!
    
    @IBOutlet weak var previousNewsButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var weRecommandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var swipeRight = UISwipeGestureRecognizer(target: self, action: "collectionViewSwipe:")
//        swipeRight.numberOfTouchesRequired = 1
//        swipeRight.direction = .Left
//     //   self.collectionView.delegate = self
//       // self.collectionView.dataSource = self
//        self.collectionView.addGestureRecognizer(swipeRight)
//        

        
        
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
        {
            // app already launched
            // open login view controller
            if(PFUser.currentUser() == nil){
                var loginViewController = LogInViewController()
                loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter | PFLogInFields.DismissButton
                loginViewController.del = self
                self.presentViewController(loginViewController, animated: true) { () -> Void in
                }
            }
        }
        else
        {
            // This is the first launch ever
            startTutorial()

        }

        
        
        
        self.title = "Welcome chef!"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Zapfino", size: 20)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        
        
        
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
    
    func startTutorial(){
        self.enteredInTutorial = true
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        var currentWindow = UIApplication.sharedApplication().keyWindow
        let rektImageView = CGRect(x: self.forwardNewsButton.frame.origin.x-currentWindow!.frame.width/2+50, y: self.forwardNewsButton.frame.origin.y+self.forwardNewsButton.frame.height/2+self.forwardNewsButton.frame.width/2-50, width: currentWindow!.frame.width/2, height: currentWindow!.frame.width/2)
 //       var imageView = UIImageView(frame: rektImageView)
  //      imageView.image = UIImage(named: "blueM")
        let circleRekt = CGRect(x: self.forwardNewsButton.frame.origin.x, y: self.forwardNewsButton.frame.origin.y+self.forwardNewsButton.frame.height/2-self.forwardNewsButton.frame.width/2, width: self.forwardNewsButton.frame.width, height: self.forwardNewsButton.frame.width)
        
        let popupRect = CGRect(x: currentWindow!.frame.width-self.forwardNewsButton.frame.width-45, y: self.forwardNewsButton.frame.origin.y+self.forwardNewsButton.frame.height/2-self.forwardNewsButton.frame.width/2-10, width: 100, height: 2)
        creazaGauraCuImagine(self.forwardNewsButton, circleRekt: circleRekt)
        showPopup("see news", sourceViewRekt: popupRect, width: 100, height: 30)
        }
    
    func creazaGauraCuImagine(viu: UIView, circleRekt: CGRect){

        var currentWindow = UIApplication.sharedApplication().keyWindow
        
        var mapView = viu
        mapView.clipsToBounds = false
        
        let frame = mapView.frame
        
        // Add the mask view
        
        var circleArray = [CGRect]()
        //to change the circle customize next line
        circleArray.append(circleRekt)
        
        
        let maskColor = UIColor(white: 0.2, alpha: 0.65)        //UIColor(red: 0.9, green: 0.5, blue: 0.9, alpha: 0.5)
        let parentView = currentWindow//mapView.superview
        let pFrame = parentView!.frame
        var maskView = PartialTransparentMaskView(frame: CGRectMake(0, 0, pFrame.width, pFrame.height), backgroundColor: maskColor, transparentRects: nil, transparentCircles:circleArray, targetView: mapView)
        //pana aici s-a creat ecranul negru cu gauri
        //de aici pui imaginea peste ecranul negru

        self.currentMaskView = maskView
        parentView!.insertSubview(maskView, aboveSubview: mapView)

    }

    
    func showPopup(name: String, sourceViewRekt: CGRect, width: CGFloat, height: CGFloat){
        
        var menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        var _ = menuViewController.view
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSizeMake(width, height)
        menuViewController.name?.text = name
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        let sourceView = UIView(frame: sourceViewRekt)
        self.view.addSubview(sourceView)
        popoverMenuViewController?.sourceView = sourceView
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, width, height)
        
        
        
        println(menuViewController.name?.text)
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
    }

    func hidePopup()
    {
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            
        })
    }
    
    override func loginControllerDismissed(){
        self.navigationItem.rightBarButtonItem = nil
        println("o iesit din login si trrebe sa-si de refresh")
    }
    
    func refresh(){
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        println(self.title)
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
        println("o fost apasat")
        if self.enteredInTutorial == true{
            hidePopup()
            self.currentMaskView.removeFromSuperview()
            creazaGauraCuImagine(self.collectionView, circleRekt: self.collectionView.frame)
            showPopup("check recipes -swipe "+"&choose one", sourceViewRekt: self.weRecommandLabel.frame, width: 125, height: 65)
            var tap = UITapGestureRecognizer(target: self, action: "cellTappedInTutorial:")
            self.collectionView.addGestureRecognizer(tap)
        }

    }
    
    func cellTappedInTutorial(sender: UITapGestureRecognizer){
        
        hidePopup()
        self.currentMaskView.removeFromSuperview()
        
        var punct = self.collectionView.indexPathForItemAtPoint(sender.locationOfTouch(0, inView: self.collectionView))
        collectionView(self.collectionView, didSelectItemAtIndexPath: punct!)
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
    
    func collectionViewSwipe(){
        
        
        hidePopup()
        self.currentMaskView.removeFromSuperview()
        
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
                //aici se intampla sfanta transormare din imagine in thumbnail
                var imagine = UIImage(data: imageData!)
                var destinationSize = cell!.image.frame.size
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell?.image.image = nouaImagine
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var viewController = storyboard!.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
        viewController.recipe = recipes[indexPath.item]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        if self.enteredInTutorial == true{
            viewController.isInTutorial = true
        }
        
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
