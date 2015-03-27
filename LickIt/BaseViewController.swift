//
//  BaseViewController.swift
//  LickIt
//
//  Created by MBP on 20/03/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBAction func menuButtonPressed(sender: AnyObject) {
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        var buttonImage = UIImage(named: "MenuButton")
        menuButton.setImage(buttonImage, forState: UIControlState.Normal)
        
        menuButton.addTarget(self, action: "menuButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        var menuButtonItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = menuButtonItem
        // Do any additional setup after loading the view.
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
