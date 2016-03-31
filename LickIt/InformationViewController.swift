//
//  InformationViewController.swift
//  LickIt
//
//  Created by MBP on 18/02/16.
//  Copyright © 2016 MBP. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    var titlu = UILabel()
    var descriere = UILabel()
    var didGetToStep = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        
        let screen = UIScreen.mainScreen().bounds
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: screen.width, height: (screen.height-100)/7))
        print((screen.height-100)/7)
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 35)
        
        label.textAlignment = NSTextAlignment.Center
        self.titlu = label
        self.view.addSubview(self.titlu)
        
        var label2 = UILabel(frame: CGRect(x: 20, y: 20+self.titlu.frame.height, width: screen.width-40, height: screen.height-20-self.titlu.frame.height-10))
        label2.numberOfLines = 5
        label2.font = UIFont(name: "ChalkboardSE-Light", size: 20)
        label2.textAlignment = NSTextAlignment.Left
        self.descriere = label2
        self.view.addSubview(label2)
        nextButtonPressed()
        
        let imagine = UIImage(named: "next")
        
        let destinationSize = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContext(destinationSize)
        imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
        let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: nouaImagine, style: UIBarButtonItemStyle.Plain, target: self, action: "nextButtonPressed")
        
        // Do any additional setup after loading the view.
    }
    
    func nextButtonPressed(){
        
        
        switch self.didGetToStep{
        case 0: showText("Find the website of your desired recipe")
        case 1: showText("Select the ingredients needed to cook the recipe and also save an image to be representative for it (by tap and hold on it -> save)")
        case 2: showText("Give it a name and add the saved picture :) that's all!")
        case 3: openBrowserController()
        default: break
        }
    }
    
    func showText(text: String){
        self.didGetToStep += 1
        self.titlu.text = "Step " + "\(self.didGetToStep)"
        self.descriere.text = text
    }

    func openBrowserController(){
        let controller = BrowserController()
        self.navigationController?.pushViewController(controller, animated: true)

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
