//
//  ThankYouViewController.swift
//  LickIt
//
//  Created by MBP on 15/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class ThankYouViewController: BaseViewController {

    var recipe : Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.frame = CGRectMake(100, 100, 100, 100);
        activityIndicator.startAnimating()
        self.view.addSubview( activityIndicator )
        
        let manager = RecipeManager()
        manager.addRecipeToParse(self.recipe, completionBlock: { (success) -> Void in
            if(success){
                activityIndicator.stopAnimating()
            }
        })

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
