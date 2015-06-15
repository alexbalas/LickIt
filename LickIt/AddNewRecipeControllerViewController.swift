//
//  AddNewRecipeControllerViewController.swift
//  LickIt
//
//  Created by MBP on 12/06/15.
//  Copyright (c) 2015 MBP. All rights reserved.
//

import UIKit

class AddNewRecipeControllerViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var recipe: Recipe?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var categories: UITextField!
    @IBOutlet weak var chooseIngredientsButton: UIButton!
    @IBOutlet weak var cameraPicture: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed:")
        self.navigationItem.rightBarButtonItem = doneButton
        //camera button
        self.cameraPicture.addTarget(self, action: "showCamera", forControlEvents: UIControlEvents.TouchUpInside)
        //ingredient button
        self.chooseIngredientsButton.addTarget(self, action: "chooseButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }

    func chooseButtonPressed(){
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyboard.instantiateViewControllerWithIdentifier("IngredientSearchController") as IngredientSearchController
        viewController.view.backgroundColor = UIColor.yellowColor()
        viewController.navigationItem.title = "Recipe ingredients"
        //trebuie acoperit butonul de meniuri laterale
                self.navigationController?.pushViewController(viewController, animated: true)
    }
    
        
    func showCamera (){
        var camera = UIImagePickerController ()
        camera.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        camera.delegate = self
        presentViewController(camera, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("a ajuns aici")
        self.recipe?.image = PFFile(data: NSData(contentsOfFile: "image"))
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
