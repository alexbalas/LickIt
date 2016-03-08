//
//  AchievementsTableViewController.swift
//  LickIt
//
//  Created by MBP on 16/02/16.
//  Copyright © 2016 MBP. All rights reserved.
//

import UIKit

class AchievementsTableViewController: BaseTableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Achievements"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect(x: 0, y: CGFloat(indexPath.row) * 80, width: UIScreen.mainScreen().bounds.width, height: 80))
        
        
        let label = UILabel(frame: CGRect(x: 80+10, y: 15, width: UIScreen.mainScreen().bounds.width - 80 - 20, height: 80 - 30))
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Zapfino", size: 16)
        label.text = textForCell(indexPath.row)
        
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
                //aici se intampla sfanta transormare din imagine in thumbnail
                let imagine = imgForCell(indexPath.row)
                let destinationSize = CGSize(width: imgView.frame.width, height: imgView.frame.height)
                UIGraphicsBeginImageContext(destinationSize)
                imagine.drawInRect(CGRect(x: 0,y: 0,width: destinationSize.width,height: destinationSize.height))
                let nouaImagine = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                imgView.image = nouaImagine
        
        
        
        
        
        cell.addSubview(imgView)
        cell.addSubview(label)
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    func textForCell(caz: Int) -> String{
        switch caz{
        case 1: return "Lick 10 recipes"
        case 2: return "Lick 100 recipes"
        case 3: return "Lick 500 recipes"
        case 4: return "Save 5 recipes"
        case 5: return "Save 10 recipes"
        case 6: return "Save 20 recipes"
        case 7: return "Make 15 ingredient searches"
        default: return "Log in"
        }
    }
    
    func imgForCell(index: Int) -> UIImage{
        switch index{
        case 1: return img1()
        case 2: return img2()
        case 3: return img3()
        case 4: return img4()
        case 5: return img5()
        case 6: return img6()
        case 7: return img7()
        default: return img0()
        }
    }
    /*
    is loggedn on
    did like 10 recipes
    did like 100 recipes
    did like 500 recipes
    did saved 5 recipe
    did saved 10 recipe
    did saved 20
    
    
    
    
    did use 20 different ingredients in search
    did search 15 different times with ingredients
    
    did contribute once
    did contribute 5 times
    did contribute 10 times
    did watch 1 video
    did watch 5 videos
    did watch 15 videos
    did share a recipe
    did share 5 recipes
    did share 10 recipes
*/
    func img0()->UIImage{
        if(PFUser.currentUser() != nil){
            return UIImage(named: "loggedIn")!
        }
        else{
            return UIImage(named: "incomplete")!
        }
    }
    func img1()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("licks") as? Int{
            if licks > 9{
                return UIImage(named: "lickAchievement1")!
            }
        }
        
        return UIImage(named: "incomplete")!
    }
    func img2()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("licks") as? Int{
            if licks > 99{
                return UIImage(named: "lickAchievement2")!
            }
        }
        
        return UIImage(named: "incomplete")!
    }
    func img3()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("licks") as? Int{
            if licks > 499{
                return UIImage(named: "lickAchievement3")!
            }
        }
        
        return UIImage(named: "incomplete")!
    }
    func img4()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("saves") as? Int{
            if licks > 4{
                return UIImage(named: "saveAchievement1")!
            }
        }
        
        return UIImage(named: "incomplete")!
    }
    func img5()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("saves") as? Int{
            if licks > 9{
                return UIImage(named: "saveAchievement2")!
            }
        }
        
        return UIImage(named: "incomplete")!
    }
    func img6()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("saves") as? Int{
            if licks > 19{
                return UIImage(named: "saveAchievement3")!
            }
        }
        
        return UIImage(named: "incomplete")!
    }
    func img7()->UIImage{
        if let licks = NSUserDefaults.standardUserDefaults().valueForKey("ingrSearches") as? Int{
            if licks > 14{
                return UIImage(named: "ingrSearchAchievement")!
            }
        }
        
        return UIImage(named: "incomplete")!
        
    }
    func img8()->UIImage{
        if(NSUserDefaults.standardUserDefaults().valueForKey("") != nil){
            return UIImage(named: "")!
        }
        else{
            return UIImage(named: "incomplete")!
        }
    }
    func img9()->UIImage{
        if(NSUserDefaults.standardUserDefaults().valueForKey("") != nil){
            return UIImage(named: "")!
        }
        else{
            return UIImage(named: "incomplete")!
        }
    }
    func img10()->UIImage{
        if(NSUserDefaults.standardUserDefaults().valueForKey("") != nil){
            return UIImage(named: "")!
        }
        else{
            return UIImage(named: "incomplete")!
        }
    }
    
    deinit {
        self
        debugPrint("Achievements deinitialized...")
    }
    //
}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


