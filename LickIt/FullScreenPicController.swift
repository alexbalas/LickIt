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
       // self.buton.backgroundImageForState(state: UIControlState.Normal) = self.img
        if( img != nil ){
          //  self.buton.setBackgroundImage(img, forState: UIControlState.Normal)
            //self.buton.setImage(img, forState: UIControlState.Normal)
            imagine.image = img
        }
        else{
            self.imageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if !(error != nil) {
                    var imag = UIImage(data:imageData!)
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
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Wait!", style: UIBarButtonItemStyle.Plain, target: nil, action: "setBackButton:")
        }
        self.view.userInteractionEnabled = true
     //   self.buton.addTarget(self, action: "butonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if !(self.isThankYouControllerOrNot != nil){
            self.title = "delicious"
        }
        else{

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
