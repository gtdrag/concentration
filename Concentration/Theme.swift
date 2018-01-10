//
//  Theme.swift
//  Concentration
//
//  Created by George Drag on 1/10/18.
//  Copyright © 2018 SuperHeadAppz. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    var themeName: String
    var cardColor: UIColor
    var emojiSet: [String]
    
    init(themeName: String, cardColor: UIColor, emojiSet: Array<String>) {
        self.themeName = themeName
        self.cardColor = cardColor
        self.emojiSet = emojiSet
    }
}

