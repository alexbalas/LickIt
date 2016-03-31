//
//  PopupViewController.swift
//  LickIt
//
//  Created by MBP on 22/09/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController{

    
    @IBOutlet weak var name: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self
        print("deinitCalled")
    }
    //
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
