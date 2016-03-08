//
//  TopWantedViewController.swift
//  LickIt
//
//  Created by MBP on 06/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import Photos

class TopWantedViewController: BaseTableViewController, UIPopoverPresentationControllerDelegate {

    var topRecipes: [Recipe]?
    weak var phManager: PHImageManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if topRecipes == nil{
        let manager = RecipeManager()
        manager.getTopRecipes(20, completionBlock: { (recipes) -> Void in
            weak var slf = self
            slf!.topRecipes = recipes
            slf!.tableView.reloadData()
        })
        }
        checkForInternetConnection()
        
        // Do any additional setup after loading the view.
    }
    
    func checkForInternetConnection(){
        let checker = Reachability.isConnectedToNetwork()
        if checker == false{
            showInternetConnectionMessage()
        }
    }
    
    
    
    func showInternetConnectionMessage(){
        let menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
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
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, 0, 0)//self.view.bounds
        
        
        
        print(menuViewController.name?.text)
        
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (topRecipes != nil){
            return topRecipes!.count
        }
        else{
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("TopWantedRecipeCell", forIndexPath: indexPath) as! TopWantedRecipeCell
            topRecipes![indexPath.row].image?.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil){
                    autoreleasepool{
                    //aici se intampla sfanta transormare din imagine in thumbnail
                    let imagine = UIImage(data: imageData!)
                    let destinationSize = cell.recipeImage.frame.size
                    UIGraphicsBeginImageContext(destinationSize)
                    imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                    let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    cell.recipeImage.image = nouaImagine
                    }
//                    UIImage *originalImage = ...;
//                    CGSize destinationSize = ...;
//                    UIGraphicsBeginImageContext(destinationSize);
//                    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
//                    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//                    UIGraphicsEndImageContext();
                }
        }
//        var fetchOptions = PHFetchOptions()
//
//        var img = UIImage()
//        
//        var asset = PHAsset.fetchAssetsWithMediaType(mediaType: PHAssetMediaType.Image, options: )
//        var options = PHImageRequestOptions()
//        options.resizeMode = PHImageRequestOptionsResizeMode.Fast
//        options.synchronous = true
//        self.phManager.requestImageForAsset(asset, targetSize: cell.recipeImage.frame.size, contentMode: PHImageContentMode.AspectFit, options: options) { (imagine, info) -> Void in
//            cell.recipeImage.image = imagine
        
        
        
//        }
        if(self.topRecipes![indexPath.row].numberOfLicks != nil){
            
            cell.nrOfLicks.text = "\(self.topRecipes![indexPath.row].numberOfLicks!)"
        }
        else{
            cell.nrOfLicks.text = "?"
        }
        
            cell.recipeName.text = topRecipes![safe: indexPath.row]!.name!
        
            self.tableView.rowHeight = 90.0
            return cell

        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
        viewController.recipe = topRecipes![safe: indexPath.row]!
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

    deinit {
        self
        debugPrint("TopRecipes deinitialized...")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
