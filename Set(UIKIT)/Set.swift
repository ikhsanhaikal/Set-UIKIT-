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
    var selectedCards: [SetCard]

    func check<T> (_ prop1: T, _ prop2: T, _ prop3: T)  -> Bool where T: Equatable {
        if prop1 != prop2 {
            if prop2 == prop3 || prop1 == prop3 {
                return false
            }
            return true
        } else {
            return prop2 != prop3 ? false : true
        }
    }

    func match(_ cards: [SetCard]) -> Bool {
        if check(cards[0].color, cards[1].color, cards[2].color) {
            if check(cards[0].shape, cards[1].shape, cards[2].shape) {
                if check(cards[0].number, cards[1].number, cards[2].number) {
                    if check(cards[0].shading, cards[1].shading, cards[2].shading) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    mutating func chooseCard(card: SetCard) {
        selectedCards.append(card)
        if selectedCards.count > 3 {
            let cards = selectedCards.dropLast(2)
            if match(Array(cards)) {
                cards.forEach { card in
                    self.cards.removeAll(where: { $0 == card })
                }
            }
            selectedCards.removeFirst(3)
        }
    }
}

