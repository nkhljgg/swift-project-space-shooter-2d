//
//  MusicManager.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21 .
//

import UIKit
import AVFoundation

class MusicPlayer: NSObject {
    
    static let shared = MusicPlayer()
    private var backgroundMusicPlayer: AVAudioPlayer!
    
    override init() {
        super.init()
        configureBackgroundMusicPlayer()
    }
    
}

// MARK - Background Music

extension MusicPlayer{

    private func configureBackgroundMusicPlayer() {
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!)
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: fileURL)
            backgroundMusicPlayer.numberOfLoops = -1;
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.volume = 0.5
        } catch let error as NSError {
            backgroundMusicPlayer = nil
            
            print(error.localizedDescription)
        }
    }
    
    func toggleBackgroundMusic() {
        if (backgroundMusicPlayer!.isPlaying) {
            backgroundMusicPlayer!.pause()
        }
        else {
            backgroundMusicPlayer!.play()
        }
    }
    
    func playBackgroundMusic() {
        backgroundMusicPlayer!.play()
    }
    
    func pauseBackgroundMusic() {
        backgroundMusicPlayer!.pause()
    }
}
