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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func startOver(_ sender: UIButton) {
        startGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game!.chooseCard(at: cardNumber)
            updateView()
        }
    }
    
    override func viewDidLoad() {
        // TODO: load from json file?
        themes.append(Theme(color: .red, emojiSet: ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"], name: "letters"))
        themes.append(Theme(color: .green, emojiSet: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐽","🐸","🐵","🐔","🐥"], name: "animals"))
        themes.append(Theme(color: .blue, emojiSet: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🏒","🏑","🏏","⛳️","🏹","🎣","🥊","🥋","🎽"], name: "sports"))
        themes.append(Theme(color: .brown, emojiSet: ["🍏","🍎","🍐","🍊","🍇","🍉","🍌","🍋","🍓","🍈","🍒","🍑","🥥","🍍","🥝","🍅"], name: "fruits"))
        themes.append(Theme(color: .orange, emojiSet: ["🍗","🍟","🍔","🥩","🥓","🌭","🍕","🌮","🌯","🍤","🍦","🍩","🍪","🍺","🥃","🍸"], name: "fun foods"))
        themes.append(Theme(color: .yellow, emojiSet: ["⌚️","📱","📲","💻","🖱","🖨","🖥","⌨️","🖲","🕹","💽","💾","💿","📀","📠","📹"], name: "tech objects"))
        themes.shuffle()
        startGame()
    }
    
    func updateView(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game!.cards[index]
            if card.isFaceup {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.isEnabled = false
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme?.color
                button.isEnabled = !card.isMatched
            }
        }
        scoreLabel.text = "Score: \(game!.score)"
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
        } else {
            themes.shuffle()
            currentThemeIndex = 0
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2 )
        currentTheme = themes[currentThemeIndex]
        emojiChoices = currentTheme?.emojiSet
        scoreLabel.textColor = currentTheme?.color
        for button in cardButtons {
            button.backgroundColor = currentTheme?.color
        }
        if let name = currentTheme?.name {
            titleLabel.text = "Concentration: \(name)"
        }
        updateView()
    }
}

