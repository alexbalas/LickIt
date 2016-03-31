import UIKit
import WebKit

let kHEADERHEIGHT : CGFloat = 60.0
let kFOOTERHEIGHT : CGFloat = 44.0

class BrowserController: UIViewController, WKNavigationDelegate, UISearchBarDelegate, IngSearchDelegate {
    
    var webView : WKWebView = WKWebView()
    var headerView : UIView = UIView()
    var footerView : UIView = UIView()
    var leftArrowButton = UIButton()
    var rightArrowButton = UIButton()
   // var listButton = UIButton()
    var urlField = UISearchBar()
    var rightButtonNavigationBar = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlField = UISearchBar(frame: CGRect(x: 57, y: 15, width: UIScreen.mainScreen().bounds.width-120, height: 40))
        urlField.delegate = self
            //UITextField(frame: CGRect(x: 50, y: 15, width: UIScreen.mainScreen().bounds.width-100, height: 40))
//        urlField.clearButtonMode = UITextFieldViewMode.WhileEditing
//        urlField.keyboardType = UIKeyboardType.URL
//        urlField.returnKeyType = UIReturnKeyType.Go
//        urlField.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(urlField)
        //left button on navigation bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "settedBackButtonPressed")

        //right button on navigation bar
        addOkButton()
//        let rightMenuButtonItem = UIBarButtonItem(customView: rightMenuButton)
//        self.navigationItem.rightBarButtonItem = rightMenuButtonItem
        

        
        //de aici e webview-ul
        webView.allowsBackForwardNavigationGestures = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.headerView.backgroundColor = UIColor.grayColor()
        self.footerView.backgroundColor = UIColor.grayColor()
        
        // Image set
        self.leftArrowButton.setImage(UIImage(named: "leftarrow"), forState: .Normal)
        self.leftArrowButton.addTarget(self, action: "back:", forControlEvents: .TouchUpInside)
        self.rightArrowButton.setImage(UIImage(named: "rightarrow"), forState: .Normal)
        self.rightArrowButton.addTarget(self, action: "forward:", forControlEvents: .TouchUpInside)
        
//        self.listButton.setTitle("History", forState: .Normal)
//        self.listButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        
//        self.listButton.addTarget(self, action: "history:", forControlEvents: .TouchUpInside)
//        
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.webView)
        self.view.addSubview(self.footerView)
        self.view.addSubview(self.leftArrowButton)
        self.view.addSubview(self.rightArrowButton)
     //   self.view.addSubview(self.listButton)
        
        self.webView.navigationDelegate = self
        self.webView .loadRequest(NSURLRequest(URL: NSURL(string: "http://google.com.sg")!))
    }
    
    func nextButtonPressed(){
        self.urlField.removeFromSuperview()
        self.rightButtonNavigationBar.removeFromSuperview()
        let url = "\(self.webView.URL)"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("IngredientSearchController") as! IngredientSearchController
        viewController.isIngredientSearch = false
        viewController.url = url
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
        //go to choose ingr
    }
    
    func addOkButton(){
        let rightMenuButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.width-50, y: 8, width: 45, height: 45))
        let image = UIImage(named: "ok")
        rightMenuButton.setImage(image, forState: UIControlState.Normal)
        rightMenuButton.addTarget(self, action: "nextButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.rightButtonNavigationBar = rightMenuButton
        self.navigationController?.navigationBar.addSubview(rightMenuButton)
    }
    
    func textFieldShouldReturn(textField: UITextField)  -> Bool {
        urlField.resignFirstResponder()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlField.text!)!))
        return false
    }
    
    func settedBackButtonPressed(){
        self.navigationController?.popViewControllerAnimated(true)
        self.urlField.removeFromSuperview()
        self.rightButtonNavigationBar.removeFromSuperview()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        self.headerView.frame = CGRectMake(0, statusBarHeight, self.view.frame.size.width, kHEADERHEIGHT)
        self.webView.frame = CGRectMake(0, statusBarHeight+kHEADERHEIGHT, self.view.frame.size.width, self.view.frame.size.height - (statusBarHeight+kHEADERHEIGHT) - kFOOTERHEIGHT)
        self.footerView.frame = CGRectMake(0, self.view.frame.size.height - kFOOTERHEIGHT, self.view.frame.size.width, kFOOTERHEIGHT)
        
        self.leftArrowButton.frame = CGRectMake(5, self.view.frame.size.height - kFOOTERHEIGHT, kFOOTERHEIGHT, kFOOTERHEIGHT)
        
        self.rightArrowButton.frame = CGRectMake(10 + kFOOTERHEIGHT, self.view.frame.size.height - kFOOTERHEIGHT, kFOOTERHEIGHT, kFOOTERHEIGHT)
        
    //    self.listButton.frame = CGRectMake(self.view.frame.size.width - 85, self.view.frame.size.height - kFOOTERHEIGHT, 80, kFOOTERHEIGHT)
    }
    
    // MARK: WKNavigationDelegate
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("Start")
    }
    
    func webView(webView: WKWebView!, didFailNavigation navigation: WKNavigation!, withError error: NSError!) {
        NSLog("Failed Navigation %@", error.localizedDescription)
    }
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        // Finish navigation
        NSLog("Finish Navigation")
        NSLog("Title:%@ URL:%@", webView.title!, webView.URL!)
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        showAlert()

    }
    
    // MARK: UI Event
//    func history(sender: AnyObject) {
//        var list : WKBackForwardList = self.webView.backForwardList
//        
//        if (list.backItem != nil) {
//            NSLog("Back %@", list.backItem!.URL)
//        }
//        if (list.forwardItem != nil) {
//            NSLog("Forward %@", list.forwardItem!.URL)
//        }
//    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        hideKeyboard()
        var txt = searchBar.text
        if ((txt?.containsString("www.")) != true){
            txt = "www." + txt!
        }
        if ((txt?.containsString("http://")) != true){
            txt = "http://" + txt!
        }
   //     if validateUrl(txt!){
            let candidateURL = NSURL(string: txt!)
            let req = NSURLRequest(URL: candidateURL!)
            self.webView.loadRequest(req)
     //   }
       // else{
         //   showAlert()
        //}
    }
    
    

    func validateUrl (stringURL : NSString) -> Bool {
        
        var urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        var urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluateWithObject(stringURL)
    }
    
    
    func showAlert(){
            let alert = UIAlertController(title: "Error", message: "link is invalid", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler:{ (ACTION :UIAlertAction)in
                print("User click Close button")
                // alert.removeFromParentViewController()
                alert.dismissViewControllerAnimated(true, completion: nil)
                
            }))
        
            self.presentViewController(alert, animated: true, completion: nil)
        

    }
    
    func hideKeyboard(){

        self.urlField.resignFirstResponder()
    }

    func back(sender: AnyObject) {
        if (self.webView.canGoBack) {
            self.webView.goBack()
        }
    }
    
    func forward(sender: AnyObject) {
        if (self.webView.canGoForward) {
            self.webView.goForward()
        }
    }
    
    deinit {
        self
        print("deinitCalled")
    }
    //
}