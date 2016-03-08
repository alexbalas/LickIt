//
//  PartialTransparentMaskView.swift
//  LickIt
//
//  Created by MBP on 07/01/16.
//  Copyright (c) 2016 MBP. All rights reserved.
//

import Foundation

class PartialTransparentMaskView: UIView{
    var transparentRects: Array<CGRect>?
    var transparentCircles: Array<CGRect>?
    weak var targetView: UIView?
    
    init(frame: CGRect, backgroundColor: UIColor?, transparentRects: Array<CGRect>?, transparentCircles: Array<CGRect>?, targetView: UIView?) {
        super.init(frame: frame)
        
        if((backgroundColor) != nil){
            self.backgroundColor = backgroundColor
        }
        
        self.transparentRects = transparentRects
        self.transparentCircles = transparentCircles
        self.targetView = targetView
        self.opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        
        // clear the background in the given rectangles
        if let rects = transparentRects {
            for aRect in rects {
                
                let holeRectIntersection = CGRectIntersection( aRect, rect )
                
                UIColor.clearColor().setFill();
                UIRectFill(holeRectIntersection);
            }
        }
        
        if let circles = transparentCircles {
            for aRect in circles {
                
                let holeRectIntersection = aRect
                
                let context = UIGraphicsGetCurrentContext();
                
                if( CGRectIntersectsRect( holeRectIntersection, rect ) )
                {
                    CGContextAddEllipseInRect(context, holeRectIntersection);
                    CGContextClip(context);
                    CGContextClearRect(context, holeRectIntersection);
                    CGContextSetFillColorWithColor( context, UIColor.clearColor().CGColor)
                    CGContextFillRect( context, holeRectIntersection);
                }
            }
        }
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent:event);
        
        if view == self && self.targetView != nil {
            return self.targetView;
        }
        
        return view;
    }
}