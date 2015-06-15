//
//  FullScreenPicController.swift
//  LickIt
//
//  Created by MBP on 12/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class FullScreenPicController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var img: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = self.img
        
        self.view.userInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("touches began")
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("touches ended")
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
