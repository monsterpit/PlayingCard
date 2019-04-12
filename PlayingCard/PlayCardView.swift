//
//  PlayCardView.swift
//  PlayingCard
//
//  Created by Boppo on 12/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class PlayCardView: UIView {


    
    private func centeredAttributedString(_ string : String,fontSize : CGFloat ) -> NSAttributedString{
        
        //using preferredFont as its an user information not like system font or anything and body font and scaling to using .withSize(fontSize)
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        
        // for dynamically adjusting font size based on accessibility
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        // NSMutableParagraphStyle for aligning to center
        // NSMutableParagraphStyle enscapsulate everything about paragraph like its alignment and things like that
        let paragraphStyle = NSMutableParagraphStyle()
        // makes whole paragraph to be centered  paragraphStyle.alignment = .center
        paragraphStyle.alignment = .center
        
        //returning NSAttributedString with attributes
        return NSAttributedString(string: string, attributes: [.font : font , .paragraphStyle : paragraphStyle])
    }


    
    override func draw(_ rect: CGRect) {
        // bounds is bounds of custom View i.e. self i.e. PlayCardView
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
    
    
    
    // apply attributed string to particular range of string i.e. 2nd to 4th character
    //    let swiftyText = "hello"
    //
    //    var objcText = NSMutableAttributedString(string: swiftyText)
    //
    //    let elRange = swiftyText.firstIndex(of: "e")!...swiftyText.firstIndex(of: "l")!
    //
    //    let nsrange = NSRange(elRange, in: swiftyText)
    //
    //
    //    let font = UIFont(name: "Helvetica", size: 12.0)
    //    let metrics = UIFontMetrics.default// or UIFontMetrics.default
    //    let fontToUse = metrics.scaledFont(for: font!)
    //
    //
    //    objcText.addAttribute(.font, value: fontToUse, range: nsrange)
    //    // objcText.addAttribute(.foregroundColor, value: UIColor.red, range: nsrange)
    //
    
    
}
