//
//  BaseTableViewController.swift
//  LickIt
//
//  Created by MBP on 20/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
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
        
      
        
    
        // Do any addition//al setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        self
        print("deinitCalled")
    }
   
}
