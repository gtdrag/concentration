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
    var flipCount: Int
    var score: Int
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                // check for match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].hasBeenFlipped {
                        score -= 1
                    }

                }
                cards[index].isFaceup = true
                cards[index].hasBeenFlipped = true
                indexOfOneAndOnlyOneFaceUpCard = nil
                
            } else {
            // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceup = false
                }
                cards[index].isFaceup = true
                cards[index].hasBeenFlipped = true
                indexOfOneAndOnlyOneFaceUpCard = index

            }
        }
        
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        flipCount = 0
        score = 0
        cards.shuffle()
    }
}
