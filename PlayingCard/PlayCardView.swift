//
//  PlayCardView.swift
//  PlayingCard
//
//  Created by Boppo on 12/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class PlayCardView: UIView {

    

    override func draw(_ rect: CGRect) {
        // bounds is bounds of custom View i.e. self i.e. PlayCardView
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        //But we wont get to see white rounded corner as background color of view is white and we have to make it clear to make it see through and turn opaque off as it is by default is turned on for performance as it is assumed that you dont have any see through parts, no transparency  and it can be more efficient when it draws.So if we do use transparency which is less efficient but we need it here as we want our corners to show through. we have to turn opaque off if you are going to do anything transparent in your view
        //Done in storyboard
    }
    
    
}
