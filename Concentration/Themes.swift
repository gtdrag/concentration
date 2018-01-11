//
//  Themes.swift
//  Concentration
//
//  Created by George Drag on 1/11/18.
//  Copyright © 2018 SuperHeadAppz. All rights reserved.
//

import Foundation
import UIKit


struct Theme {
    var color: UIColor
    var emojiSet: [String]
    var name: String
    
    init(color: UIColor, emojiSet: [String], name: String) {
        self.color = color
        self.emojiSet = emojiSet
        self.name = name
    }
}
