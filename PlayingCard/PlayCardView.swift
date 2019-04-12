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
    
    //Cannot use instance member 'createCornerLabel' within property initializer; property initializers run before 'self' is available
    // Ofcourse we are initializing a variable over here "upperLeftCornerLabel " and calling a method on myself "createCornerLabel()"
    // we know that until we are full initialized we cannot call mthods on ourself
    // so we are going to use lazy (lazy makes it so these wont be initialized until they are asked for which will be after the thing is fully initialized)
    private lazy var upperLeftCornerLabel  : UILabel   = createCornerLabel()
    private lazy var lowerRightCornerLabel   = createCornerLabel()
    
    private func createCornerLabel() -> UILabel{
        let label = UILabel()
        
        // byDefault label has 1 line ,
        // by setting it to 0 it says use as many lines as you need
        label.numberOfLines = 0
        
        //adding label as a subview on customView
        addSubview(label)
        return label
    }
    
    
    private func configureCornerLabel(_ label : UILabel){
        label.attributedText = cornerString
        
        label.frame.size = CGSize.zero
        
        //MARK:- SizeToFit Important thing to Know
 //(****)       // it will size the label to fit its content by  label.sizeToFit()
        //the only tricky thing about this is though is it if that label already has some width and you say sizeToFit, it will make it taller and keep the width.
        // we dont want that , we wanted to do the whole thing
        // so we do label.frame.size = CGSize.zero which clear out it's size before we do sizeToFit()
        //this way it will expand in both directions , across and down
        label.sizeToFit()
        
        //hide card if not faceUp
        //hidden keeps it in subviews list and everything,keeps it in right position just hides it
        label.isHidden = !isFaceUp
    }
    
    //called when our subview bounds change
    override func layoutSubviews() {
        
        //use super because UIView is awesome at laying out subviews.It uses autolayout.That all autolayout stuff UIView knows how to layout your subviews
        super.layoutSubviews()
        
        //Now this 2 subviews I am not doing any control dragging. I am creating them in code. So I have to do my layout myself and layoutSubviews is where you do it.
        //Anytime your subviews needs to be laid out for any reasons this is going to get called by the system.You dont call it
        //If you want it called you call setNeedsLayout()
        //setNeedsLayout() -> the system will eventually call this layoutSubviews() just like
        //setNeedsDisplay() -> the system will eventually call   func draw(_ rect: CGRect)
        
        configureCornerLabel(upperLeftCornerLabel)
        
        //frame is used for position
        //offsetBy(dx: cornerOffset, dy: cornerOffset) is our extension to move origin point by offset to avoid rounded corner
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        
        
        configureCornerLabel(lowerRightCornerLabel)
        
        //offsetting first to get origin inside rounded corner then offsetting to get inside by size of frame of label
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset).offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
        
        
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
        static let cornerRadiusToBoundsHeight    : CGFloat = 0.06
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
