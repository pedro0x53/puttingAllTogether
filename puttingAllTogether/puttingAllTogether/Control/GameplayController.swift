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
    private let gestureManager: GesturesManager = GesturesManager.shared
    
    public static var menu: [MenuItem] = MenuManager.getMenu(type: .gameplay)
    
    var audioManager = AudioManager.shared
    
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
        gestureManager.delegate = self
        self.gameplay.menu.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tell()
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
    }
    
    func resumePlayers() {
        audioManager.resume()
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

extension GameplayController: ManagerDelegate {
    private func tell() {
        print("Gameplay logic goes here...")
        gestureManager.activateSwipes(gameplay: gameplay, gestures: .up, .right, .down, .left)
    }
    
    func playerDidFinished() {
        print("Audio Finished")
    }
    
    func gestureRecognized() {
        print("Gesture Recognized")
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
