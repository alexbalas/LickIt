//
//  AddNewRecipeControllerViewController.swift
//  LickIt
//
//  Created by MBP on 12/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class AddNewRecipeControllerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var caz = -1
    @IBOutlet weak var titlu: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cameraPicture: UIButton!
    //cameraPicture e defapt butonul de ENTER

    
    var ingredients: [Ingredient]?
    var url: String?
    var imagePicker = UIImagePickerController()
    var imgView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraPicture.addTarget(self, action: "enterButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.title = "almost done"
        self.titlu.text = textForCell(caz)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed:")
        
        //add a button for uploading picture only if it's the add recipe screen
        if self.url != nil{
            let buton = UIButton(frame: CGRect(x: 10, y: self.name.frame.origin.y+60+self.name.frame.height, width: 50, height: 50))
            buton.setImage(UIImage(named: "camera"), forState: UIControlState.Normal)
            buton.addTarget(self, action: "cameraButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(buton)
            
            self.imgView = UIImageView(frame: CGRect(x: UIScreen.mainScreen().bounds.width-100, y: buton.frame.origin.y, width: 80, height: 80))
            self.view.addSubview(self.imgView)
        }
//        var rectTitlu = CGRect(x: 0, y: self.titlu.frame.origin.y+20, width: UIScreen.mainScreen().bounds.width, height: self.titlu.bounds.height)
//        self.titlu.frame = rectTitlu
//        
//        
//        
//        rectTitlu = CGRect(x: 15, y: self.name.frame.origin.y+20, width: UIScreen.mainScreen().bounds.width-30, height: self.name.frame.height)
//        self.name.frame = rectTitlu
//        
//        
//        self.view.reloadInputViews()
        // Do any additional setup after loading the view.
    }

    func cameraButtonPressed(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        self.imgView.image = image
        
    }
    
    func settedBackButtonPressed(buton: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func textForCell(caz: Int) -> String{
        switch caz{
        case 1: return "give a missing recipe name"
        case 2: return "give a missing ingredient name"
        case 3: return "feedback"
        case 44: return "Enter the recipe name:"
        default: return "insert link/webstie to recipe"
        }
    }
    
    func enterButtonPressed(){
        if self.name.text != nil{
            if self.ingredients == nil{
                sendObjectToParse()
            }
            else{
                if self.imgView.image != nil{
                    var recipe = PFObject(className: "Recipe")
                    recipe.setObject(self.name.text!, forKey: "name")
//                    var rl = recipe.relationForKey("ingredients")
//                    for ingr in self.ingredients!{
//                        let ing = PFObject(withoutDataWithClassName: "Ingredient", objectId: ingr.objectID)
//                        rl.addObject(ing)
//                        
//                    }
//                    recipe.setObject(rl, forKey: "ingredients")
                    let index = self.url!.startIndex.advancedBy(9)
                   let urele = self.url!.substringFromIndex(index) // ello
                    let txt = urele.substringToIndex(urele.endIndex.predecessor())
                    recipe.setObject(txt, forKey: "recipeDescription")
                    var img = UIImageJPEGRepresentation(self.imgView.image!, 1)//(self.imgView.image!)
                    if img?.length > 3000000 {
                        var compression = 0.9 as CGFloat
                        let maxCompression = 0.1 as CGFloat
                        let maxFileSize = 3000000
                        
                        
                        
                        while (img!.length > maxFileSize && compression > maxCompression)
                        {
                            compression -= 0.1
                            img = UIImageJPEGRepresentation(self.imgView.image!, compression);
                        }
                    }
                    
                    let file = PFFile(data: img!)
                    recipe.setObject(file, forKey: "image")
                    
                    let friendsRelation: PFRelation = recipe.relationForKey("ingredients")
                    for ingr in self.ingredients!{
                        friendsRelation.addObject(ingr.parseObject!)
                    }
                    //save
                    self.navigationController?.navigationBar.hidden = true
                    let viu = UIView(frame: UIScreen.mainScreen().bounds)
                    let culoare = UIColor(white: 1, alpha: 0.8)
                    self.view.addSubview(viu)
                    view.backgroundColor = culoare
                    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
                    activityIndicator.frame = CGRectMake(100, 100, 100, 100);
                    activityIndicator.startAnimating()
                    self.view.addSubview( activityIndicator )
                    recipe.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                        if !(error != nil){
                            // Show success message
                            print("succes")
                            activityIndicator.stopAnimating()
                            self.showThankYouScreen()
                            
                          //  self.createRelation(self.ingredients!, recipeID: recipe.objectId!)
                            
                        }
                        else{
                            print("failure")
                            self.showError("Something went wrong. Try again please")
                        }
                    }

                }
                else{
                    showAlert()
                }
                
            }
        }
        else{
            showError("The field can't be empty")
        }
    }
    


    func showThankYouScreen(){
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("FullScreenImageController") as! FullScreenPicController
        viewController.img = UIImage(named: "thankyou")
        viewController.nume = "You can search for it :)"
        viewController.isThankYouControllerOrNot = true
        //    viewController.titlu.text = textForCell(indexPath.row)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Please select a picture", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction)in
            print("User click Close button")
            // alert.removeFromParentViewController()
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    
    func showError(mesaj: String){
            let alert = UIAlertController(title: "Error", message: mesaj, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction)in
                print("User click Close button")
                alert.dismissViewControllerAnimated(true, completion: nil)
                
            }))
        
            self.presentViewController(alert, animated: true, completion: nil)
        }
    
    func sendObjectToParse(){
        
        // Create PFObject with recipe information

        let mesaj = PFObject(className: "UserMessage")
        mesaj.setObject(self.titlu.text!, forKey: "message")
        mesaj.setObject(self.caz, forKey: "type")

        
//        // Show progress
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.labelText = @"Uploading";
//        [hud show:YES];
        
        mesaj.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if !(error != nil){
                // Show success message
                print("succes")
                let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("FullScreenImageController") as! FullScreenPicController
                viewController.img = UIImage(named: "thankyou")
                viewController.nume = "We will make it available soon :)"
                viewController.isThankYouControllerOrNot = true
                //    viewController.titlu.text = textForCell(indexPath.row)
                
                self.navigationController?.pushViewController(viewController, animated: true)

            }
            else{
                print("failure")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self
        print("deinitCalled")
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
