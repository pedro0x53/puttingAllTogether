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
    private var sfx: Player
    private var scene: Player
    private var loop: AVAudioPlayer
    
    public var position: Int = 0
    public var audios: [Audio] = []
    
    private init() {
        sfx = Player()
        scene = Player()
        loop = AVAudioPlayer()
    }
    
    func configurePlayer() {
        
        let audio = audios[position]
        
        let urlString = Bundle.main.path(forResource: audio.name, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            
            // exemplo com o SFX, falta mudar pra array e ficar dinâmico pra qualquer tipo de player
            sfx = try AVAudioPlayer(contentsOf: URL(string: urlString)!) as! Player
            
//            guard let sfx = sfx else {
//                return
//            }
            
            sfx.play()
        }
        catch {
            print("error ocurred")
        }
        
    }
    
    func play(player: PlayerType, urlString: String) {
        
        
        let urlBundle = Bundle.main.path(forResource: urlString, ofType: "mp3")
                
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlBundle = urlBundle else {
                    return
                }
                
                // exemplo com o SFX, falta mudar pra array e ficar dinâmico pra qualquer tipo de player
                //sfx = try AVAudioPlayer(contentsOf: URL(string: urlString)!) as! Player
                
    //            guard let sfx = sfx else {
    //                return
    //            }
                
                guard let url = URL(string: urlBundle) else {
                    return
                }
                
                switch(player) {
                
                case .sfx:
                    do {
                        sfx = try AVAudioPlayer(contentsOf: url) as! Player
                        sfx.identifier = .sfx
                        sfx.delegate = delegate
                        sfx.play()
                    }
                    catch {
                        print("error ocurred")
                    }
                    
                case .scene:
                    do {
                        scene = try AVAudioPlayer(contentsOf: url) as! Player
                        scene.identifier = .scene
                        scene.delegate = delegate
                        scene.play()
                    }
                    catch {
                        print("error ocurred")
                    }
                case .loop:
                    do {
                        //loop = try AVAudioPlayer(contentsOf: url) as! Player
                        loop = try AVAudioPlayer(contentsOf: url)
                        //loop.identifier = .loop
                        loop.delegate = delegate
                        loop.play()
                        print("Deu play")
                    }
                    catch {
                        print("error ocurred")
                    }
                }
                
                //sfx.play()
            }
            catch {
                print("error ocurred")
            }
        
            print("saiu do play")
        
//        switch(player) {
//
//        case .sfx:
//            do {
//                sfx = try AVAudioPlayer(contentsOf: url) as! Player
//                sfx.identifier = .sfx
//                sfx.delegate = delegate
//                sfx.play()
//            }
//            catch {
//                print("error ocurred")
//            }
//
//        case .scene:
//            do {
//                scene = try AVAudioPlayer(contentsOf: url) as! Player
//                scene.identifier = .scene
//                scene.delegate = delegate
//                scene.play()
//            }
//            catch {
//                print("error ocurred")
//            }
//        case .loop:
//            do {
//                loop = try AVAudioPlayer(contentsOf: url) as! Player
//                loop.identifier = .loop
//                loop.delegate = delegate
//                loop.play()
//                print("Deu play")
//            }
//            catch {
//                print("error ocurred")
//            }
//        }
    }
}

struct Audio {
    let name: String
    let group: String
}
