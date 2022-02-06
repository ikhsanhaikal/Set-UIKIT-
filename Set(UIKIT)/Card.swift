//
//  Card.swift
//  Set(UIKIT)
//
//  Created by Ikhsan on 25/01/2022.
//

import Foundation

struct Card<SetColor, SetShape, SetShading, SetNumber>: Equatable, Hashable {
    static func == (lhs: Card<SetColor, SetShape, SetShading, SetNumber>, rhs: Card<SetColor, SetShape, SetShading, SetNumber>) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    var identifier: Int
    var color: SetColor
    var shape: SetShape
    var shading: SetShading
    var number: SetNumber
}
