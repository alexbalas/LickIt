//
//  WebViewTableViewCell.swift
//  LickIt
//
//  Created by MBP on 15/01/16.
//  Copyright (c) 2016 MBP. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewDelegate{
    func showSavingErrorAlert(cell: WebViewTableViewCell)
}

class WebViewTableViewCell: UITableViewCell, WKNavigationDelegate {
   
    var delegate : WebViewDelegate!
    
    var webView = WKWebView()
    var labelOfCell = UILabel()
    var site = String()
    var isSavedRecipe = false
   
    var containerView = UIView()
    var hasFinishedNavigation = false
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        showLabel()
        
        //load website e chemat in controller, dupa crearea celulei, ca site-ul sa poate ajunga inainte
        //altfel la initializarea celulei va incerca sa incarce site-ul = inexistent


        // Initialization code
    }
    
    func loadWebsite(recipeName: String){
        
        let rect = UIScreen.mainScreen().bounds
        self.webView = WKWebView(frame: CGRect(x: 0 , y: 0, width: rect.width, height: rect.height-84))
        self.webView.navigationDelegate = self
        
        if hasInternetConnection(){
            let url = NSURL(string: self.site)
            print(self.site)
            let request = NSURLRequest(URL: url!)
            print(request)
            self.webView.loadRequest(request)
        }
        else{//nu are conexiune
            if self.isSavedRecipe{
                let html = NSUserDefaults.standardUserDefaults().valueForKey(recipeName) as! String
                self.webView.loadHTMLString(html, baseURL: nil)
                
            }
        }
        //self.site are ba site-ul efectiv, ba html-ul in functie de caz
         
    }
    
    func hasInternetConnection() -> Bool {
        let checker = Reachability.isConnectedToNetwork()
        if checker == false{
            return false
        }
        return true
    }
    
    
     //disable tap
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .LinkActivated{
            
            decisionHandler(.Cancel)
            
        }
        else{
            decisionHandler(.Allow)
        }
    
    }
    
    
   
    
   
    
    func showRecipeWebsite(){
        hideLabel()
        self.contentView.addSubview(self.webView)
    }
    

    func hideRecipeWebsite(){
        self.webView.removeFromSuperview()
        
        showLabel()
    }
    func showLabel(){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 90))//UILabel(frame: self.contentView.frame)
        label.numberOfLines = 3
        if hasInternetConnection(){
            label.text = "-> see recipe info <-"
        }
        else{
            label.text = "no internet connection\n" + "tap for basic info"
            
        }
        
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "BradleyHandITCTT-Bold", size: 25)
        self.labelOfCell = label
        self.contentView.addSubview(self.labelOfCell)
        
        //de aici ii testing, de deletat
//        let img = UIImage.gifWithName("lick")
//        let imgViu = UIImageView(image: img)
//        imgViu.frame = CGRectMake(0, 0, 60, 60)
//      //  self.containerView.addSubview(imgViu)
    }
    func hideLabel(){
        self.labelOfCell.removeFromSuperview()
        
    }
    
    func saveRecipe(recipe: Recipe){

        if let url = NSURL(string: recipe.recipeDescription!) {
            let content = try? NSString(contentsOfURL: url, usedEncoding: nil)
            print(content)
            if let html = content{
                recipe.htmlString = html as String
                NSUserDefaults.standardUserDefaults().setValue(html, forKey: recipe.name!)
                NSUserDefaults.standardUserDefaults().synchronize()
                
                
                recipe.parseObject?.pinInBackgroundWithName(recipe.name!)
            }
            else{
                self.delegate.showSavingErrorAlert(self)
            }
            
        } else {
            // the URL was bad!
            
        }
        
        
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print(self.site)
        self.hasFinishedNavigation = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.mainScreen().scale)
    
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        
        // old style: layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(image)
        print(self)
        print(self.frame)
        return image
    }
}
