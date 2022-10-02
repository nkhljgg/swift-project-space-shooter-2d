//
//  LifeIndicator.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import SpriteKit

class LifeIndicator: SKSpriteNode {
    
    fileprivate var titleLabelNode: SKLabelNode?
    fileprivate var lifePoints: Int = 100 {
        didSet {
            update(animated: false)
        }
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(texture: SKTexture!) {
        super.init(texture: texture,
                   color: UIColor.brown,
                   size: texture.size())
        
        // Configure title
        titleLabelNode = SKLabelNode(fontNamed: FontName.Wawati.rawValue)
        titleLabelNode!.fontSize = 14.0
        titleLabelNode!.fontColor = UIColor(white: 1.0, alpha: 0.7)
        titleLabelNode!.horizontalAlignmentMode = .center
        titleLabelNode!.verticalAlignmentMode = .center
        
        update(animated: false)
        
        addChild(titleLabelNode!)
    }
    
    // MARK: - Configuration
    
    func setLifePoints(_ points: Int, animated: Bool) {
        lifePoints = points
        
        update(animated: animated)
    }
    
    fileprivate func update(animated: Bool) {
        titleLabelNode!.text = "\(lifePoints)"
        
        let blendColor = lifeBallColor()
        let blendFactor: CGFloat = 1.0
        
        if animated {
            let colorizeAction = SKAction.colorize(with: blendColor, colorBlendFactor: blendFactor, duration: 0.2)
            let scaleUpAction = SKAction.scale(by: 1.2, duration: 0.2)
            let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleUpAction.reversed()])
            
            titleLabelNode!.color = blendColor
            titleLabelNode!.colorBlendFactor = blendFactor
            
            run(SKAction.group([colorizeAction, scaleActionSequence]))
        } else {
            color = blendColor
            colorBlendFactor = blendFactor
            titleLabelNode!.color = blendColor
            titleLabelNode!.colorBlendFactor = blendFactor
        }
    }
    
    fileprivate func lifeBallColor() -> UIColor {
        var fullBarColorR: CGFloat = 0.0, fullBarColorG: CGFloat = 0.0, fullBarColorB: CGFloat = 0.0, fullBarColorAlpha: CGFloat = 0.0
        var emptyBarColorR: CGFloat = 0.0, emptyBarColorG: CGFloat = 0.0, emptyBarColorB: CGFloat = 0.0, emptyBarColorAlpha: CGFloat = 0.0
        
        UIColor.green.getRed(&fullBarColorR, green: &fullBarColorG, blue: &fullBarColorB, alpha: &fullBarColorAlpha)
        UIColor.red.getRed(&emptyBarColorR, green: &emptyBarColorG, blue: &emptyBarColorB, alpha: &emptyBarColorAlpha)
        
        let resultColorR = emptyBarColorR + CGFloat(lifePoints)/100 * (fullBarColorR - emptyBarColorR)
        let resultColorG = emptyBarColorG + CGFloat(lifePoints)/100 * (fullBarColorG - emptyBarColorG)
        let resultColorB = emptyBarColorB + CGFloat(lifePoints)/100 * (fullBarColorB - emptyBarColorB)
        
        return UIColor(red: resultColorR, green: resultColorG, blue: resultColorB, alpha: 1.0)
    }
    
}
