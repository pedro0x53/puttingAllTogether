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

public enum Channel: String {
    case booth = "booth"
    case right = "right"
    case left = "left"
}

class AudioManager {
    
    public static let shared: AudioManager = AudioManager()
    public var delegate: ManagerDelegate?
    
    private var sfx: AVAudioPlayer
    public var sfxVolume: Float = UserDefaults.standard.float(forKey: "sfxVolume") {
        didSet {
            sfx.volume = sfxVolume
            UserDefaults.standard.set(sfxVolume, forKey: "sfxVolume")
        }
    }
    private var scene: AVAudioPlayer
    public var sceneVolume: Float = UserDefaults.standard.float(forKey: "sceneVolume") {
        didSet {
            scene.volume = sceneVolume
            UserDefaults.standard.set(sceneVolume, forKey: "sceneVolume")
        }
    }
    private var loop: AVAudioPlayer
    public var loopVolume: Float = UserDefaults.standard.float(forKey: "loopVolume") {
        didSet {
            loop.volume = loopVolume
            UserDefaults.standard.set(loopVolume, forKey: "loopVolume")
        }
    }
    
    private init() {
        sfx = AVAudioPlayer()
        scene = AVAudioPlayer()
        loop = AVAudioPlayer()
        
        if sfxVolume == 0 {
            sfxVolume = 0.5
        }
        
        if sceneVolume == 0 {
            sceneVolume = 0.5
        }
        
        if loopVolume == 0 {
            loopVolume = 0.5
        }
    }
    
    func play(player: PlayerType, urlString: String, channel: String = Channel.booth.rawValue) {
        
        
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
                        sfx.delegate = delegate
                        sfx.play()
                        sfx.volume = sfxVolume
                        setChannel(player: sfx, channel: channel)
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
                        scene.volume = sceneVolume
                        setChannel(player: scene, channel: channel)
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
                        loop.volume = loopVolume
                        setChannel(player: loop, channel: channel)
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
        if loop.volume > 0.0 {
            loop.volume += 0.2
        }
    }
    
    func resume() {
        sfx.play()
        scene.play()
        if loop.volume > 0.0 {
            loop.volume -= 0.2
        }
    }
    
    private func setChannel(player: AVAudioPlayer, channel: String) {
        switch channel {
        case Channel.booth.rawValue:
            player.pan = 0
        case Channel.right.rawValue:
            player.pan = 0.9
        case Channel.left.rawValue:
            player.pan = -0.9
        default:
            break
        }
    }
}
