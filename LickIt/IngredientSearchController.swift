//
//  IngredientSearchController.swift
//  LickIt
//
//  Created by MBP on 20/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

protocol IngSearchDelegate{
    func addOkButton()
}

class IngredientSearchController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPopoverPresentationControllerDelegate, ChooseIngredientSearchCellDelegate, AKPickerViewDelegate, AKPickerViewDataSource, UISearchBarDelegate {
    
    
    
    
    @IBOutlet weak var chooseCV: ChooseColView!
    
    var delegate: IngSearchDelegate?
    
    weak var pickerView = AKPickerView()
    var selectedIngr = [Ingredient]()
    var blockedIngr = [Ingredient]()
    var chooseIngr = [Ingredient]()
    var allIngredients = [Ingredient]()
    var foundRecipes = [Recipe]()
 //   var arrivedRecipesCheck = Int()
    var ingredientCategories = [String]()
    var categoriesColor = [UIColor]()
    var categ1 = [Ingredient]()
    var categ2 = [Ingredient]()
    var categ3 = [Ingredient]()
    var categ4 = [Ingredient]()
    var categ5 = [Ingredient]()
    var categ6 = [Ingredient]()
    var categ7 = [Ingredient]()
    var searchBar: UISearchBar?
    
    var bifaVerde: UIImage?
    var celuleSelectate = [ChooseIngredientSearchCell]()
    var bifaRosie: UIImage?
    var didGetToTheBlockingPhase = false
    
    var isIngredientSearch: Bool?
    var rightButtonNavigationBar = UIButton()
    var url: String?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touches
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        if self.didGetToTheBlockingPhase{
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let viewController = storyboard.instantiateViewControllerWithIdentifier("IngredientSearchResultController") as! IngredientSearchResultController
                viewController.ingredients = selectedIngr
                viewController.blockedIngredients = self.blockedIngr
           // viewController.foundRecipes = self.foundRecipes
        
        //modifici nr cautarilor - pt ACHIEVEMENTS
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("ingrSearches") as? Int{
            NSUserDefaults.standardUserDefaults().setValue(licks + 1, forKey: "ingrSearches")
            print(licks+1)
            if licks + 1 == 18{
                self.navigationController?.pushViewController(viewController, animated: true)

                showCongratzMessage()
            }
        }
        else{
            NSUserDefaults.standardUserDefaults().setValue(1, forKey: "ingrSearches")
        }
        
        
        self.navigationController?.pushViewController(viewController, animated: true)
        }
        else{
            self.didGetToTheBlockingPhase = true
            self.title = "Block Ingr."
        }
    }
    
    func showCongratzMessage(){
        let alert = UIAlertController(title: "YEEEESSSS", message: "Achievement unlocked!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction)in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Ingr."
//        self.resultSearchController = UISearchController(searchResultsController: nil)
//        resultSearchController!.searchResultsUpdater = self
//        resultSearchController!.dimsBackgroundDuringPresentation = false
//        resultSearchController!.searchBar.sizeToFit()
//        
  //      self.searchBarView = resultSearchController!.searchBar
        let fraim = CGRect(x: 0, y: 60, width: UIScreen.mainScreen().bounds.width, height: 30)
        let searchBar = UISearchBar(frame: fraim)
        searchBar.delegate = self
        self.searchBar = searchBar
       // self.searchBarView.removeFromSuperview()
        self.view.addSubview(searchBar)
  //      self.view.reloadInputViews()
  //      self.searchBarView.reloadInputViews()
     //   self.tableView.delegate = self
     //   self.searchBarView = UISearchController().searchBar
        
        populateIngrCategArray()
        let freim = CGRect(x: 0, y: 60+30, width: UIScreen.mainScreen().bounds.width, height: 30)
        self.pickerView = AKPickerView(frame: freim)
        self.pickerView!.delegate = self
        self.pickerView!.dataSource = self
        self.pickerView?.interitemSpacing = 10.0
        self.pickerView?.selectItem(1, animated: false)
        self.view.addSubview(self.pickerView!)
        
        let recipeManager = RecipeManager()
        recipeManager.getAllIngredients { (ingredients) -> Void in
            self.allIngredients = ingredients
            var i = 0
            for ingr in ingredients{
                self.allIngredients[i].indexPathInIngredientSearch = i
                i++
                switch ingr.category! {
                case 1:
                    self.categ1.append(ingr)
                case 2:
                    self.categ2.append(ingr)
                case 3:
                    self.categ3.append(ingr)
                case 4:
                    self.categ4.append(ingr)
                case 5:
                    self.categ5.append(ingr)
                case 6:
                    self.categ6.append(ingr)
                default:
                    self.categ7.append(ingr)
                }
            }
            self.chooseIngr = self.categ1
            self.chooseCV.reloadData()
            
        }
        if (self.isIngredientSearch == true){
            let searchButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.width-40, y: 0, width: 40, height: 40))
            let buttonImage = UIImage(named: "spoonandfork")
            searchButton.setImage(buttonImage, forState: UIControlState.Normal)
        
            searchButton.addTarget(self, action: "searchButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            let menuButtonItem = UIBarButtonItem(customView: searchButton)
            self.navigationItem.rightBarButtonItem = menuButtonItem
        }
        else{
            let rightMenuButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.width-50, y: 8, width: 45, height: 45))
            let image = UIImage(named: "ok")
            rightMenuButton.setImage(image, forState: UIControlState.Normal)
            rightMenuButton.addTarget(self, action: "addRecipeButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            self.rightButtonNavigationBar = rightMenuButton
            self.navigationController?.navigationBar.addSubview(rightMenuButton)
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed")
        }
        
        let right = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        right.direction = UISwipeGestureRecognizerDirection.Right
        let left = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        left.direction = UISwipeGestureRecognizerDirection.Left
        self.chooseCV.addGestureRecognizer(right)
        self.chooseCV.addGestureRecognizer(left)
        
        
        checkForInternetConnection()
        
        // Do any additional setup after loading the view.
    }
    
    func settedBackButtonPressed(){
        self.navigationController?.popViewControllerAnimated(true)
       
        self.rightButtonNavigationBar.removeFromSuperview()
        self.delegate!.addOkButton()
        
    }
    
    func addRecipeButtonPressed(){
        self.rightButtonNavigationBar.removeFromSuperview()
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("AddNewRecipeControllerViewController") as! AddNewRecipeControllerViewController
        viewController.caz = 44
        viewController.ingredients = self.selectedIngr
        viewController.url = self.url
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func swipeRight(sender: UISwipeGestureRecognizer){
        if self.pickerView?.selectedItem > 0{
            print(self.pickerView?.selectedItem)

            self.pickerView?.selectItem(self.pickerView!.selectedItem-1, animated: true)
        }
    }
    
    func swipeLeft(sender: UISwipeGestureRecognizer){
        if self.pickerView?.selectedItem < 5{
            print(self.pickerView?.selectedItem)
            self.pickerView?.selectItem(self.pickerView!.selectedItem+1, animated: true)
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.pickerView?.selectItem(0, animated: true)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var rezultate = [Ingredient]()
        for ingr in self.allIngredients{
            if let _ = ingr.name?.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: ingr.name!.startIndex..<ingr.name!.endIndex,
                locale: nil){
                rezultate.append(ingr)
            }
        }
        
        self.chooseIngr = rezultate
        self.chooseCV.reloadData()
    }
    
    func populateIngrCategArray(){
        self.ingredientCategories.append("searched")
        self.categoriesColor.append(UIColor.cyanColor())//(red: 46, green: 204, blue: 113, alpha: 1))
        self.ingredientCategories.append("vegetables")//1
        self.categoriesColor.append(UIColor.greenColor())//(red: 241, green: 196, blue: 15, alpha: 1))
        self.ingredientCategories.append("fruits")//2
        self.categoriesColor.append(UIColor.orangeColor())//(red: 230, green: 126, blue: 34, alpha: 1))
        self.ingredientCategories.append("meat")//3
        self.categoriesColor.append(UIColor.redColor())
        self.ingredientCategories.append("cereals & flour")//4
        self.categoriesColor.append(UIColor.yellowColor())//(red: 231, green: 76, blue: 60, alpha: 1))
        self.ingredientCategories.append("condiments")//5
        self.categoriesColor.append(UIColor.magentaColor())//(red: 155, green: 89, blue: 182, alpha: 1))
        self.ingredientCategories.append("dairy")//6
        self.categoriesColor.append(UIColor.whiteColor())
        self.ingredientCategories.append("drinks")//7
        self.categoriesColor.append(UIColor.grayColor())
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.chooseCV.userInteractionEnabled = true;
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.ingredientCategories.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.ingredientCategories[item]
    }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        self.pickerView?.backgroundColor = self.categoriesColor[item]
        print(item)
        
        for cell in self.celuleSelectate{
            cell.viu?.removeFromSuperview()
            cell.image.alpha = 1
        }
        self.celuleSelectate = [ChooseIngredientSearchCell]()
        
        switch item {
        case 0:
            self.chooseIngr = [Ingredient]()
        case 1:
            self.chooseIngr = self.categ1
        case 2:
            self.chooseIngr = self.categ2
        case 3:
            self.chooseIngr = self.categ3
        case 4:
            self.chooseIngr = self.categ4
        case 5:
            self.chooseIngr = self.categ5
        case 6:
            self.chooseIngr = self.categ6
        default:
            self.chooseIngr = self.categ7
        }
        self.chooseCV.reloadData()
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return chooseIngr.count + 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = chooseCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchChoose", forIndexPath: indexPath) as! ChooseIngredientSearchCell

        if indexPath.item == 0{
            cell.name = "Tap & Hold item for info"
            cell.image.image = UIImage(named: "tapandhold")
//            let label = UILabel(frame: cell.frame)
//            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
//            label.numberOfLines = 3
//            label.text = "Tap" + "&" + "Hold"
//            label.font = UIFont(name: "Zapfino", size: 10)
//            cell.addSubview(label)
            cell.delegate = self

            return cell
        }
        else{
            
         if self.bifaVerde == nil{
            let imagine = UIImage(named: "bifaVerde")
            let destinationSize = cell.image.frame.size
            UIGraphicsBeginImageContext(destinationSize)
            imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
            let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.bifaVerde = nouaImagine
            
            let img = UIImage(named: "bifaRosie")
            UIGraphicsBeginImageContext(destinationSize)
            img?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
            let nouaImg = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.bifaRosie = nouaImg
            
        }
        
            cell.name = self.chooseIngr[indexPath.item-1].name
            chooseIngr[indexPath.item-1].image?.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    //aici se intampla sfanta transormare din imagine in thumbnail
                    let imagine = UIImage(data: imageData!)
                    let destinationSize = cell.image.frame.size
                    UIGraphicsBeginImageContext(destinationSize)
                    imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                    let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    cell.image.image = nouaImagine
                  
                }
                
            }
        if self.allIngredients[chooseIngr[indexPath.item-1].indexPathInIngredientSearch].isSelected == true{
            let imgView = UIImageView(frame: cell.image.frame)
            imgView.image = self.bifaVerde
            imgView.alpha = 1
            cell.image.alpha = 0.5
            cell.viu = imgView
            cell.contentView.addSubview(imgView)
            self.celuleSelectate.append(cell)
        }
            //add long tap recognizer
            cell.delegate = self
            print(cell.frame)
            return cell
        }
    }
    func hidePopup()
    {
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            
        })   
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item>0{
        //let indx = NSIndexPath(forItem: indexPath.item, inSection: 0)
        let cell = self.chooseCV.cellForItemAtIndexPath(indexPath) as! ChooseIngredientSearchCell
        
        if !self.didGetToTheBlockingPhase{
            if(!(self.selectedIngr.contains(self.chooseIngr[indexPath.item-1]))){
                self.selectedIngr.append(chooseIngr[indexPath.item-1])
            }
            else{
                let index = self.selectedIngr.indexOf(self.chooseIngr[indexPath.item-1])
                self.selectedIngr.removeAtIndex(index!)
            }
        }
        else{
            if(!(self.blockedIngr.contains(self.chooseIngr[indexPath.item-1]))){
                self.blockedIngr.append(chooseIngr[indexPath.item-1])
            }
            else{
                let index = self.blockedIngr.indexOf(self.chooseIngr[indexPath.item-1])
                self.blockedIngr.removeAtIndex(index!)
            }
        }
        //cell.tapped()
        //selectCell(cell)
        if self.allIngredients[self.chooseIngr[indexPath.item-1].indexPathInIngredientSearch].isSelected == false{
            let imgView = UIImageView(frame: cell.image.frame)
            if self.didGetToTheBlockingPhase{
                imgView.image = self.bifaRosie
            }
            else{
                imgView.image = self.bifaVerde
            }
            imgView.alpha = 1
            cell.image.alpha = 0.5
            cell.viu = imgView
            cell.contentView.addSubview(imgView)
            self.allIngredients[self.chooseIngr[indexPath.item-1].indexPathInIngredientSearch].isSelected = true
            self.celuleSelectate.append(cell)
            
        }
        else{
            cell.viu?.removeFromSuperview()
            cell.image.alpha = 1
            self.allIngredients[self.chooseIngr[indexPath.item-1].indexPathInIngredientSearch].isSelected = false
            let index = self.celuleSelectate.indexOf(cell)
            self.celuleSelectate.removeAtIndex(index!)
        }

       // self.chooseCV.reloadInputViews()
       // cell.reloadInputViews()
        }
    }

    func selectCell(cell: ChooseIngredientSearchCell){


    }
    
    deinit {
        debugPrint("Name_of_view_controlled deinitialized...")
    }
//    func updateSearchResultsForSearchController(searchController: UISearchController)
//    {
//        //aici trebuie facuta cautarea de elemente
//        if(!searchController.searchBar.text.isEmpty){
//            var manager = RecipeManager()
//            manager.getSearchedRecipes(searchController.searchBar.text, completionBlock: { (retete) -> Void in
////                self.recipes = retete
////                self.tableView.reloadData()
//            })
//        }
//        
//    }

    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
