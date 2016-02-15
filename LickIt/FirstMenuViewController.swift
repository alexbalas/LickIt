//
//  FirstMenuViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit



class FirstMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate, RecipeControllerDelegate, PFLogInViewControllerDelegate, UISearchBarDelegate, SearchTableViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var recipes: [Recipe] = [Recipe]()
    var numberOfControllerToShow = -1
    var news = [PFFile]()
    var count = Int()
    var enteredInTutorial = false
    weak var tapRecognizerOnCells: UITapGestureRecognizer?
    weak var currentMaskView = UIView()

    
    var searchBar : UISearchBar?
    var searchResultTableView : UITableView?
    var searchResultRecipes = [Recipe]()
    var isFirstCharacterInSearch = true
    var retete = [Recipe]()
    
    @IBOutlet weak var newsImages: UIImageView!
    
    @IBOutlet weak var forwardNewsButton: UIButton!
    
    @IBOutlet weak var previousNewsButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var weRecommandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  //      UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)

        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didComeToForeGround", name: UIApplicationDidBecomeActiveNotification, object: nil)
//        var swipeRight = UISwipeGestureRecognizer(target: self, action: "collectionViewSwipe:")
//        swipeRight.numberOfTouchesRequired = 1
//        swipeRight.direction = .Left
//     //   self.collectionView.delegate = self
//       // self.collectionView.dataSource = self
//        self.collectionView.addGestureRecognizer(swipeRight)
//        
        
        addSearchBar()
        //butonul drept
        if(PFUser.currentUser() == nil){
            var rightMenuButton = UIButton(frame: CGRect(x: 280, y: 0, width: 40, height: 40))
            var image = UIImage(named: "key")
            rightMenuButton.setImage(image, forState: UIControlState.Normal)
            rightMenuButton.addTarget(self, action: "rightMenuButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            var rightMenuButtonItem = UIBarButtonItem(customView: rightMenuButton)
            self.navigationItem.rightBarButtonItem = rightMenuButtonItem
            
            //numai daca nu e logat se poate sa nu fi trecut prin tutorial
            if(!(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce")))
            {
                //first launch ever
                startTutorial()
            }
            else{
                
                if(NSUserDefaults.standardUserDefaults().boolForKey("WasClosed")){
                    NSUserDefaults.standardUserDefaults().setBool(false, forKey: "WasClosed")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    rightMenuButtonPressed()
                }
                //functia care porneste login view controller
            }
        }
        else{
//            var butonCareNuFaceNimic = UIButton(frame: CGRect(x: 280, y: 0, width: 40, height: 40))
//            var rightBarItem = UIBarButtonItem(customView: butonCareNuFaceNimic)
//            self.navigationItem.rightBarButtonItem = rightBarItem
//            println("o fost pus butonul ce nu face nimic")
        }
    

        
        
        
//        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
//        {
//            // app already launched
//            // open login view controller
//            if(PFUser.currentUser() == nil){
//                var loginViewController = LogInViewController()
//                loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter | PFLogInFields.DismissButton
//                loginViewController.delegate = self
//                self.presentViewController(loginViewController, animated: true) { () -> Void in
//                }
//            }
//        }
//        else
//        {
//            // This is the first launch ever
//            
//
//        }

        
        
        
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
    
    func addSearchBar(){
        var fraim = CGRect(x: 0, y: 60, width: UIScreen.mainScreen().bounds.width, height: 30)
        var searchBar = UISearchBar(frame: fraim)
        searchBar.delegate = self
        self.searchBar = searchBar
        self.view.addSubview(searchBar)
    }
    
    override func menuButtonPressed(sender: AnyObject) {
        super.menuButtonPressed(sender)
        if self.enteredInTutorial{
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.enteredInTutorial = false
        hidePopup()
        self.currentMaskView!.removeFromSuperview()
        }
        
    }
    
    func rightMenuButtonPressed(){
        println("apasat")
        var loginViewController = LogInViewController()
        loginViewController.fields = PFLogInFields.Facebook | PFLogInFields.Twitter | PFLogInFields.DismissButton
        
        loginViewController.delegate = self

        self.navigationController?.pushViewController(loginViewController, animated: true)

    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.popViewControllerAnimated(true)
       // self.dismissViewControllerAnimated( true, completion: nil)
        
    }
    
    func startTutorial(){
        self.enteredInTutorial = true
        
        
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
    
    
    func refresh(indexPath: NSIndexPath){
        self.recipes[indexPath.item].numberOfLicks!++
        self.collectionView.reloadData()
        self.collectionView.reloadInputViews()
//        var array = [NSIndexPath]()
//        var indexCells = self.collectionView.visibleCells()
//        for indexCell in indexCells{
//            var indexPath = indexCell.indexPath
//            array.append(indexPath)
//        }
//        self.collectionView.reloadItemsAtIndexPaths(array)
    }
    
    func revineInTutorial() {
        //aici revii din recipe in cadrul tutorialului
        //pui mask cu gaura pe menuButton
        if self.enteredInTutorial{
        var viu = self.navigationItem.leftBarButtonItem!.customView//UIView(frame: CGRect(x: 100, y: 100, width: 64,height: 64))//self.navigationItem.leftBarButtonItem!.width, height: self.navigationController!.navigationBar.frame.height))
       // self.view.addSubview(viu)
        println(viu)
        creazaGauraCuImagine(viu!, circleRekt: CGRect(x: 0, y: 10, width: 70, height: 70))
        showPopup("the magic "+"MENU-BUTTON", sourceViewRekt: viu!.frame, width: 125, height: 65)
//        var tap = UITapGestureRecognizer(target: self, action: "menuButtonPressed:")
//        self.navigationController?.navigationBar.addGestureRecognizer(tap)
//        self.tapRecognizerOnNavigatioBar = tap
        }
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func cellTappedInTutorial(sender: UITapGestureRecognizer){
        if self.enteredInTutorial == true{
        hidePopup()
        self.currentMaskView!.removeFromSuperview()
        self.collectionView.removeGestureRecognizer(self.tapRecognizerOnCells!)
        
        var punct = self.collectionView.indexPathForItemAtPoint(sender.locationOfTouch(0, inView: self.collectionView))
        collectionView(self.collectionView, didSelectItemAtIndexPath: punct!)
        }
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
            self.currentMaskView!.removeFromSuperview()
            creazaGauraCuImagine(self.collectionView, circleRekt: self.collectionView.frame)
            showPopup("check recipes -swipe "+"&choose one", sourceViewRekt: self.weRecommandLabel.frame, width: 125, height: 65)
            var tap = UITapGestureRecognizer(target: self, action: "cellTappedInTutorial:")
            self.collectionView.addGestureRecognizer(tap)
            self.tapRecognizerOnCells = tap
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
       //     viewController.isInTutorial = true
        }
        viewController.delegate = self
        viewController.indexPath = indexPath
        self.navigationController?.pushViewController(viewController, animated: true)
        
//        var viewController = storyboard!.instantiateViewControllerWithIdentifier("WebViewTableController") as! WebViewTableController
//        self.navigationController?.pushViewController(viewController, animated: true)
//        println(self.navigationController?.viewControllers)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func didComeToForeGround(){
        if(self.enteredInTutorial){
        
        }
    }
    
    func openRecipe(recipe: Recipe){
        //        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard!.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        viewController.recipe = recipe

        
        self.searchBar!.resignFirstResponder()
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func createTableViewWithResults(retete: [Recipe]){
        var tableViu = UITableView(frame: CGRect(x: 0, y: 60+30, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height-90))
        tableViu.delegate = self
        tableViu.dataSource = self
    //    tableViu.retete = retete
        self.searchResultTableView = tableViu
        self.view.addSubview(self.searchResultTableView!)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchResultTableView == nil{
            var ret = [Recipe]()
            createTableViewWithResults(ret)
        }
        if searchText == ""{
                self.searchResultTableView?.removeFromSuperview()
                self.isFirstCharacterInSearch = true
            }
            else{
                var manager = RecipeManager()
                manager.getSearchedRecipes(searchText, completionBlock: { (retete) -> Void in
                    var resipiz = [Recipe]()
                    println("found these")
                    println(retete)
//                    for reteta in retete{
//                        resipiz.append(reteta)
//                    }
                  //  self.searchResultTableView?.removeFromSuperview()
                  //  self.createTableViewWithResults(retete)
                    self.retete = retete
                    self.searchResultTableView!.reloadData()
                    self.searchResultTableView!.reloadInputViews()
                })
                if self.isFirstCharacterInSearch{
                    self.isFirstCharacterInSearch = false
                    self.view.addSubview(self.searchResultTableView!)
                }
            }
    }
    
    
    
    //de aici incepe customizare table-viewului din first page
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retete.count
    }
    
    //    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
    //        var cell = UITableViewCell(frame: CGRect(x: 0, y: CGFloat(indexPath.row) * (self.frame.height/6), width: self.frame.width, height: self.frame.height/6))
    //        var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height))
    //        println("recipiz din cellforrow")
    //        println(self.retete)
    //        retete[indexPath.row].image?.getDataInBackgroundWithBlock {
    //            (imageData: NSData?, error: NSError?) -> Void in
    //            if !(error != nil) {
    //                //aici se intampla sfanta transormare din imagine in thumbnail
    //                var imagine = UIImage(data: imageData!)
    //                var destinationSize = CGSize(width: imgView.frame.width, height: imgView.frame.height)
    //                UIGraphicsBeginImageContext(destinationSize)
    //                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
    //                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
    //                UIGraphicsEndImageContext()
    //                imgView.image = nouaImagine
    //            }
    //
    //        }
    //
    //        var label = UILabel(frame: CGRect(x: imgView.frame.width+10, y: 15, width: self.frame.width - imgView.frame.width - 20, height: cell.frame.height - 30))
    //        label.numberOfLines = 2
    //        label.adjustsFontSizeToFitWidth = true
    //        label.font = UIFont(name: "Zapfino", size: 16)
    //        label.text = self.retete[indexPath.row].name
    //
    //
    //        cell.addSubview(imgView)
    //        cell.addSubview(label)
    //
    //        return cell
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(frame: CGRect(x: 0, y: CGFloat(indexPath.row) * (UIScreen.mainScreen().bounds.height/6), width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height/6))
        var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height))
        println("recipiz din cellforrow")
        println(self.retete)
        retete[indexPath.row].image?.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                //aici se intampla sfanta transormare din imagine in thumbnail
                var imagine = UIImage(data: imageData!)
                var destinationSize = CGSize(width: imgView.frame.width, height: imgView.frame.height)
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                imgView.image = nouaImagine
            }
            
        }
        
        var label = UILabel(frame: CGRect(x: imgView.frame.width+10, y: 15, width: UIScreen.mainScreen().bounds.width - imgView.frame.width - 20, height: cell.frame.height - 30))
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Zapfino", size: 16)
        label.text = self.retete[indexPath.row].name
        
        
        cell.addSubview(imgView)
        cell.addSubview(label)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        //        viewController.recipe = self.retete[indexPath.row]
        openRecipe(self.retete[indexPath.row])
        
        //        self.resultSearchController.searchBar.resignFirstResponder()
        //        self.resultSearchController.active = false
        //
        //        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    deinit{
        self
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
