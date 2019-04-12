//
//  PlayCardView.swift
//  PlayingCard
//
//  Created by Boppo on 12/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class PlayCardView: UIView {
    
//drawing some cards with subviews and drawing some with drawRect
    
    //and whenever system needs to draw our custom view it will use draw(_ rect: CGRect)
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //drawing circle using coregraphics , in core graphics we always get the context first
        //we cant draw in core graphics without a context and we get that using UIGraphicsGetCurrentContext()
        //UIGraphicsGetCurrentContext could return nil but it will never return nil insidde your drawRect it might return nil in other contexts but in draw(_ rect: CGRect) it will always return
        if let context = UIGraphicsGetCurrentContext(){
            
            // bounds gives rectangles that specifies the drawing area
            //start angle and end angle are in radians not 0 to 360, its radians 0 to 2 pi
            // 0 is off to the right 0 is not straight up
            //2 * CGFloat.pi  back to same place i.e. like 360 degrees
            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            
            // line width
            context.setLineWidth(5)
            
            UIColor.green.setFill()
            
            #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).setStroke()
            
            //It wont stroke and fill the reason for that is when we draw in an context , it's actually slightly different than using that UIBezierPath
            //In context when we do strokePath like this it consumes the path. It uses up the path
            //so when we do the fillPath on the next line , there's no path. We have to start again
            // so thats the one of the biggest advantage of UIBezierPath
            context.strokePath()
            
            context.fillPath()
        }
        
        
    }


}
