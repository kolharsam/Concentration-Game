//
//  Concentration.swift
//  Concentration
//
//  Created by smallcase_kolhar730 on 30/06/19.
//  Copyright © 2019 smallcase_kolhar730. All rights reserved.
//

import Foundation

class Concentration {
    
    var theOnlyFaceUpCard: Int?
    
    var scoreKeeper: Int = 0
    
    var prevDateMatched = Date()
    
    init(numberOfPairsOfCards: Int) {
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        
        // Shuffling the cards
        cards.shuffle()
    }
    
    var cards = [Card]()
    
    func clearGame () {
        cards = []
        theOnlyFaceUpCard = nil
    }
    
    func scoreGiver(start: Date, end: Date) -> Int {
        var score = 0
        if (Int(DateInterval(start: start, end: end).duration) < 10) {
            score = 5
        } else {
            score = 1
        }
        return score
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = theOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    cards[matchIndex].dateMatched = Date()
                    cards[index].dateMatched = cards[matchIndex].dateMatched
                    self.scoreKeeper += scoreGiver(start: self.prevDateMatched, end: cards[matchIndex].dateMatched)
                    self.prevDateMatched = cards[matchIndex].dateMatched
                }
                cards[index].isFaceUp = true
                theOnlyFaceUpCard = nil
            }
                
            else {
                for flipCardsDown in cards.indices {
                    cards[flipCardsDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                theOnlyFaceUpCard = index
            }
        }
    }
}
