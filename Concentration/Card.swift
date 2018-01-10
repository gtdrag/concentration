//
//  Card.swift
//  Concentration
//
//  Created by George Drag on 1/9/18.
//  Copyright © 2018 SuperHeadAppz. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceup = false
    var isMatched = false
    var identifier: Int
    
    static var identifierfactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierfactory += 1
        return identifierfactory
    }
    
    init() {
         self.identifier = Card.getUniqueIdentifier()
    }
}
