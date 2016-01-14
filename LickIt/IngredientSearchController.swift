//
//  IngredientSearchController.swift
//  LickIt
//
//  Created by MBP on 20/05/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class IngredientSearchController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPopoverPresentationControllerDelegate, ChooseIngredientSearchCellDelegate, AKPickerViewDelegate, AKPickerViewDataSource {
    
    
    
    
    @IBOutlet weak var selectedCV: SelectedColView!
    @IBOutlet weak var chooseCV: ChooseColView!
    @IBOutlet weak var chooseIngredientsLabel: UILabel!
    weak var pickerView = AKPickerView()
    var selectedIngr = [Ingredient]()
    var chooseIngr = [Ingredient]()
    var foundRecipes = [Recipe]()
    var arrivedRecipesCheck = Int()
    var ingredientCategories = [String]()
    var categoriesColor = [UIColor]()
    var categ1 = [Ingredient]()
    var categ2 = [Ingredient]()
    var categ3 = [Ingredient]()
    var categ4 = [Ingredient]()
    var categ5 = [Ingredient]()
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        touches
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
      //  if( self.selectedIngr.count == self.arrivedRecipesCheck){
            
            var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var viewController = storyboard.instantiateViewControllerWithIdentifier("IngredientSearchResultController") as! IngredientSearchResultController
            //    viewController.ingredients = selectedIngr
            viewController.foundRecipes = self.foundRecipes
            
            
            self.navigationController?.pushViewController(viewController, animated: true)
     //   }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateIngrCategArray()
        self.pickerView = AKPickerView(frame: self.chooseIngredientsLabel.frame)
        self.pickerView!.delegate = self
        self.pickerView!.dataSource = self
        self.pickerView?.interitemSpacing = 10.0
        self.pickerView?.selectItem(1, animated: false)
        self.view.addSubview(self.pickerView!)
        
        var recipeManager = RecipeManager()
        recipeManager.getAllIngredients { (ingredients) -> Void in
            for ingr in ingredients{
                switch ingr.category! {
                case 1:
                    self.categ1.append(ingr)
                case 2:
                    self.categ2.append(ingr)
                case 3:
                    self.categ3.append(ingr)
                case 4:
                    self.categ4.append(ingr)
                default:
                    self.categ5.append(ingr)
                }
            }
            self.chooseIngr = self.categ1
            self.chooseCV.reloadData()
        }
        
        var searchButton = UIButton(frame: CGRect(x: 280, y: 0, width: 40, height: 40))
        var buttonImage = UIImage(named: "search-2-xxl")
        searchButton.setImage(buttonImage, forState: UIControlState.Normal)
        
        searchButton.addTarget(self, action: "searchButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        var menuButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = menuButtonItem
        
        checkForInternetConnection()
        
        // Do any additional setup after loading the view.
    }
    
    func populateIngrCategArray(){
        self.ingredientCategories.append("?")
        self.categoriesColor.append(UIColor.redColor())//(red: 46, green: 204, blue: 113, alpha: 1))
        self.ingredientCategories.append("obj2")
        self.categoriesColor.append(UIColor.greenColor())//(red: 241, green: 196, blue: 15, alpha: 1))
        self.ingredientCategories.append("fainoase")
        self.categoriesColor.append(UIColor.yellowColor())//(red: 230, green: 126, blue: 34, alpha: 1))
        self.ingredientCategories.append("fructe")
        self.categoriesColor.append(UIColor.blueColor())//(red: 231, green: 76, blue: 60, alpha: 1))
        self.ingredientCategories.append("legume")
        self.categoriesColor.append(UIColor.orangeColor())//(red: 155, green: 89, blue: 182, alpha: 1))
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.selectedCV.userInteractionEnabled = true
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
        println(item)
        switch item {
        case 1:
            self.chooseIngr = self.categ1
        case 2:
            self.chooseIngr = self.categ2
        case 3:
            self.chooseIngr = self.categ3
        default:
            self.chooseIngr = self.categ4
        }
        self.chooseCV.reloadData()
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let a = collectionView as? SelectedColView{
            return selectedIngr.count
        }
        else{
            return chooseIngr.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let a = collectionView as? SelectedColView{
            var cell = selectedCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchSelected", forIndexPath: indexPath) as! SelectedIngredientSearchCell
            
            selectedIngr[indexPath.item].image?.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    //aici se intampla sfanta transormare din imagine in thumbnail
                    var imagine = UIImage(data: imageData!)
                    var destinationSize = cell.image.frame.size
                    UIGraphicsBeginImageContext(destinationSize)
                    imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                    var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    cell.image.image = nouaImagine

                    cell.name = self.selectedIngr[indexPath.item].name
                }
            }
            
            return cell
        }
        else{
            var cell = chooseCV.dequeueReusableCellWithReuseIdentifier("IngredientSearchChoose", forIndexPath: indexPath) as! ChooseIngredientSearchCell
            chooseIngr[indexPath.item].image?.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    //aici se intampla sfanta transormare din imagine in thumbnail
                    var imagine = UIImage(data: imageData!)
                    var destinationSize = cell.image.frame.size
                    UIGraphicsBeginImageContext(destinationSize)
                    imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                    var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    cell.image.image = nouaImagine
                    
                    cell.name = self.chooseIngr[indexPath.item].name
                }
                
            }
            //add long tap recognizer
            cell.delegate = self
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
        
        var menuViewController = storyboard!.instantiateViewControllerWithIdentifier("PopupViewController") as! PopupViewController
        var _ = menuViewController.view
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSizeMake(100, 60)
        menuViewController.name?.text = name
        
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = cell
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, 100, 60)
        
        
        
        println(menuViewController.name?.text)
        
        presentViewController(
            menuViewController,
            animated: true,
            completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let a = collectionView as? ChooseColView{
            if(!(contains(selectedIngr, chooseIngr[indexPath.item]))){
                selectedIngr.append(chooseIngr[indexPath.item])
                selectedCV.reloadData()
                self.selectedCV.scrollToItemAtIndexPath(NSIndexPath(forItem: selectedIngr.count-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
                //cauta retete
                var recipeManager = RecipeManager()
                recipeManager.getRecipesForIngredients(self.selectedIngr, completionBlock: { (recipes) -> Void in
                    self.foundRecipes = recipes
                    self.arrivedRecipesCheck = self.selectedIngr.count
                })
                
            }
        }
        else{
            self.selectedIngr.removeAtIndex(indexPath.item)
            selectedCV.reloadData()
        }
        
        
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
