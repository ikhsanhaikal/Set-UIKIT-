//
//  ViewController.swift
//  Set(UIKIT)
//
//  Created by Ikhsan on 24/01/2022.
//

import UIKit

class ViewController: UIViewController {
    typealias SetCard = SetGame<String, String, String, String>.SetCard
    private lazy var game = SetGame<String, String, String, String> {
        var allCards: [SetCard] = []
        var tally = 0
        "red,blue,green".split(separator: ",").forEach { color in
            "circle,square,triangle".split(separator: ",").forEach { shape in
                "one,two,three".split(separator: ",").forEach { number in
                    "striped,filled,stroked".split(separator: ",").forEach { shading in
                        allCards.append(SetCard(identifier: tally, color: String(color), shape: String(shape), shading: String(shading), number: String(number)))
                        tally += 1
                    }
                }
            }
        }
        return allCards.shuffled()
    }
    
    @IBOutlet var cards: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        cards.dropLast(12).enumerated().forEach { (index, buttonCard) in
            let type = game.cards[index]
            let color: UIColor
            var shape: String
            
            switch type.color {
            case "green":
                color = UIColor.systemGreen
            case "blue":
                color = UIColor.blue
            case "red":
                color = UIColor.red
            default:
                color = UIColor.secondarySystemFill
            }
            
            switch type.shape {
            case "circle":
                shape = "●"
            case "square":
                shape = "■"
            case "triangle":
                shape = "▲"
            default:
                shape = "?"
            }
            
            switch type.number {
            case "one":
                shape = shape.multiply(n: 1)
            case "two":
                shape = shape.multiply(n: 2)
            case "three":
                shape = shape.multiply(n: 3)
            default:
                shape = "?"
            }

            
            let attributedString = NSAttributedString(string: shape, attributes: [.foregroundColor: type.shading == "striped" ? color.withAlphaComponent(0.25) : color, .strokeWidth: type.shading == "stroked" ? 10 : -1 ])
            buttonCard.setAttributedTitle(attributedString, for: .normal)
            buttonCard.layer.cornerRadius = 8
        }
        
        cards.dropFirst(24 - 12).forEach {
            $0.backgroundColor = .init(white: 1.0, alpha: 0)
            $0.isEnabled = false
        }
    }
    
    @IBAction func pickACard(_ sender: UIButton) {
        
    }
    
}

extension String {
    func multiply(n: Int) -> String {
        var newString = ""
        for _ in 0..<n {
            newString += self
        }
        return newString
    }
}
