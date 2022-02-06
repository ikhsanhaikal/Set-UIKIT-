//
//  Set.swift
//  Set(UIKIT)
//
//  Created by Ikhsan on 25/01/2022.
//

import Foundation

struct SetGame<SetColor: Equatable, SetShape: Equatable, SetShading: Equatable, SetNumber: Equatable> {
    typealias SetCard = Card<SetColor, SetShape, SetShading, SetNumber>
    
    var cards: [SetCard]
    var score = 0
    lazy var playingCards: [SetCard] = {
        var tmp = Array(cards[..<12])
        cards.removeFirst(12)
        return tmp
    }()
    
    var selectedCards: [SetCard] = []
    var wasMatched: Bool?
    
    init(setup: () -> [SetCard]) {
        self.cards = setup()
        print(cards.count)
    }
    
    private func check<T> (_ prop1: T, _ prop2: T, _ prop3: T)  -> Bool where T: Equatable {
        if prop1 != prop2 {
            if prop2 == prop3 || prop1 == prop3 {
                return false
            }
            return true
        } else {
            return prop2 != prop3 ? false : true
        }
    }

    private func match(_ threeCards: [SetCard]) -> Bool {
        if check(threeCards[0].color, threeCards[1].color, threeCards[2].color) {
            if check(threeCards[0].shape, threeCards[1].shape, threeCards[2].shape) {
                if check(threeCards[0].shading, threeCards[1].shading, threeCards[2].shading) {
                    if check(threeCards[0].number, threeCards[1].number, threeCards[2].number) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    mutating func drawCards()  {
        if let status = wasMatched, status {
            replace()
            score += 3
            selectedCards.removeFirst(3)
            wasMatched = nil
            return
        }
        playingCards += cards[..<3]
        cards.removeFirst(3)
    }
    

    private mutating func replace() {
        selectedCards[..<3].forEach {
            let c = self.playingCards.firstIndex(of: $0)!
            if !cards.isEmpty {
                playingCards[c] = cards.remove(at: cards.count - 1)                
            } else {
                playingCards.remove(at: playingCards.firstIndex(of: $0)!)
            }
        }
    }
    
    mutating func chooseCard(card: SetCard) {
        if !selectedCards.contains(card) {
            selectedCards.append(card)
            if selectedCards.count == 3 {
                if match(Array(selectedCards)) {
                    wasMatched = true
                } else {
                    wasMatched = false
                }
            } else if selectedCards.count > 3 {
                if wasMatched != nil && wasMatched! {
                    score += 3
                    replace()
                }
                selectedCards.removeFirst(3)
                wasMatched = nil
            }
        } else {
            selectedCards.removeAll(where: {$0 == card})
        }
    }
}

