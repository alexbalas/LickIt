//
//  RecipeViewController.swift
//  LickIt
//
//  Created by MBP on 24/02/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import WebKit
import iAd
import ParseUI

protocol RecipeControllerDelegate: class {
    func refresh(indexPath: NSIndexPath)
    func revineInTutorial()
}

class RecipeViewController: UITableViewController, InfoRecipeCellDelegate, UICollectionViewDelegate,UIPopoverPresentationControllerDelegate, OneIngredientRecipeCellDelegate, PFLogInViewControllerDelegate, ADBannerViewDelegate, WebViewDelegate {
    
    weak var bannerView: ADBannerView!
    
    weak var recipe: Recipe!
    var lickedOrNot = false
    var savedOrNot = false
    var backButtonText: String?
    var delegate: RecipeControllerDelegate?
    var isInTutorial = false
    var isSavedRecipe = false
    weak var indexPath: NSIndexPath?
    weak var currentMaskView = UIView()
    var rects = [CGRect]()
    weak var upButton = UIButton()

    var screenShotOfRecipe = UIImage()
    var timerForScreenShot = NSTimer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.tableView.scrollEnabled = false
        self.canDisplayBannerAds = true
        
        self.title = self.recipe.name
        let recipeManager = RecipeManager()
        recipeManager.getIngredientsForRecipe(self.recipe, completionBlock: { [weak self] (ingredients) -> Void in
            self?.recipe.ingredients = ingredients
            
            self?.tableView.reloadData()
            })
        _ = UIImage(named: "back")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed:")
        
        if self.isInTutorial{
            createMaskForCell(0,message: "The big pic!")
        }

        self.tableView.bounces = false
    }
  
    func createAdBanner(){
//        bannerView = ADBannerView(adType: .Banner)
// //       bannerView.translatesAutoresizingMaskIntoConstraints = false
//   //     bannerView.translatesAutoresizingMaskIntoConstraints() = false
//     //   bannerView.autoresizingMas
//        bannerView.delegate = self
//        bannerView.delegate = self
//        bannerView.hidden = true
//        view.addSubview(bannerView)
//        
//        let viewsDictionary = ["bannerView": bannerView]
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
    }
    
    func didInteractWithLickButton() {
        self.lickedOrNot = true
    }
    
    func createMaskForCell(nrCell: Int, message: String){
        let indexPath = NSIndexPath(forRow: nrCell, inSection: 0)
        var cell = UITableViewCell()
        switch nrCell {
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as! InfoRecipeCell
            
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as! IngredientsRecipeCell
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("HowToDoItCell", forIndexPath: indexPath) as! HowToDoItCell
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as! ImageRecipeCell

            
            
        }

//        var cellRect = self.rects[nrCell]//cellForRowAtIndexPath(NSIndexPath(forRow: nrCell+1, inSection: 1))!.frame
//        println(self.tableView.rectForRowAtIndexPath(NSIndexPath(forRow: nrCell+1, inSection: 1)))
//        cellRect = CGRectMake(cellRect.origin.x - tableView.contentOffset.x, cellRect.origin.y - tableView.contentOffset.y, cellRect.size.width, cellRect.size.height)
   //     var height = self.tableView(self.tableView, heightForRowAtIndexPath: indexPath)
   //     var circleRekt = CGRect(x: cell.frame.origin.x, y: 174, width: cell.frame.width, height: cell.frame.height)
        creazaGauraCuImagine(cell, circleRekt: cell.frame)
        let viu = UIView(frame: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: 100, height: 60))
        showPopup(message, cell: viu)//sourceViewRekt: cell.frame, width: 100, height: 60)
    }
    
    func creazaGauraCuImagine(viu: UIView, circleRekt: CGRect){
        
        let currentWindow = UIApplication.sharedApplication().keyWindow
        
        let mapView = viu
        mapView.clipsToBounds = false
        
       // let frame = mapView.frame
        
        // Add the mask view
        
        var circleArray = [CGRect]()
        //to change the circle customize next line
        circleArray.append(circleRekt)
        
        
        let maskColor = UIColor(white: 0.2, alpha: 0.65)        //UIColor(red: 0.9, green: 0.5, blue: 0.9, alpha: 0.5)
        let parentView = currentWindow//mapView.superview
        let pFrame = parentView!.frame
        let maskView = PartialTransparentMaskView(frame: CGRectMake(0, 0, pFrame.width, pFrame.height), backgroundColor: maskColor, transparentRects: nil, transparentCircles:circleArray, targetView: mapView)
        //pana aici s-a creat ecranul negru cu gauri
        //de aici pui imaginea peste ecranul negru
        
        self.currentMaskView = maskView
        parentView!.insertSubview(maskView, aboveSubview: mapView)
        
    }


        
    
    
    func showPopup(name: String, cell: UIView){
        
        let menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        var _ = menuViewController.view
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSizeMake(100, 60)
        menuViewController.name?.text = name
        
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = cell
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, 100, 60)
        
        
        
        print(menuViewController.name?.text)
        
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
    }

//    func showPopup(name: String, sourceViewRekt: CGRect, width: CGFloat, height: CGFloat){
//        
//        
//        let menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
//        var _ = menuViewController.view
//        menuViewController.modalPresentationStyle = .Popover
//        menuViewController.preferredContentSize = CGSizeMake(width, height)
//        menuViewController.name?.text = name
//        
//        let popoverMenuViewController = menuViewController.popoverPresentationController
//        popoverMenuViewController?.permittedArrowDirections = .Any
//        popoverMenuViewController?.delegate = self
//        let sourceView = UIView(frame: sourceViewRekt)
//        self.view.addSubview(sourceView)
//        popoverMenuViewController?.sourceView = sourceView
//        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, width, height)
//        
//        
//        
//        print(menuViewController.name?.text)
//        presentViewController(
//            menuViewController,
//            animated: true,
//            completion: nil)
//    }

    
    func hidePopup()
    {
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            
        })
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    

    
    func settedBackButtonPressed(buton: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    
        if self.delegate != nil && self.lickedOrNot{
            self.delegate?.refresh(self.indexPath!)
            self.delegate?.revineInTutorial()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.popViewControllerAnimated(true)
        // self.dismissViewControllerAnimated( true, completion: nil)
        
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("InfoRecipeCell", forIndexPath: indexPath) as! InfoRecipeCell
            cell.delegate = self
   //         cell.time.text = "\(recipe.time!)"+" min"
            if(self.recipe.numberOfLicks! > -1){
                print(cell.licks)
            
                cell.licks.text = "\(self.recipe.numberOfLicks!)"
            }
            else{
                cell.licks.text = "?"
            }
            if(self.savedOrNot == true){
                cell.saveButton.titleLabel?.text = "you have it"
            }
            print("waaaaaaaa")
            print(cell.frame.height)
            cell.setParseRecipe(recipe)
            self.rects.append(cell.frame)

            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("IngredientsRecipeCell", forIndexPath: indexPath) as! IngredientsRecipeCell
            if let ingredients = recipe.ingredients{
                
                cell.ingredients = ingredients
                cell.collectionView.reloadData()
                cell.delegate = self
                
            }
            self.rects.append(cell.frame)

            return cell
        case 3:
//
            let cell = tableView.dequeueReusableCellWithIdentifier("WebView", forIndexPath: indexPath) as! WebViewTableViewCell
            if hasInternetConnection(){
                cell.site = self.recipe.recipeDescription!
            }
            else{
                cell.site = self.recipe.htmlString!
            }
            if self.isSavedRecipe == true{
                cell.isSavedRecipe = true
            }
            cell.delegate = self
            cell.loadWebsite(self.recipe.name!)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageRecipeCell", forIndexPath: indexPath) as! ImageRecipeCell
            
            recipe.image?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                cell.imagine.image = UIImage(data:data!)
            })
       //     cell.imagine.image = UIImage(named: "lick.gif")
            self.tableView.rowHeight = 110.0
            //      cell.imagine.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
            //      cell.imagine.sizeToFit()
            self.rects.append(cell.frame)
            return cell
            
        }
    }
    
    func hasInternetConnection() -> Bool {
        let checker = Reachability.isConnectedToNetwork()
        if checker == false{
            return false
        }
        return true
    }
    
    //    func didAlreadyLikeRecipe(user: PFUser) -> Bool{
    //
    //        var relatie = self.recipe.parseObject?.relationForKey("lickers")
    //        var query = PFQuery(className: "Recipe")
    //        var relationQuery = relatie?.query()!.whereKey("objectId", equalTo: user.objectId!)
    //
    //        var smth = relationQuery?.getFirstObject()
    //        if( smth != nil ){
    //            return true
    //        }
    //        else{
    //            return false
    //        }
    //    }
    
    //    func didLikeRecipe(user: PFUser, completionBlock:(PFUser) -> Void){
    //        var relatie = self.recipe?.parseObject?.relationForKey("lickers")
    //        var query = PFQuery(className: "Recipe")
    //        var relationQuery = relatie?.query()!.whereKey("objectId", equalTo: user.objectId!)
    //        var smth: Void? = relationQuery?.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
    //            var usser = PFUser()
    //            if let uzer = object as? PFUser{
    //                usser = uzer
    //            }
    //            completionBlock(usser)
    //        })
    //    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
//            var atribute = [
//                NSFontAttributeName : UIFont.systemFontOfSize(14)]
//            if (self.recipe.recipeDescription != nil){
//                var dimensions = (self.recipe.recipeDescription! as NSString).boundingRectWithSize(CGSize(width: self.view.frame.size.width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: atribute, context: nil)
//                return 1.3*dimensions.height
            
            return UIScreen.mainScreen().bounds.height-84
        }
  //          else{
 //               return 100
  //          }
    //    }
        else if indexPath.row == 2 {
            return 70
        }
        return 100
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func infoRecipeCellSaveButtonPressed() {
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! WebViewTableViewCell
        cell.saveRecipe(self.recipe)
    }
    
    func showSavingErrorAlert(cell: WebViewTableViewCell){
        let alert = UIAlertController(title: "Error", message: "Something went wrong. Please try again", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction)in
            print("User click Close button")
           // alert.removeFromParentViewController()
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction)in
            print("User click Ok button")
            alert.dismissViewControllerAnimated(true, completion: nil)
            cell.saveRecipe(self.recipe)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func makeScreenShot(){

//        self.tableView(self.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 3, inSection: 0))
//        self.timerForScreenShot.invalidate()
//        self.timerForScreenShot = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateScreenShotCount", userInfo: nil, repeats: true)

        
        //  hideRecipeWebView()
        
    }
    
    func updateScreenShotCount(){
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! WebViewTableViewCell
        if cell.hasFinishedNavigation == true{
            self.timerForScreenShot.invalidate()
            cell.saveRecipe(self.recipe)
        }
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        if(indexPath.row==0){
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let viewController = storyboard.instantiateViewControllerWithIdentifier("FullScreenImageController") as! FullScreenPicController
            
            viewController.imageFile = self.recipe.image
            viewController.nume = self.recipe.name
            
            if(self.isInTutorial){
                hidePopup()
                self.currentMaskView!.removeFromSuperview()
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        if(indexPath.row==3){
          //  self.canDisplayBannerAds = false
            let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! WebViewTableViewCell
            //arata webview
            cell.showRecipeWebsite()
            //cell.loadWebsite()
            //ascunde navigation bar
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            //auto scroll la nivelul dorit
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            //add button
            let rect = UIScreen.mainScreen().bounds
           // var ingredientCellOriginY = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))?.frame.origin.y
            let button = UIButton(frame: CGRect(x: rect.width-35, y: rect.height-45+200-25, width: 35, height: 45))
            button.addTarget(self, action: "hideRecipeWebView", forControlEvents: UIControlEvents.TouchUpInside)
            button.setBackgroundImage(UIImage(named: "up"), forState: UIControlState.Normal)
            self.upButton = button
            self.view.addSubview(self.upButton!)
            if self.isSavedRecipe == true{
                cell.isSavedRecipe = true
            }
            
            print(rect.height)
            print(self.upButton?.frame.origin.y)
            print(cell.frame.origin.y)
          //  self.tableView.reloadInputViews()
            
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.tableView.visibleCells.count > 3 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
    }
    
    func hideRecipeWebView(){
        
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! WebViewTableViewCell
        cell.hideRecipeWebsite()
        self.upButton?.removeFromSuperview()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        
    }
    
    func loginControllerShouldAppear() {
        let loginViewController = LogInViewController()
        loginViewController.fields = [PFLogInFields.Facebook, PFLogInFields.Twitter, PFLogInFields.DismissButton]
        
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showCongratzMessage(){
        let alert = UIAlertController(title: "YEEEESSSS", message: "Achievement unlocked!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction)in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        self
        print("deinitCalled")
    }
    
}
