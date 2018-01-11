//
//  ViewController.swift
//  Concentration
//
//  Created by George Drag on 1/5/18.
//  Copyright © 2018 SuperHeadAppz. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var emojiChoices: [String]?
    var game: Concentration?
    var currentTheme: Theme?
    var themes = [Theme]()
    var currentThemeIndex = -1
    var emoji = [Int:String]()
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func startOver(_ sender: UIButton) {
        startGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber = cardButtons.index(of: sender) {
            game!.chooseCard(at: cardNumber)
            updateView()
        }
    }
    
    override func viewDidLoad() {
        //load themes here
        // TODO: load from json file?
        themes.append(Theme(color: .red, emojiSet: ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"], name: "letters"))
        themes.append(Theme(color: .green, emojiSet: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐽","🐸","🐵","🐔","🐥"], name: "animals"))
        themes.append(Theme(color: .blue, emojiSet: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🏒","🏑","🏏","⛳️","🏹","🎣","🥊","🥋","🎽"], name: "sports"))
        startGame()
    }
    
    func updateView(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game!.cards[index]
            if card.isFaceup {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme?.color
            }
        }
    }
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, self.emojiChoices!.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(self.emojiChoices!.count)))
            emoji[card.identifier] = self.emojiChoices!.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func startGame() {
        if currentThemeIndex < themes.count - 1 {
            currentThemeIndex += 1
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2 )
        currentTheme = themes[currentThemeIndex]
        emojiChoices = currentTheme?.emojiSet
        flipCount = 0
        flipCountLabel.textColor = currentTheme?.color
        for button in cardButtons {
            button.backgroundColor = currentTheme?.color
        }
        if let name = currentTheme?.name {
            titleLabel.text = "Concentration: \(name)"
        }
        updateView()
    }
}

