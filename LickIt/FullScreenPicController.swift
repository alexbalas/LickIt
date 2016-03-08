//
//  FullScreenPicController.swift
//  LickIt
//
//  Created by MBP on 12/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class FullScreenPicController: UIViewController {

    @IBOutlet weak var imagine: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var isThankYouControllerOrNot: Bool?
    var nume: String?
    var img: UIImage?
    var imageFile: PFFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var img = UIImage.gifWithName("lick")
//        var imgViu = UIImageView(image: img)
//        imgViu.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
//        self.view.addSubview(imgViu)
        
        if( img != nil ){
          //  self.buton.setBackgroundImage(img, forState: UIControlState.Normal)
            //self.buton.setImage(img, forState: UIControlState.Normal)
            imagine.image = img
        }
        else{
            self.imageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    let imag = UIImage(data:imageData!)
                   // self.buton.setBackgroundImage(imag, forState: UIControlState.Normal)
                   // self.buton.setImage(self.img, forState: UIControlState.Normal)
                    self.imagine.image = imag
                }
            }

        }
        if(self.nume != nil){
            self.name.text = self.nume
        }
        if self.isThankYouControllerOrNot != nil{
            self.navigationController?.navigationBar.hidden = false
            self.name.numberOfLines = 1
        }
        self.view.userInteractionEnabled = true
        
        if (self.isThankYouControllerOrNot == true){
            let menuButton = UIButton(frame: CGRect(x: 3, y: 7, width: 50, height: 50))
            let buttonImage = UIImage(named: "chef")
            menuButton.setImage(buttonImage, forState: UIControlState.Normal)
            
            menuButton.addTarget(self, action: "menuButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            let backButtonView = UIView(frame: menuButton.frame)
            backButtonView.bounds = CGRectOffset(backButtonView.bounds, 13, 11)
            backButtonView.addSubview(menuButton)
            let menuButtonItem = UIBarButtonItem(customView: backButtonView)
            
            
            self.navigationItem.leftBarButtonItem = menuButtonItem
        }
        else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed:")
        }

        
     //  self.buton.addTarget(self, action: "butonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    func menuButtonPressed(){
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    func settedBackButtonPressed(buton: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        if !(self.isThankYouControllerOrNot != nil){
            self.title = "delicious"
        }
        else{
            self.title = "Thank you master!"
        }
    }
    func butonPressed(){
        
    }

    func setBackButton(buton: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        debugPrint("Name_of_view_controlled deinitialized...")
    }
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        println("touches began")
//    }
//    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        println("touches ended")
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
