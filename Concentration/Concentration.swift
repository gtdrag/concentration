//
//  Concentration.swift
//  Concentration
//
//  Created by George Drag on 1/9/18.
//  Copyright © 2018 SuperHeadAppz. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyOneFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                // check for match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceup = true
                indexOfOneAndOnlyOneFaceUpCard = nil
            } else {
            // either no crads or 2 cards are face up
                for flipDiwnIndex in cards.indices {
                    cards[flipDiwnIndex].isFaceup = false
                }
                cards[index].isFaceup = true
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
