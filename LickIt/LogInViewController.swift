//
//  LogInViewController.swift
//  LickIt
//
//  Created by MBP on 26/07/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

//protocol LogInViewControllerDelegate {
//    func loginControllerDismissed()
//}

class LogInViewController: PFLogInViewController {

    
    var counter = 1
  //  var del: LogInViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "backButtonPressed") //= UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:"backButtonPressed:")
        //if( PFLogInSuccessNotification != nil ){
       //     self.dismissViewControllerAnimated(true, completion: { () -> Void in})
 //           self.navigationController?.popViewControllerAnimated(true)
        //}
        print("l=o deschis")
        _ = UIEvent()
    //    logInView.facebookButton.
           
        //    self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        //self.navigationController?.popViewControllerAnimated(true)
    
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didComeToForeGround", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        //  }
        // Do any additional setup after loading the view.
    }

//    func didComeToForeGround(){
//    //    if( PFUser.currentUser()?.objectId != nil){   ...cand revine prinde userul nil, chiar daca s-a logat cu succes
//       // if(self.counter == 2){
//            
////            self.del.loginControllerDismissed()
//            
////            self.dismissViewControllerAnimated(true, completion: { () -> Void in
////            })
//    //    }
//     //   self.counter++
//        
//    }
    

    func backButtonPressed(){
        
        if (PFUser.currentUser() != nil){
            self.navigationItem.rightBarButtonItem = nil
        }
        
        self.navigationController?.popViewControllerAnimated(true)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("5")
       // self.navigationController?.popViewControllerAnimated(true)

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    
 //       NSNotificationCenter.defaultCenter().removeObserver(self)
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
