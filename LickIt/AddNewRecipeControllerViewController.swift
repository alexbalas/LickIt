//
//  AddNewRecipeControllerViewController.swift
//  LickIt
//
//  Created by MBP on 12/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class AddNewRecipeControllerViewController: UIViewController{

    var caz = -1
    @IBOutlet weak var titlu: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cameraPicture: UIButton!
    //cameraPicture e defapt butonul de ENTER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraPicture.addTarget(self, action: "enterButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.title = "almost done"
        self.titlu.text = textForCell(caz)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed:")
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

    func settedBackButtonPressed(buton: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textForCell(caz: Int) -> String{
        switch caz{
        case 1: return "give a missing recipe name"
        case 2: return "give a missing ingredient name"
        default: return "insert link/webstie to recipe"
        }
    }
    
    func enterButtonPressed(){
        if self.name.text != nil{
            sendObjectToParse()
        }
        else{
            showError()
        }
    }
    
    func showError(){
            var alert = UIAlertController(title: "Error", message: "The field can't be empty", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction!)in
                println("User click Close button")
                alert.dismissViewControllerAnimated(true, completion: nil)
                
            }))
        
            self.presentViewController(alert, animated: true, completion: nil)
        }
    
    func sendObjectToParse(){
        
        // Create PFObject with recipe information

        var mesaj = PFObject(className: "UserMessage")
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
                println("succes")
                var viewController = self.storyboard!.instantiateViewControllerWithIdentifier("FullScreenImageController") as! FullScreenPicController
                viewController.img = UIImage(named: "thankyou")
                viewController.nume = "We will make it available soon :)"
                viewController.isThankYouControllerOrNot = true
                //    viewController.titlu.text = textForCell(indexPath.row)
                
                self.navigationController?.pushViewController(viewController, animated: true)

            }
            else{
                println("failure")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
