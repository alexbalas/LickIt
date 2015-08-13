//
//  LogInViewController.swift
//  LickIt
//
//  Created by MBP on 26/07/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit


class LogInViewController: PFLogInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //if( PFLogInSuccessNotification != nil ){
       //     self.dismissViewControllerAnimated(true, completion: { () -> Void in})
            self.navigationController?.popViewControllerAnimated(true)
        //}
        println("l=o deschis")
        var allTaps = UIEvent()
    //    logInView.facebookButton.
           
        //    self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        //self.navigationController?.popViewControllerAnimated(true)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didComeToForeGround", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        //  }
        // Do any additional setup after loading the view.
    }

    func didComeToForeGround(){
        if(( PFUser.currentUser() ) != nil){
            //self.navigationController?.popViewControllerAnimated(false)
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                
            })
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            //ar trebui apelata la fiecare fct override
        
        if(( PFUser.currentUser() ) != nil){
            //self.navigationController?.popViewControllerAnimated(false)
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                
            })
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       // self.navigationController?.popViewControllerAnimated(true)

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
