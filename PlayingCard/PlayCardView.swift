//
//  PlayCardView.swift
//  PlayingCard
//
//  Created by Boppo on 12/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class PlayCardView: UIView {
    
    //stub override func draw(_ rect: CGRect) is commented out because iOS looks to see you have a draw rect and if you do it makes an offScreen buffer for you and kind of preparations for you to draw and that's not cheap so if you dont actually draw in draw rect then you want it to comment it out
    // Now why would you have a UIView  or UIview subclass that doesn't have a draw rect. Well it's quite common you do all your drawing with subviews , Consider UI StackView , it does all drawing with views that are stacked inside of it.It doesn't do any actual drawing itself , it has no draw rect
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
