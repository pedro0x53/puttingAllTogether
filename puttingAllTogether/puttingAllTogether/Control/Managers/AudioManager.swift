//
//  AudioManager.swift
//  puttingAllTogether
//
//  Created by Lucas Fernandes on 15/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import Foundation
import AVFoundation

public enum PlayerType {
    case sfx
    case scene
    case loop
}

class AudioManager {
    
    public static let shared: AudioManager = AudioManager()
    public var delegate: ManagerDelegate?
    private var sfx: AVAudioPlayer
    public var sfxVolume: Float = 0.5 {
        didSet {
            sfx.volume = sfxVolume
        }
    }
    private var scene: AVAudioPlayer
    public var sceneVolume: Float = 0.5 {
        didSet {
            scene.volume = sceneVolume
        }
    }
    private var loop: AVAudioPlayer
    public var loopVolume: Float = 0.5{
        didSet {
            loop.volume = loopVolume
        }
    }
    
    private init() {
        sfx = AVAudioPlayer()
        scene = AVAudioPlayer()
        loop = AVAudioPlayer()
    }
    
    
    func play(player: PlayerType, urlString: String) {
        
        
        let urlBundle = Bundle.main.path(forResource: urlString, ofType: "mp3")
                
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlBundle = urlBundle else {
                    return
                }
                
                guard let url = URL(string: urlBundle) else {
                    return
                }
                
                switch(player) {
                
                case .sfx:
                    do {
                        sfx = try AVAudioPlayer(contentsOf: url)
                        sfx.play()
                    }
                    catch {
                        print("""
                            Error: Failed to play SFX audio.
                            \(error.localizedDescription)
                        """)
                    }
                    
                case .scene:
                    do {
                        scene = try AVAudioPlayer(contentsOf: url)
                        scene.delegate = delegate
                        scene.play()
                    }
                    catch {
                        print("""
                            Error: Failed to play Scene audio.
                            \(error.localizedDescription)
                        """)
                    }
                case .loop:
                    do {
                        loop = try AVAudioPlayer(contentsOf: url)
                        loop.play()
                    }
                    catch {
                        print("""
                            Error: Failed to play Loop audio.
                            \(error.localizedDescription)
                        """)
                    }
                }
                
            }
            catch {
                print("""
                    Error: Failed to configure Audio Session.
                    \(error.localizedDescription)
                """)
            }
    }
    
    func pause() {
        sfx.pause()
        scene.pause()
        loop.pause()
    }
    
    func resume() {
        sfx.play()
        scene.play()
        loop.play()
    }
}
