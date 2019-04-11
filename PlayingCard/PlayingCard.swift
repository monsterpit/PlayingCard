//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by MB on 4/11/19.
//  Copyright © 2019 MB. All rights reserved.
//

import Foundation

struct PlayingCard{
    
    var suit : Suit
    var rank : Rank

    // raw values in enum , it turns out that you can associate a fixed constant raw value for every one of your cases.Swift will even do some of this automatically .
    //e.g.
    //    enum Suit : Int{
    //        case spades
    //        case hearts
    //        case diamonds
    //        case clubs
    //    }
    //    will make Suit raw value start from 0 i.e spades = 0, hearts = 1 , diamaonds = 2 , clubs = 3 so it goes in order the "lexical order" which appears in the file. if string "spades"
    // why would you want raw value mostly for backwards compatibility with Objective C enums
    // because in Obj C enums were essentially ints , 0,1,2,3.... so the raw value is raw value int
    // but could imagine it might be interesting if there is some piece of data that it makes sense to associate with all the cases. And again it has be fixed and constant and unique. For all the cases
    enum Suit : String {
        case spades    = "♠"
        case diamonds  = "♦"
        case hearts    = "♥"
        case clubs     = "♣"
    }
    enum Rank{
        
    }
    
}
