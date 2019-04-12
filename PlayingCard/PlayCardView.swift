//
//  PlayCardView.swift
//  PlayingCard
//
//  Created by Boppo on 12/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class PlayCardView: UIView {
    
    
    //but rank and suit where enum in model , but who care's this is a view it knows nothing about that model , this is a generic card drawing view.It knows nothing about that particular model
    //So fact it represents rank and suit in completely different way perfectly fine
    // whose job is it to translate model and view ofcourse controller
    
    //when you have var's in view that effect the view will draw you have to think about the fact if this changes the rank your view needs to redraw itself so  we will use didSet
    
    // setNeedsDisplay will cause drawRect called eventually
    // so cant call drawRect directly we have to tell system we need to be displayed
    
    //Our view has anaother little thing that needs to happen. We have subviews to draw our part of view, so we need to have those subviews laid out.
    //Now we are not using Auto Layout in our subviews we are putting them where they belong in the corners,but we still need to say "setNeedsLayout()"
    // So our subviews can get laid out.Now you don't have to say this if you dont have any subviews that needs laying out or that aren't affected by the rank changing.In our case it definitely change the rank. So we are going to do that for all public vars here because if public change any of these things it's going to change the way our card looks
    var rank : Int = 5 {didSet{setNeedsDisplay(); setNeedsLayout()}}
    var suit : String = "♥️" {didSet{setNeedsDisplay(); setNeedsLayout()}}
    var isFaceUp : Bool = true {didSet{setNeedsDisplay(); setNeedsLayout()}}
    
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
    
    private var cornerString : NSAttributedString{
        return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        // bounds is bounds of custom View i.e. self i.e. PlayCardView
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
    
    
    

    
    
    
}


extension PlayCardView{
    // we make a private struct we put it a name sometime we call it constants we called it SizeRatio because all of our constant are about ratio
    //Constants are declared in private struct with static variables
    private struct SizeRatio{
        static let cornerFontSizeToBoundsHeight  : CGFloat = 0.085
        static let cornerRadiusToBoundsHeight    : CGFloat = 0.6
        static let cornerOffsetToCornerRadius    : CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize : CGFloat = 0.75
    }
    
    //computed property
    
    // bounds.size.height gives the bounds height
    private var cornerRadius : CGFloat {return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight}
    
    private var cornerOffset : CGFloat {return cornerRadius * SizeRatio.cornerOffsetToCornerRadius}
    
    private var cornerFontSize : CGFloat {return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight}
    
    private var rankString : String{
        switch rank{
        case 1      : return "A"
        case 2...10 : return String(rank)
        case 11     : return "J"
        case 12     : return "Q"
        case 13     : return "K"
        default     : return "?"
        }
    }
}

extension CGRect{
    var leftHalf : CGRect{
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf : CGRect{
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size : CGSize) -> CGRect{
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func zoom(by scale: CGFloat) -> CGRect{
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2)
    }
}

extension CGPoint{
    func offsetBy(dx : CGFloat,dy : CGFloat) -> CGPoint{
        return CGPoint(x: x+dx, y: y+dy)
    }
}
