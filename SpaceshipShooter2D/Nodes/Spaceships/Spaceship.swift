//
//  Spaceship.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import SpriteKit

class Spaceship: SKSpriteNode, HealthProtocol {
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    // MARK: - LifePointsProtocol
    
    var didRunOutOfLifePointsEventHandler: DidRunOutOfHealth? = nil
    
    var lifePoints: Int = 0 {
        didSet {
            if lifePoints <= 0 {
                didRunOutOfLifePointsEventHandler?(self)
            }
        }
    }
    
}
