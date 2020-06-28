//
//  GameplayController.swift
//  puttingAllTogether
//
//  Created by Pedro Sousa on 02/06/20.
//  Copyright © 2020 Brabo. All rights reserved.
//

import UIKit
import AVFoundation

class GameplayController: UIViewController {
    
    private let gameplay: Gameplay = Gameplay.shared
    public var state: Bool = false
    
    public static var menu: [MenuItem] = MenuManager.getMenu(type: .gameplay)
    
    private let chapterManager: ChapterSceneManager = ChapterSceneManager.shared
    
    private let audioManager: AudioManager = AudioManager.shared
    private var playingSFX: Bool = false
    private var SFXId: Int = 0
    
    private let gestureManager: GesturesManager = GesturesManager.shared
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
        view = gameplay
        gameplay.menu.delegate = self
        gameplay.menu.dataSource = self
        menuCallers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Uncomment these lines to reset the User Deafaults save
        UserDefaults.standard.set(0, forKey: "chapterId")
        UserDefaults.standard.set(0, forKey: "sceneId")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gestureManager.delegate = self
        audioManager.delegate = self
        
        if(state == false) {
            audioManager.play(player: .loop, urlString: "cave")
            tell(scene: chapterManager.currentScene)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func menuCallers() {
        self.gameplay.pauseBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pause)))
        
        self.gameplay.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(callMenu)))
    }
    
    func pausePlayers() {
        audioManager.pause()
        state = true
        audioManager.play(player: .helper, urlString: "pause_feedback")
    }
    
    func resumePlayers() {
        audioManager.resume()
        state = false
        audioManager.play(player: .helper, urlString: "resume_feedback")
    }
    
    @objc public func callMenu(pinch: UIPinchGestureRecognizer) {
        if(pinch.scale > 1) {
            self.gameplay.overlay.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.gameplay.overlay.alpha = 1
            }, completion:  nil)
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.gameplay.overlay.alpha = 0
            }, completion: { (completion) in
                self.gameplay.overlay.isHidden = true
            })
        }
    }
}

extension GameplayController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameplayController.menu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        
        cell.configure(label: GameplayController.menu[indexPath.row].label,
                       icon: GameplayController.menu[indexPath.row].icon)
        
        let action = GameplayController.menu[indexPath.row].action
        switch action {
        case .start:
            break
        case .resume:
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resume)))
        case .preferences:
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(preferences)))
        case .exit:
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exit)))
        }
        
        return cell
    }
    
    @objc private func pause() {
        self.gameplay.overlay.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.gameplay.overlay.alpha = 1
        }, completion:  nil)
        pausePlayers()
    }
    
    @objc private func resume() {
        UIView.animate(withDuration: 0.5, animations: {
            self.gameplay.overlay.alpha = 0
        }, completion: { (completion) in
            self.gameplay.overlay.isHidden = true
        })
        resumePlayers()
    }
    
    @objc private func preferences() {
        let controller = PreferencesController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func exit() {
        print("Exit Selector")
    }
}

extension GameplayController: ManagerDelegate {
    private func tell(scene: Scene) {
        let url = scene.audioURL
        self.audioManager.play(player: .scene, urlString: url)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if self.playingSFX {
            if self.SFXId < self.chapterManager.currentScene.sfx.count - 1 {
                self.SFXId += 1
                playSFX()
            } else {
                self.SFXId = 0
                self.playingSFX = false
                checkGestures()
            }
        } else {
            checkSFX()
        }
    }
    
    func playNextScene(plus: Int = 1) {
        if self.chapterManager.currentChapter.lastChapter {
            //Credits on the roll
            UserDefaults.standard.set(0, forKey: "chapterId")
            UserDefaults.standard.set(0, forKey: "sceneId")
            audioManager.play(player: .helper, urlString: "gameover_feedback")
            self.navigationController?.popViewController(animated: true)
        } else {
            self.chapterManager.updateScene(plus: plus)
            tell(scene: self.chapterManager.currentScene)
        }
    }
    
    func playSFX() {
        let sfx = self.chapterManager.currentScene.sfx[self.SFXId]
        let channel = sfx.channel
        self.audioManager.play(player: .sfx, urlString: sfx.audioURL, channel: channel)
    }
    
    func checkSFX() {
        if self.chapterManager.currentScene.hasSFX {
            if self.chapterManager.currentScene.sfx.count > 0 {
                self.playingSFX = true
                playSFX()
            }
        } else {
            checkGestures()
        }
    }
    
    func gestureRecognized(gesture: GesturesType) {
        audioManager.play(player: .helper, urlString: "gesture_2_feedback")
        self.gestureManager.deactivateSwipes(gameplay: self.gameplay,
                                             gestures: .up, .right, .down, .left)
        
        let gestures = self.chapterManager.currentScene.gestures
        var incrementer = 1
        if let index = gestures.firstIndex(of: gesture.rawValue) {
            incrementer = self.chapterManager.currentScene.nextSceneIncrementer[index]
        }
        
        playNextScene(plus: incrementer)
    }
       
    func checkGestures() {
        if self.chapterManager.currentScene.hasGestures {
            for gesture in self.chapterManager.currentScene.gestures {
                switch gesture {
                case GesturesType.up.rawValue:
                    self.gestureManager.activateSwipes(gameplay: self.gameplay,
                                                       gestures: .up)
                case GesturesType.right.rawValue:
                    self.gestureManager.activateSwipes(gameplay: self.gameplay,
                                                       gestures: .right)
                case GesturesType.down.rawValue:
                    self.gestureManager.activateSwipes(gameplay: self.gameplay,
                                                       gestures: .down)
                case GesturesType.left.rawValue:
                    self.gestureManager.activateSwipes(gameplay: self.gameplay,
                                                       gestures: .left)
                default:
                    break
                }
            }
            audioManager.play(player: .helper, urlString: "gesture_1_feedback")
        } else {
            playNextScene()
        }
    }
}
