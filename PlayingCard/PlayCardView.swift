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
    
    //when we change orientation of phone
    // Unfortunately not a circle , we want it be circle , its an oval.So why did we get this? Because by default, when you change the bounds of your view it just takes the bits and scales them to the new size which sometimes that might be what you want , but a lot of times this is definitely not what you want . So how do we stop this? Well,what we want it do is to call draw rect code again when we change our bounds have this draw circle again in new space
    // changing content mode from default "scale to fill" to "redraw"
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        path.lineWidth = 5.0
        
        UIColor.green.setFill()
        
        #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).setStroke()
        
        path.stroke()
        
        path.fill()
        
    }
    
    
}
