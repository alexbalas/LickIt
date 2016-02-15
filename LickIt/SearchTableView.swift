//
//  SearchTableView.swift
//  LickIt
//
//  Created by MBP on 01/02/16.
//  Copyright (c) 2016 MBP. All rights reserved.
//

import UIKit

protocol SearchTableViewDelegate{
    func openRecipe(recipe: Recipe)
}

class SearchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var delegat : SearchTableViewDelegate?
    var retete = [Recipe]()
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.retete.count
    }
    
//    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
//        var cell = UITableViewCell(frame: CGRect(x: 0, y: CGFloat(indexPath.row) * (self.frame.height/6), width: self.frame.width, height: self.frame.height/6))
//        var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height))
//        println("recipiz din cellforrow")
//        println(self.retete)
//        retete[indexPath.row].image?.getDataInBackgroundWithBlock {
//            (imageData: NSData?, error: NSError?) -> Void in
//            if !(error != nil) {
//                //aici se intampla sfanta transormare din imagine in thumbnail
//                var imagine = UIImage(data: imageData!)
//                var destinationSize = CGSize(width: imgView.frame.width, height: imgView.frame.height)
//                UIGraphicsBeginImageContext(destinationSize)
//                imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
//                var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                imgView.image = nouaImagine
//            }
//            
//        }
//        
//        var label = UILabel(frame: CGRect(x: imgView.frame.width+10, y: 15, width: self.frame.width - imgView.frame.width - 20, height: cell.frame.height - 30))
//        label.numberOfLines = 2
//        label.adjustsFontSizeToFitWidth = true
//        label.font = UIFont(name: "Zapfino", size: 16)
//        label.text = self.retete[indexPath.row].name
//        
//        
//        cell.addSubview(imgView)
//        cell.addSubview(label)
//        
//        return cell
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(frame: CGRect(x: 0, y: CGFloat(indexPath.row) * (self.frame.height/6), width: self.frame.width, height: self.frame.height/6))
                var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height))
                println("recipiz din cellforrow")
                println(self.retete)
                retete[indexPath.row].image?.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if !(error != nil) {
                        //aici se intampla sfanta transormare din imagine in thumbnail
                        var imagine = UIImage(data: imageData!)
                        var destinationSize = CGSize(width: imgView.frame.width, height: imgView.frame.height)
                        UIGraphicsBeginImageContext(destinationSize)
                        imagine?.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                        var nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        imgView.image = nouaImagine
                    }
        
                }
        
                var label = UILabel(frame: CGRect(x: imgView.frame.width+10, y: 15, width: self.frame.width - imgView.frame.width - 20, height: cell.frame.height - 30))
                label.numberOfLines = 2
                label.adjustsFontSizeToFitWidth = true
                label.font = UIFont(name: "Zapfino", size: 16)
                label.text = self.retete[indexPath.row].name
                
                
                cell.addSubview(imgView)
                cell.addSubview(label)
                
                return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var viewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
//        viewController.recipe = self.retete[indexPath.row]
        self.delegat?.openRecipe(self.retete[indexPath.row])
        
//        self.resultSearchController.searchBar.resignFirstResponder()
//        self.resultSearchController.active = false
//        
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
