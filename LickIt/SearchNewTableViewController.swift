//
//  SearchNewTableViewController.swift
//  LickIt
//
//  Created by MBP on 15/09/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class SearchNewTableViewController: BaseTableViewController, UISearchResultsUpdating, UIPopoverPresentationControllerDelegate {
    
    var resultSearchController : UISearchController!
    var recipes = [Recipe]()
    var isKeyboardOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = resultSearchController.searchBar
        self.tableView.delegate = self
        // Reload the table
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, 500, 50)//self.view.bounds
        
        
        
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
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if recipes.count > 0 {
            self.resultSearchController.searchBar.resignFirstResponder()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.recipes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchNewTableViewCell", forIndexPath: indexPath) as?SearchNewTableViewCell
        
        let recipe = self.recipes[indexPath.row]
        
        recipe.image!.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                //aici se intampla sfanta transormare din imagine in thumbnail
                let imagine = UIImage(data: imageData!)
                let destinationSize = cell!.imagine.frame.size
                UIGraphicsBeginImageContext(destinationSize)
                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell?.imagine.image = nouaImagine

                
            }
            
        }
        cell?.name.text = recipe.name
        cell?.licks.text = "\(recipe.numberOfLicks!)"
        
        
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row <= self.recipes.count && self.recipes.count>0){

            let viewController = storyboard!.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
            viewController.recipe = self.recipes[indexPath.row]
            
            self.resultSearchController.searchBar.resignFirstResponder()
            self.resultSearchController.active = false
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        print(indexPath.row)
    }
    
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
               //aici trebuie facuta cautarea de elemente
        if(!searchController.searchBar.text!.isEmpty){
            let manager = RecipeManager()
            manager.getSearchedRecipes(searchController.searchBar.text!, completionBlock: { (retete) -> Void in
                self.recipes = retete
                self.tableView.reloadData()
            })
        }
        
    }
    
    func hideKeyboard(buton: UIButton){
        self.resultSearchController.resignFirstResponder()
        buton.removeFromSuperview()
        self.isKeyboardOn = false
    }
    
    deinit {
        self
        print("deinitCalled")
    }
    //
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
