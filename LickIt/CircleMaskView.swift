import Foundation
import UIKit
import CoreGraphics

/// Apply a circle mask on a target view. You can customize radius, color and opacity of the mask.
class CircleMaskView {
    
    private var fillLayer = CAShapeLayer()
    var target: UIView?
    var x : CGFloat?
    var y : CGFloat?
    var fillColor: UIColor = UIColor.grayColor() {
        didSet {
            self.fillLayer.fillColor = self.fillColor.CGColor
        }
    }
    
    var radius: CGFloat? {
        didSet {
            self.draw()
        }
    }
    
    var opacity: Float = 0.5 {
        didSet {
            self.fillLayer.opacity = self.opacity
        }
    }
    
    /**
    Constructor
    
    - parameter drawIn: target view
    
    - returns: object instance
    */
    init(drawIn: UIView) {
        self.target = drawIn
    }
    
    /**
    Draw a circle mask on target view
    */
    func draw() -> UIWindow {
//        guard (let target = target) else{
//            print("target is nil")
//            return
//        }
        
        var rad: CGFloat = 0
        let size = target!.frame.size
        if let r = self.radius {
            rad = r
        } else {
            rad = min(size.height, size.width)
        }
    
        let path = UIBezierPath(roundedRect: CGRectMake(0, 0, size.width, size.height), cornerRadius: 0.0)
        let circlePath = UIBezierPath(roundedRect: CGRectMake(self.x!,  self.y!, rad, rad), cornerRadius: rad)
        path.appendPath(circlePath)
        path.usesEvenOddFillRule = true
        
        fillLayer.path = path.CGPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = self.fillColor.CGColor
        fillLayer.opacity = self.opacity
        var currentWindow = UIApplication.sharedApplication().keyWindow
        self.target!.layer.addSublayer(fillLayer)
        currentWindow?.addSubview(self.target!)
    
        println("o fost adaugat")
        return currentWindow!
    }
    
    /**
    Remove circle mask
    */
    
    
    func remove() {
        self.fillLayer.removeFromSuperlayer()
    }
    
}