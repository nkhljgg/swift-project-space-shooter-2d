//
//  ViewController.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import UIKit
import SpriteKit

class GameController: UIViewController {
    
    private struct Constants {
        static let sceneTransistionDuration: Double = 0.2
    }
    
    private var gameScene: GameScene?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        startNewGame(animated: false)
        
        // Start the background music
        MusicPlayer.shared.playBackgroundMusic()
    }
    
    // MARK: - Appearance

    override var shouldAutorotate : Bool {
        return true
    }

    // Make sure only the landscape mode is supported
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }

    override var prefersStatusBarHidden : Bool {
        // Hide the status bar
        return true
    }
    
}

// MARK: - Scene handling

extension GameController {
    
    private func startNewGame(animated: Bool = false) {
        // Recreate game scene
        gameScene = GameScene(size: view.frame.size)
        gameScene!.scaleMode = .aspectFill
        gameScene!.gameSceneDelegate = self
        
        show(gameScene!, animated: animated)
    }
    
    private func resumeGame(animated: Bool = false, completion:(()->())? = nil) {
        let skView = view as! SKView
        
        if animated {
            // Show game scene
            skView.presentScene(gameScene!,
                                transition: SKTransition.crossFade(withDuration: Constants.sceneTransistionDuration))
            
            // Remove the menu scene and unpause the game scene after it was shown
            let delay = Constants.sceneTransistionDuration * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + delay / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time, execute: { [weak self] in
                self?.gameScene!.isPaused = false
                
                // Call completion handler
                completion?()
            })
        }
        else {
            // Remove the menu scene and unpause the game scene after it was shown
            skView.presentScene(gameScene!)
            gameScene!.isPaused = false

            // Call completion handler
            completion?()
        }
    }
    
    private func showMainMenuScene(animated: Bool) {
        // Create main menu scene
        let scene = MainMenuScene(size: view.frame.size)
        scene.mainMenuSceneDelegate = self
        
        // Pause the game
        gameScene!.isPaused = true
        
        // Show it
        show(scene, animated: animated)
    }
    
    private func showGameOverScene(animated: Bool) {
        // Create game over scene
        let scene = GameOverScene(size: view.frame.size)
        scene.gameOverSceneDelegate = self
        
        // Pause the game
        gameScene!.isPaused = true
        
        // Show it
        show(scene, animated: animated)
    }

    private func show(_ scene: SKScene, scaleMode: SKSceneScaleMode = .aspectFill, animated: Bool = true) {
        guard let skView = view as? SKView else {
            preconditionFailure()
        }

        scene.scaleMode = .aspectFill

        if animated {
            skView.presentScene(scene, transition: SKTransition.crossFade(withDuration: Constants.sceneTransistionDuration))
        } else {
            skView.presentScene(scene)
        }
    }
    
}

// MARK: - GameSceneDelegate

extension GameController : GameSceneDelegate {

    func didTapMainMenuButton(in gameScene: GameScene) {
        // Show initial, main menu scene
        showMainMenuScene(animated: true)
    }
    
    func playerDidLose(withScore score: Int, in gameScene:GameScene) {
        // Player lost, show game over scene
        showGameOverScene(animated: true)
    }
    
}

// MARK: - MainMenuSceneDelegate

extension GameController : MainMenuSceneDelegate {
    
    func mainMenuSceneDidTapResumeButton(_ mainMenuScene: MainMenuScene) {
        resumeGame(animated: true) {
            // Remove main menu scene when game is resumed
            mainMenuScene.removeFromParent()
        }
    }
    
    func mainMenuSceneDidTapRestartButton(_ mainMenuScene: MainMenuScene) {
        startNewGame(animated: true)
    }
    
    func mainMenuSceneDidTapInfoButton(_ mainMenuScene:MainMenuScene) {
        // Create a simple alert with copyright information
        let alertController = UIAlertController(title: "About",
                                                message: "Made by Nikhil Jaggi",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        // Show it
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - GameOverSceneDelegate

extension GameController : GameOverSceneDelegate {
    
    func gameOverSceneDidTapRestartButton(_ gameOverScene: GameOverScene) {
        // TODO: Remove game over scene here
        startNewGame(animated: true)
    }
    
}

// MARK: - Configuration

extension GameController {
    
    private func configureView() {
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        
        // Enable debugging
        #if DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
        #endif
    }
    
}
