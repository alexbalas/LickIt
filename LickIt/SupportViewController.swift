//
//  SupportViewController.swift
//  LickIt
//
//  Created by MBP on 16/02/16.
//  Copyright © 2016 MBP. All rights reserved.
//

import UIKit
import iAd
import MediaPlayer
class SupportViewController: BaseViewController{//, UICollectionViewDelegate, UICollectionViewDataSource {

    //var collectionView = UICollectionView()
    //var results = [Int]()
    var playButton = UIButton()
    var adButton = UIButton()
    var moviePlayer = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
        
        self.playButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.playButton.setImage(UIImage(named: "playButton"), forState: UIControlState.Normal)
        self.playButton.addTarget(self, action: "playAd", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.adButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        self.adButton.setTitle("show Banner", forState: UIControlState.Normal)
        self.adButton.addTarget(self, action: "showBanner", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.adButton)
        self.view.addSubview(self.playButton)
        
        // Preload ad
        MPMoviePlayerController.preparePrerollAds()
        
        // Setup our MPMoviePlayerController
        self.moviePlayer.view.frame = self.view.bounds
        self.moviePlayer.setFullscreen(true, animated: true)
    //    self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        // Do any additional setup after loading the view.
    }
    
    func showBanner(){
        self.requestInterstitialAdPresentation()
    }

    func playAd(){
        // Add our MPMoviePlayerController to our view
        self.navigationController?.navigationBar.hidden = true
        self.view.addSubview(self.moviePlayer.view)
        
        // Path of video you want to play
        let videoURL = NSBundle.mainBundle().URLForResource("videoName", withExtension:"MOV")
        
        // Set the contents of our MPMoviePlayerController to our video path
        moviePlayer.contentURL = videoURL
        
        // Prepare our movie for playback
        moviePlayer.prepareToPlay()
        
        // Play our video with a prerolled ad
        moviePlayer.playPrerollAdWithCompletionHandler { (error) -> Void in
            if (error) != nil {
                NSLog("\(error)")
            }
            self.moviePlayer.play()
        }
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
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.results.count
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
