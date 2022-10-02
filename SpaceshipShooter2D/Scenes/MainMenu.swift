//
//  MainMenu.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import SpriteKit

protocol MainMenuSceneDelegate: class {
    
    func mainMenuSceneDidTapResumeButton(_ mainMenuScene: MainMenuScene)
    func mainMenuSceneDidTapRestartButton(_ mainMenuScene: MainMenuScene)
    func mainMenuSceneDidTapInfoButton(_ mainMenuScene: MainMenuScene)
}

class MainMenuScene: MenuScene {
    
    private var infoButton: Button?
    private var resumeButton: Button?
    private var restartButton: Button?
    private var buttons: [Button]?
    weak var mainMenuSceneDelegate: MainMenuSceneDelegate?
    
    // MARK: - Scene lifecycle
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        configureButtons()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // Track event
        Analytics.sharedInstance.trackScene("MainMenuScene")
    }

    // MARK: - Configuration

    private func configureButtons() {
        // Resume button.
        resumeButton = Button(normalImageNamed: ImageName.MenuButtonResumeNormal.rawValue,
                              selectedImageNamed: ImageName.MenuButtonResumeNormal.rawValue)
        resumeButton!.touchUpInsideEventHandler = resumeButtonTouchUpInsideHandler()
        
        // Restart button.
        restartButton = Button(normalImageNamed: ImageName.MenuButtonRestartNormal.rawValue,
                               selectedImageNamed: ImageName.MenuButtonRestartNormal.rawValue)
        restartButton!.touchUpInsideEventHandler = restartButtonTouchUpInsideHandler()
        
        buttons = [resumeButton!, restartButton!]
        let horizontalPadding: CGFloat = 20.0
        var totalButtonsWidth: CGFloat = 0.0
        
        // Calculate total width of the buttons area.
        for (index, button) in buttons!.enumerated() {
            totalButtonsWidth += button.size.width
            totalButtonsWidth += index != buttons!.count - 1 ? horizontalPadding : 0.0
        }
        
        // Calculate origin of first button.
        var buttonOriginX = frame.width / 2.0 + totalButtonsWidth / 2.0
        
        // Place buttons in the scene.
        for (_, button) in buttons!.enumerated() {
            button.position = CGPoint(x: buttonOriginX - button.size.width/2,
                                      y: button.size.height * 1.1)
            addChild(button)
            
            buttonOriginX -= button.size.width + horizontalPadding
            
            let rotateAction = SKAction.rotate(byAngle: CGFloat(.pi/180.0 * 5.0), duration: 2.0)
            let sequence = SKAction.sequence([rotateAction, rotateAction.reversed()])
            button.run(SKAction.repeatForever(sequence))
        }
    }
    
    private func resumeButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        return { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainMenuSceneDelegate?.mainMenuSceneDidTapResumeButton(strongSelf)
        }
    }
    
    private func restartButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        return { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainMenuSceneDelegate?.mainMenuSceneDidTapRestartButton(strongSelf)
        }
    }
    
    private func infoButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        return { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainMenuSceneDelegate?.mainMenuSceneDidTapInfoButton(strongSelf)
        }
    }
    
}
