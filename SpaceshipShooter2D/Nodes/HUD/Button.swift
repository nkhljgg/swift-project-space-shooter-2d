//
//  Button.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import SpriteKit

typealias TouchUpInsideEventHandler = () -> Void
typealias TouchDownEventHandler = () -> Void
typealias ContinousTouchDownEventHandler = () -> Void

class Button: SKSpriteNode {
    
    var touchUpInsideEventHandler: TouchUpInsideEventHandler?
    var continousTouchDownEventHandler: ContinousTouchDownEventHandler?
    var touchDownEventHandler: TouchDownEventHandler?
    var textureNormal: SKTexture?
    var textureSelected: SKTexture?
    var textureDisabled: SKTexture?
    var titleLabelNode: SKLabelNode?
    var isSelected: Bool = false
    var isEnabled: Bool = true
    
    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(textureNormal: SKTexture!, textureSelected: SKTexture!, textureDisabled: SKTexture!) {
        self.textureNormal = textureNormal
        self.textureSelected = textureSelected
        self.textureDisabled = textureDisabled
        isEnabled = true
        isSelected = false
        
        super.init(texture: textureNormal,
            color: UIColor.brown,
            size: textureNormal.size())
        
        isUserInteractionEnabled = true
    }
    
    convenience init(textureNormal: SKTexture, textureSelected: SKTexture!) {
        self.init(textureNormal:textureNormal,
                  textureSelected:textureSelected,
                  textureDisabled:nil)
    }
    
    convenience init(normalImageNamed: String, selectedImageNamed: String!, disabledImageNamed: String!) {
        let textureNormal = SKTexture(imageNamed: normalImageNamed)
        let textureSelected = SKTexture(imageNamed: selectedImageNamed)
        
        self.init(textureNormal:textureNormal,
                  textureSelected:textureSelected,
                  textureDisabled:nil)
    }
    
    convenience init(normalImageNamed: String, selectedImageNamed: String!) {
        self.init(normalImageNamed: normalImageNamed,
                  selectedImageNamed: selectedImageNamed,
                  disabledImageNamed: nil)
    }
    
    // MARK: - Properties

    var title: String? {
        set {
            if titleLabelNode == nil {
                titleLabelNode = SKLabelNode()
                titleLabelNode!.horizontalAlignmentMode = .center
                titleLabelNode!.verticalAlignmentMode = .center
                
                addChild(titleLabelNode!)
            }
            
            titleLabelNode!.text = newValue!
        }
        get {
            guard let node = titleLabelNode else {
                return nil
            }
            
            return node.text
        }
    }
    
    var font: UIFont? {
        set {
            if titleLabelNode == nil {
                titleLabelNode = SKLabelNode()
                titleLabelNode!.horizontalAlignmentMode = .center
                titleLabelNode!.verticalAlignmentMode = .center
                
                addChild(titleLabelNode!)
            }
            
            titleLabelNode!.fontName = newValue!.fontName
            titleLabelNode!.fontSize = newValue!.pointSize
        }
        get {
            guard let node = titleLabelNode else {
                return nil
            }
            
            return UIFont(name: node.fontName!, size: node.fontSize)
        }
    }
    
    var selected: Bool {
        set {
            isSelected = newValue
            texture = newValue ? textureSelected : textureNormal
        }
        get {
            return isSelected
        }
    }
    
    var enabled: Bool {
        set {
            isEnabled = newValue
            texture = newValue ? textureNormal : textureDisabled
        }
        get {
            return isEnabled
        }
    }
    
}

// MARK: - Touches

extension Button {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }
        
        touchDownEventHandler?()
        selected = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled, let touch = touches.first else { return }
        
        selected = frame.contains(touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }

        touchUpInsideEventHandler?()
        selected = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }

        selected = false
    }
    
}
