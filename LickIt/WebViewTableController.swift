//
//  WebViewTableController.swift
//  LickIt
//
//  Created by MBP on 15/01/16.
//  Copyright (c) 2016 MBP. All rights reserved.
//

import UIKit
import WebKit

class WebViewTableController: UITableViewController, WKNavigationDelegate{

    var count = 14
    var webView: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 14{
                return self.webView!.frame.height
        }
        else{
            return 64
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < 14{
            let cell = tableView.dequeueReusableCellWithIdentifier("ImgCell", forIndexPath: indexPath) as! TableViewCell
            cell.imagine.image = UIImage(named: "bifaVerde")
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("WebViewCell", forIndexPath: indexPath) as! WebViewTableViewCell
            cell.addSubview(self.webView!)
            
            return cell
        }
        // Configure the cell...

        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = NSURL (string: "http://allrecipes.com/recipe/222607/smothered-chicken-breasts/?internalSource=popular&referringContentType=home%20page")
        self.webView = WKWebView()//frame: self.frame)
        let req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
//        self.webView!.evaluateJavaScript("document.height") { (result, error) in
//            if error == nil {
//                print(result)
//            }
//        }
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        self.count++
        self.tableView.reloadInputViews()
    }

    deinit {
        self
        print("deinitCalled")
    }    //
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
