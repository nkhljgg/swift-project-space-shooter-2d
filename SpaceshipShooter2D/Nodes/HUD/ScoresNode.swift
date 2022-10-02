//
//  ScoresNode.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import SpriteKit

class ScoresNode: SKLabelNode {
    var value: Int = 0 {
        didSet {
            update()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        fontSize = 18.0
        fontColor = UIColor.black.withAlphaComponent(0.7)
        fontName = FontName.Wawati.rawValue
        horizontalAlignmentMode = .left;
        
        update()
    }
    
    
    
    func update() {
        text = "Score: \(value)"
    }
    
}
