//
//  BaseViewController.swift
//  LickIt
//
//  Created by MBP on 20/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit
import CoreGraphics

class BaseViewController: UIViewController{//,LogInViewControllerDelegate {

    @IBAction func menuButtonPressed(sender: AnyObject) {
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIButton(frame: CGRect(x: 3, y: 7, width: 50, height: 50))
        let buttonImage = UIImage(named: "chef")
        menuButton.setImage(buttonImage, forState: UIControlState.Normal)
        
        menuButton.addTarget(self, action: "menuButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        let backButtonView = UIView(frame: menuButton.frame)
        backButtonView.bounds = CGRectOffset(backButtonView.bounds, 13, 11)
        backButtonView.addSubview(menuButton)
         let menuButtonItem = UIBarButtonItem(customView: backButtonView)

        
        self.navigationItem.leftBarButtonItem = menuButtonItem
        
        //aici era setat intitial butonul de login din dreapta sus
        
        
        
        
        // Do any additional setup after loading the view.
    }


    
//    func loginControllerDismissed() {
////        var viewController = sideMenuViewController
////        var ll = SideMenuViewController()
//   //     ll.tableView(ll.tableView, didSelectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 1))
//        //viewController.presentViewController(<#viewControllerToPresent: UIViewController#>, animated: <#Bool#>, completion: <#(() -> Void)?##() -> Void#>)
//   //     self.dismissViewControllerAnimated(false, completion: { () -> Void in
//            
//  //      })
//
//    }
    
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
